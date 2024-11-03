open Ast
open TypedAst
open Env
open Errors
open Symbol

exception TypeError of error


let library_functions : (string * funtype) list = [
  (* print_int: takes an int, returns unit *)
  ("print_integer", FunTyp { ret = Void; params = [Param {paramname = Ident {sym = symbol "int"} ; typ = TypedAst.Int}] });


  (* read_int: takes no parameters, returns int *)
  ("read_integer", FunTyp { ret = Int; params = [] });

  (* Add more standard library functions as needed *)
]
let stm_counter = ref 0

let convert_binop op =
  match op with
  | Ast.Plus _ -> TypedAst.Plus
  | Ast.Minus _ -> TypedAst.Minus
  | Ast.Mul _ -> TypedAst.Mul
  | Ast.Div _ -> TypedAst.Div
  | Ast.Rem _ -> TypedAst.Rem
  | Ast.Lt _ -> TypedAst.Lt
  | Ast.Le _ -> TypedAst.Le
  | Ast.Gt _ -> TypedAst.Gt
  | Ast.Ge _ -> TypedAst.Ge
  | Ast.Lor _ -> TypedAst.Lor
  | Ast.Land _ -> TypedAst.Land
  | Ast.Eq _ -> TypedAst.Eq
  | Ast.NEq _ -> TypedAst.NEq

  let convert_unop op =
    match op with 
    | Ast.Neg _ -> TypedAst.Neg
    | Ast.Lnot _-> TypedAst.Lnot

  let convert_type tp = 
    match tp with
    | Ast.Int _-> TypedAst.Int
    | Ast.Bool _-> TypedAst.Bool

  
  let rec infertype_expr env (expr: Ast.expr) =
    match expr with
    | Integer {int; _} -> (TAst.Integer {int}, TAst.Int)
    
    | Boolean {bool; _} -> (TAst.Boolean {bool}, TAst.Bool)
  
    | BinOp {left; op; right; loc} ->
        let tleft, tpleft = infertype_expr env left in
        let tright, tpright = infertype_expr env right in
        let result_type = match op, tpleft, tpright with
          | (Plus _ | Minus _| Mul _| Div _| Rem _), TAst.Int, TAst.Int -> TAst.Int
          | (Lt _| Le _| Gt _| Ge _), TAst.Int, TAst.Int -> TAst.Bool
          | (Eq _| NEq _), tp1, tp2 when tp1 = tp2 && tp1 <> TAst.Void -> TAst.Bool
          | (Lor _| Land _), TAst.Bool, TAst.Bool -> TAst.Bool
          | (Plus _| Minus _| Mul _| Div _| Rem _), tp1, _tp2 ->
            raise (TypeError (TypeMismatch {expected = TAst.Int; actual = tp1; loc = loc}))
          | (Lt _| Le _| Gt _| Ge _), tp1, _tp2 ->
              raise (TypeError (TypeMismatch {expected = TAst.Int; actual = tp1; loc = loc}))
          | (Eq _| NEq _), tp1, tp2 when tp1 <> tp2 ->
              raise (TypeError (TypeMismatch {expected = tp1; actual = tp2; loc = loc})) 
          | (Eq _| NEq _), TAst.Void, _ ->
              raise (TypeError (InvalidVoidUsage {name = "Equality operator used with void type"}))
          | (Lor _| Land _), tp1, _tp2 ->
              raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = tp1; loc = loc}))
          | _ -> raise (TypeError (InvalidExpression {msg = "Invalid binary operation"})) in
        (TAst.BinOp {left = tleft; op = convert_binop op; right = tright; tp = result_type}, result_type)
        
    | UnOp {op; operand; loc} ->
      let toperand, operand_type = infertype_expr env operand in
      let result_type = match op with
        | Lnot _ when operand_type = TAst.Bool -> TAst.Bool
        | Neg _ when operand_type = TAst.Int -> TAst.Int
        | Lnot _-> raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = operand_type; loc = loc}))
        | Neg _-> raise (TypeError (TypeMismatch {expected = TAst.Int; actual = operand_type; loc = loc}))
      in 
      (TAst.UnOp {op = convert_unop op; operand = toperand; tp = result_type}, result_type)
  
    | Call {fname; args; loc} ->
      let Ident {name; _} = fname in
      begin match lookup_fun env name with
      | Some (FunTyp {ret; params}) -> 
          if List.length args <> List.length params then
            raise (TypeError (ArityMismatch {
              expected = List.length params;
              actual = List.length args
            }));
          let targs = List.map2 (fun arg (Param {typ; _}) -> 
            let targ, targ_type = infertype_expr env arg in
            if targ_type <> typ then
              raise (TypeError (TypeMismatch {expected = typ; actual = targ_type; loc = loc}));
            targ
          ) args params in
          (TypedAst.Call {fname = TypedAst.Ident {sym = Symbol.symbol name}; args = targs; tp = ret}, ret)
      | None -> 
          raise (TypeError (UndefinedFunction {name}))
      end
  
      | Lval lval ->
        let tlval, tp = infertype_lval env lval in
        (TAst.Lval tlval, tp)
  
    | Assignment {lvl; rhs; loc} ->
      let tlvl, tplvl = infertype_lval env lvl in
      let trhs, tprhs = infertype_expr env rhs in
      if tplvl <> tprhs then
        raise (TypeError (TypeMismatch {expected = tplvl; actual = tprhs; loc = loc}));
      (TAst.Assignment {lvl = tlvl; rhs = trhs; tp = tplvl}, tplvl)
  
      and infertype_lval env = function
      | Var id ->
          let Ident {name; _} = id in
          match lookup_var env name with
          | Some tp -> 
              (TypedAst.Var {ident = TypedAst.Ident {sym = Symbol.symbol name}; tp}, tp)
          | None -> raise (TypeError (UndefinedVariable {name}))

    let make_typed_declaration name tp body = 
      TypedAst.Declaration {
        name = TypedAst.Ident { sym = Symbol.symbol name };
        tp = tp;
        body = body;
      }

    let process_single_decl (env, typed_decls) (Ast.Declaration {name; tp; body; loc}) =
      (* Extract the name from the ident *)
      let Ident {name = id_name; _} = name in
      
      (* Infer the type of the initialization expression *)
      let texpr, expr_tp = infertype_expr env body in
      
      (* Convert the explicitly declared type, if present *)
      let declared_tp = match tp with
        | Some declared_tp -> convert_type declared_tp
        | None -> expr_tp (* If no type is provided, infer from expression *)
      in
      
      (* Type check *)
      if declared_tp <> expr_tp then
        raise (TypeError (TypeMismatch {
          expected = declared_tp;
          actual = expr_tp;
          loc = loc
        }));
      
      (* Insert into environment *)
      let new_env = insert_local_decl env id_name declared_tp in
      
      (* Create and accumulate typed declaration *)
      let typed_decl = make_typed_declaration id_name declared_tp texpr in
      (new_env, typed_decl :: typed_decls)
    

      let typecheck_declaration_block (env : environment) (Ast.DeclBlock decls) =
        let new_env, typed_decls = 
          List.fold_left 
            process_single_decl 
            (env, []) 
            decls 
        in
        (TypedAst.DeclBlock (List.rev typed_decls), new_env)

    let rec typecheck_statement env (stm: Ast.statement) =
      match stm with

      | Ast.VarDeclStm (DeclBlock declarations) ->
        let final_env, typed_decls = 
          List.fold_left 
            process_single_decl 
            (env, []) 
            declarations 
        in
        TypedAst.VarDeclStm (TypedAst.DeclBlock (List.rev typed_decls)), 
        final_env
        
      | BreakStm _ ->
          if not env.in_loop then
            raise (TypeError (InvalidBreakContinue {msg = "Break statement outside of loop"}));
          TypedAst.BreakStm, env
    
      | ContinueStm _ ->
          if not env.in_loop then
            raise (TypeError (InvalidBreakContinue {msg = "Continue statement outside of loop"}));
          TypedAst.ContinueStm, env
    
      (* Handle other cases, including loops like WhileStm and ForStm below *)
    
      | WhileStm {cond; body; loc} ->
          let tcond, cond_tp = infertype_expr env cond in
          if cond_tp <> TAst.Bool then
            raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = cond_tp; loc = loc}));
          let new_env = { env with in_loop = true } in (* Enter the loop *)
          let tbody, _ = typecheck_statement new_env body in
          let updated_env = { env with in_loop = false } in (* Exit the loop *)
          TAst.WhileStm {cond = tcond; body = tbody}, updated_env
    
      | ForStm {init; cond; update; body; loc} ->
        let tinit, env_after_init = match init with
          | Some (FIExpr expr) -> 
              let texpr, _ = infertype_expr env expr in
              (Some (TypedAst.FIExpr texpr), env)  (* Handle FIExpr case *)
          | Some (FIDecl decl_block) ->
              let tdecl_block, new_env = typecheck_declaration_block env decl_block in
              (Some (TypedAst.FIDecl tdecl_block), new_env)  (* Handle FIDecl case *)
          | None -> (None, env) in
          
        (* Handle the conditional expression *)
        let tcond, cond_tp = 
          match cond with
          | Some expr -> 
              let texpr, tp = infertype_expr env_after_init expr in
              (* Ensure the type is boolean *)
              if tp <> TAst.Bool then
                raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = tp; loc = loc}));
              (Some texpr, tp)
          | None -> 
              (* Handle the case when cond is None *)
              (None, TAst.Bool)  (* Assume a default type for None condition, adjust as needed *)
    
        in
    
        let titer, _ = match update with
          | Some expr -> 
              let texpr, tp = infertype_expr env_after_init expr in
              (* Check for type consistency if necessary *)
              (Some texpr, tp)  (* Assuming we handle expr *)
          | None -> 
              (None, TAst.Int)  (* Assuming Unit for None update, adjust as needed *)
    
        in
    
        let new_env = {env_after_init with in_loop = true } in  (* Enter the loop *)
        let tbody, _ = typecheck_statement new_env body in
        let updated_env = { env with in_loop = false } in  (* Exit the loop *)
    
        TAst.ForStm {init = tinit; cond = tcond; update = titer; body = tbody}, updated_env
    
      | CompoundStm {stms; _} ->
        let rec check_statements env acc = function
          | [] -> List.rev acc, env
          | stm :: stms ->
              let typed_stm, new_env = typecheck_statement env stm in
              check_statements new_env (typed_stm :: acc) stms
        in
        let typed_stms, final_env = check_statements env [] stms in
        TAst.CompoundStm {stms = typed_stms}, env
    
      | ReturnStm {ret; _} ->
          let texpr, _expr_tp = infertype_expr env ret in
          TAst.ReturnStm {ret = texpr}, env
    
      | ExprStm {expr = Some expr; _} ->
          let texpr, _ = infertype_expr env expr in
          TAst.ExprStm {expr = Some texpr}, env
    
      | ExprStm {expr = None; _} ->
          TAst.ExprStm {expr = None}, env
    
      | IfThenElseStm {cond; thbr; elbro; loc} ->
          let tcond, cond_tp = infertype_expr env cond in
          if cond_tp <> TAst.Bool then
            raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = cond_tp; loc = cond.loc}));
          let tthbr, _ = typecheck_statement env thbr in
          let telbro, _ = match elbro with
            | Some elbr -> let telbr, _ = typecheck_statement env elbr in Some telbr, env
            | None -> None, env in
          TAst.IfThenElseStm {cond = tcond; thbr = tthbr; elbro = telbro}, env
    
  let typecheck_prog (prog: Ast.program) : TypedAst.program =
    let env = make_env library_functions in
    let rec check_statements env acc = function
      | [] -> 
          if not (List.exists (function TypedAst.ReturnStm _ -> true | _ -> false) acc) then
            raise (TypeError (MissingReturn))
          else
            List.rev acc
      | stm :: stms ->
          stm_counter := !stm_counter + 1;
          let typed_stm, new_env = typecheck_statement env stm in
          check_statements new_env (typed_stm :: acc) stms
    in
    try check_statements env [] prog
    with
      | TypeError err -> let err_str = error_to_string err in
        Printf.eprintf "Semantic error: %s in statement %i\n" err_str !stm_counter;
        exit 1

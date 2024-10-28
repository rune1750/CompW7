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
  | Ast.Plus -> TypedAst.Plus
  | Ast.Minus -> TypedAst.Minus
  | Ast.Mul -> TypedAst.Mul
  | Ast.Div -> TypedAst.Div
  | Ast.Rem -> TypedAst.Rem
  | Ast.Lt -> TypedAst.Lt
  | Ast.Le -> TypedAst.Le
  | Ast.Gt -> TypedAst.Gt
  | Ast.Ge -> TypedAst.Ge
  | Ast.Lor -> TypedAst.Lor
  | Ast.Land -> TypedAst.Land
  | Ast.Eq -> TypedAst.Eq
  | Ast.NEq -> TypedAst.NEq

  let convert_unop op =
    match op with 
    | Ast.Neg -> TypedAst.Neg
    | Ast.Lnot -> TypedAst.Lnot

  let convert_type tp = 
    match tp with
    | Ast.Int -> TypedAst.Int
    | Ast.Bool -> TypedAst.Bool

  
    let rec infertype_expr env (expr: Ast.expr) =
      match expr with
      | Integer {int} -> (TAst.Integer {int}, TAst.Int)
      
      | Boolean {bool} -> (TAst.Boolean {bool}, TAst.Bool)
    
      | BinOp {left; op; right} ->
          let tleft, tpleft = infertype_expr env left in
          let tright, tpright = infertype_expr env right in
          let result_type = match op, tpleft, tpright with
            | (Plus | Minus | Mul | Div | Rem), TAst.Int, TAst.Int -> TAst.Int
            | (Lt | Le | Gt | Ge), TAst.Int, TAst.Int -> TAst.Bool
            | (Eq | NEq), tp1, tp2 when tp1 = tp2 && tp1 <> TAst.Void -> TAst.Bool
            | (Lor | Land), TAst.Bool, TAst.Bool -> TAst.Bool
            | (Plus | Minus | Mul | Div | Rem), tp1, _tp2 ->
              raise (TypeError (TypeMismatch {expected = TAst.Int; actual = tp1}))
            | (Lt | Le | Gt | Ge), tp1, _tp2 ->
                raise (TypeError (TypeMismatch {expected = TAst.Int; actual = tp1}))
            | (Eq | NEq), tp1, tp2 when tp1 <> tp2 ->
                raise (TypeError (TypeMismatch {expected = tp1; actual = tp2})) 
            | (Eq | NEq), TAst.Void, _ ->
                raise (TypeError (InvalidVoidUsage {name = "Equality operator used with void type"}))
            | (Lor | Land), tp1, _tp2 ->
                raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = tp1}))
            | _ -> raise (TypeError (InvalidExpression {msg = "Invalid binary operation"})) in
          (TAst.BinOp {left = tleft; op = convert_binop op; right = tright; tp = result_type}, result_type)
          
      | UnOp {op; operand} ->
        let toperand, operand_type = infertype_expr env operand in
        let result_type = match op with
          | Lnot when operand_type = TAst.Bool -> TAst.Bool
          | Neg when operand_type = TAst.Int -> TAst.Int
          | Lnot -> raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = operand_type}))
          | Neg -> raise (TypeError (TypeMismatch {expected = TAst.Int; actual = operand_type}))
        in 
        (TAst.UnOp {op = convert_unop op; operand = toperand; tp = result_type}, result_type)
    
      | Call {fname; args} ->
        let Ident {name} = fname in
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
                raise (TypeError (TypeMismatch {expected = typ; actual = targ_type}));
              targ
            ) args params in
            (TypedAst.Call {fname = TypedAst.Ident {sym = Symbol.symbol name}; args = targs; tp = ret}, ret)
        | None -> 
            raise (TypeError (UndefinedFunction {name}))
        end
    
        | Lval lval ->
          let tlval, tp = infertype_lval env lval in
          (TAst.Lval tlval, tp)
    
      | Assignment {lvl; rhs} ->
        let tlvl, tplvl = infertype_lval env lvl in
        let trhs, tprhs = infertype_expr env rhs in
        if tplvl <> tprhs then
          raise (TypeError (TypeMismatch {expected = tplvl; actual = tprhs}));
        (TAst.Assignment {lvl = tlvl; rhs = trhs; tp = tplvl}, tplvl)
    
        and infertype_lval env = function
        | Var id ->
            let Ident {name} = id in
            match lookup_var env name with
            | Some tp -> 
                (TypedAst.Var {ident = TypedAst.Ident {sym = Symbol.symbol name}; tp}, tp)
            | None -> raise (TypeError (UndefinedVariable {name}))

    let process_single_decl (env, typed_decls) (Ast.Declaration {name; tp; body}) =
      (* Extract the name from the ident *)
      let Ident {name = id_name} = name in
      
      (* Infer the type of the initialization expression *)
      let texpr, expr_tp = infertype_expr env body in
    
      (* Convert the explicitly declared type, if present *)
      let declared_tp = match tp with
        | Some declared_tp -> convert_type declared_tp
        | None -> expr_tp (* If no type is provided, infer from the expression *)
      in
    
      (* Ensure the declared type matches the expression type *)
      if declared_tp <> expr_tp then
        raise (TypeError (TypeMismatch {expected = declared_tp; actual = expr_tp}));
    
      (* Insert the new variable into the environment using its name (id_name) *)
      let new_env = insert_local_decl env id_name declared_tp in
    
      (* Create the typed declaration *)
      let typed_decl = TypedAst.Declaration {
        name = TypedAst.Ident { sym = Symbol.symbol id_name };
        tp = declared_tp;
        body = texpr;
      } in
    
      (* Return the updated environment and accumulate the typed declaration *)
      (new_env, (typed_decl :> single_declaration) :: typed_decls)
    

    let typecheck_declaration_block env (Ast.DeclBlock decls) =
      let process_single_decl (env, typed_decls) (Ast.Declaration {name; tp; body}) =
        let Ast.Ident {name = id_name} = name in  (* Use `Ast.Ident` to get `name` from the original AST *)
        (* Infer the type of the initialization expression *)
        let texpr, expr_tp = infertype_expr env body in
    
        (* Convert the explicitly declared type, if present *)
        let declared_tp = match tp with
          | Some declared_tp -> convert_type declared_tp
          | None -> expr_tp (* If no type is provided, infer from the expression *)
        in
    
        (* Ensure the declared type matches the expression type *)
        if declared_tp <> expr_tp then
          raise (TypeError (TypeMismatch {expected = declared_tp; actual = expr_tp}));
    
        (* Insert the new variable into the environment *)
        let new_env = insert_local_decl env id_name declared_tp in
    
        (* Create the typed declaration *)
        let typed_decl = TypedAst.Declaration {
          name = TypedAst.Ident { sym = Symbol.symbol id_name };  (* Now use `TypedAst.Ident` to store the symbol *)
          tp = declared_tp;
          body = texpr;
        } in
    
        (* Return the updated environment and accumulate the typed declaration *)
        (new_env, (typed_decl :> single_declaration) :: typed_decls)
      in
    
      (* Fold over the declarations and process each one *)
      let new_env, typed_decls = List.fold_left process_single_decl (env, []) decls in
      (TypedAst.DeclBlock (List.rev typed_decls), new_env)

    let rec typecheck_statement env (stm: Ast.statement) =
      match stm with

      | VarDeclStm (DeclBlock declarations) ->
        (* Fold over the list of declarations, processing each one in sequence *)
        let final_env, typed_decls = List.fold_left process_single_decl (env, []) declarations in
    
        (* Reverse the list of typed declarations since fold_left accumulates them in reverse order *)
        TypedAst.VarDeclStm (TypedAst.DeclBlock (List.rev typed_decls)), final_env
      | BreakStm ->
          if not env.in_loop then
            raise (TypeError (InvalidBreakContinue {msg = "Break statement outside of loop"}));
          TypedAst.BreakStm, env
    
      | ContinueStm ->
          if not env.in_loop then
            raise (TypeError (InvalidBreakContinue {msg = "Continue statement outside of loop"}));
          TypedAst.ContinueStm, env
    
      (* Handle other cases, including loops like WhileStm and ForStm below *)
    
      | WhileStm {cond; body} ->
          let tcond, cond_tp = infertype_expr env cond in
          if cond_tp <> TAst.Bool then
            raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = cond_tp}));
          let new_env = { env with in_loop = true } in (* Enter the loop *)
          let tbody, _ = typecheck_statement new_env body in
          let updated_env = { env with in_loop = false } in (* Exit the loop *)
          TAst.WhileStm {cond = tcond; body = tbody}, updated_env
    
      | ForStm {init; cond; update; body} ->
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
                raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = tp}));
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
    
      | CompoundStm {stms} ->
        let rec check_statements env acc = function
          | [] -> List.rev acc, env
          | stm :: stms ->
              let typed_stm, new_env = typecheck_statement env stm in
              check_statements new_env (typed_stm :: acc) stms
        in
        let typed_stms, final_env = check_statements env [] stms in
        TAst.CompoundStm {stms = typed_stms}, env
    
      | ReturnStm {ret} ->
          let texpr, _expr_tp = infertype_expr env ret in
          TAst.ReturnStm {ret = texpr}, env
    
      | ExprStm {expr = Some expr} ->
          let texpr, _ = infertype_expr env expr in
          TAst.ExprStm {expr = Some texpr}, env
    
      | ExprStm {expr = None} ->
          TAst.ExprStm {expr = None}, env
    
      | IfThenElseStm {cond; thbr; elbro} ->
          let tcond, cond_tp = infertype_expr env cond in
          if cond_tp <> TAst.Bool then
            raise (TypeError (TypeMismatch {expected = TAst.Bool; actual = cond_tp}));
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


let test_program_loop : Ast.program = [
  VarDeclStm (DeclBlock [
    Declaration {name = Ident {name = "x"}; tp = Some Int; body = Integer {int = 0L}}
  ]);
  ForStm {
  init = Some (FIExpr (Assignment {
    lvl = Var (Ident {name = "x"});
    rhs = Integer {int = 0L}
  }));
  cond = Some (BinOp {
    left = Lval (Var (Ident {name = "x"}));
    op = Lt;
    right = Integer {int = 10L}
  });
  update = Some (Assignment {
    lvl = Var (Ident {name = "x"});
    rhs = BinOp {
      left = Lval (Var (Ident {name = "x"}));
      op = Plus;
      right = Integer {int = 1L}
    }
  });
  body = ExprStm {expr = Some (Call {
    fname = Ident {name = "print_integer"};
    args = [Lval (Var (Ident {name = "x"}))]
  })}};
  ReturnStm {ret = Integer {int = 0L}}
  ]

  let test_program_loop_fail : Ast.program = [
    VarDeclStm (DeclBlock [
      Declaration {name = Ident {name = "x"}; tp = Some Int; body = Integer {int = 0L}}
    ]);
    ForStm {
    init = Some (FIExpr (Assignment {
      lvl = Var (Ident {name = "x"});
      rhs = Integer {int = 0L}
    }));
    cond = Some (Integer {int = 10L});
    update = Some (Assignment {
      lvl = Var (Ident {name = "x"});
      rhs = BinOp {
        left = Lval (Var (Ident {name = "x"}));
        op = Plus;
        right = Integer {int = 1L}
      }
    });
    body = ExprStm {expr = Some (Call {
      fname = Ident {name = "print_integer"};
      args = [Lval (Var (Ident {name = "x"}))]
    })}};
    ReturnStm {ret = Integer {int = 0L}}
    ]

  let test_program_loop_mul : Ast.program = [
    VarDeclStm (DeclBlock [
      Declaration {name = Ident {name = "x"}; tp = Some Int; body = Integer {int = 0L}};
      Declaration {name = Ident {name = "y"}; tp = Some Int; body = Integer {int = 0L}}
    ]);
    ForStm {
    init = Some (FIExpr (Assignment {
      lvl = Var (Ident {name = "x"});
      rhs = Integer {int = 0L}
    }));
    cond = Some (BinOp {
      left = Lval (Var (Ident {name = "x"}));
      op = Lt;
      right = Integer {int = 10L}
    });
    update = Some (Assignment {
      lvl = Var (Ident {name = "x"});
      rhs = BinOp {
        left = Lval (Var (Ident {name = "x"}));
        op = Plus;
        right = Integer {int = 1L}
      }
    });
    body = ExprStm {expr = Some (Call {
      fname = Ident {name = "print_integer"};
      args = [Lval (Var (Ident {name = "y"}))]
    })}};
    ReturnStm {ret = Integer {int = 0L}}
    ]
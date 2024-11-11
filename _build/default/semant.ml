open Ast
open TypedAst
open Env
open Errors
open Symbol
open Location

exception TypeError of error

let library_functions : Ast.function_decl list = [
  (* print_integer: takes an int, returns void *)
  Function {
    f_name = Ident {name = "print_integer"; loc = dummy_loc}; 
    return_type = Void {loc = dummy_loc}; 
    params = [Parameter {name = Ident {name = "x"; loc = dummy_loc}; tp = Int {loc = dummy_loc}; loc = dummy_loc}]; 
    body = []; 
    loc = dummy_loc
  };

  (* read_integer: takes no parameters, returns int *)
  Function {
    f_name = Ident {name = "read_integer"; loc = dummy_loc}; 
    return_type = Int {loc = dummy_loc}; 
    params = []; 
    body = []; 
    loc = dummy_loc
  };

  (* Additional library functions can be added here if needed *)
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
  | Ast.Lnot _ -> TypedAst.Lnot

let convert_type tp = 
  match tp with
  | Ast.Int _ -> TypedAst.Int
  | Ast.Bool _ -> TypedAst.Bool
  | Ast.Void _ -> TypedAst.Void


let validate_expr_context env (expr : Ast.expr) loc =
  match expr, env.expr_context with
  | CommaExpr _, ExprStmtContext ->
      raise (TypeError (InvalidCommaExpression {
        msg = "Comma expressions are not allowed as expression statements";
        loc = loc
      }))
  | CommaExpr _, FuncArgContext ->
      raise (TypeError (InvalidCommaExpression {
        msg = "Comma expressions cannot appear as function arguments";
        loc = loc
      }))
  | _ -> ()


let rec infertype_expr env (expr: Ast.expr) =
  let loc = match expr with
    | Integer { loc; _ } -> loc
    | Boolean { loc; _ } -> loc
    | BinOp { loc; _ } -> loc
    | UnOp { loc; _ } -> loc
    | Lval Var Ident {name; loc} -> loc (* handle Lval case appropriately if it has loc *)
    | Assignment { loc; _ } -> loc
    | Call { loc; _ } -> loc
    | CommaExpr { loc; _ } -> loc
  in
  validate_expr_context env expr loc;

  match expr with
  | Integer { int; _} -> (TAst.Integer { int }, TAst.Int)
  
  | Boolean { bool; _ } -> (TAst.Boolean { bool }, TAst.Bool)

  | BinOp { left; op; right; loc } ->
      let tleft, tpleft = infertype_expr env left in
      let tright, tpright = infertype_expr env right in
      let result_type = match op, tpleft, tpright with
        | (Plus _ | Minus _ | Mul _ | Div _ | Rem _), TAst.Int, TAst.Int -> TAst.Int
        | (Lt _ | Le _ | Gt _ | Ge _), TAst.Int, TAst.Int -> TAst.Bool
        | (Eq _ | NEq _), tp1, tp2 when tp1 = tp2 && tp1 <> TAst.Void -> TAst.Bool
        | (Lor _ | Land _), TAst.Bool, TAst.Bool -> TAst.Bool
        | (Plus _ | Minus _ | Mul _ | Div _ | Rem _), tp1, _tp2 ->
            raise (TypeError (TypeMismatch { expected = TAst.Int; actual = tp1; loc = loc }))
        | (Lt _ | Le _ | Gt _ | Ge _), tp1, _tp2 ->
            raise (TypeError (TypeMismatch { expected = TAst.Int; actual = tp1; loc = loc }))
        | (Eq _ | NEq _), tp1, tp2 when tp1 <> tp2 ->
            raise (TypeError (TypeMismatch { expected = tp1; actual = tp2; loc = loc })) 
        | (Eq _ | NEq _), TAst.Void, _ ->
            raise (TypeError (InvalidVoidUsage { name = "Equality operator used with void type"; loc = loc }))
        | (Lor _ | Land _), tp1, _tp2 ->
            raise (TypeError (TypeMismatch { expected = TAst.Bool; actual = tp1; loc = loc }))
        | _ -> raise (TypeError (InvalidExpression { msg = "Invalid binary operation"; loc = loc })) in
      (TAst.BinOp { left = tleft; op = convert_binop op; right = tright; tp = result_type }, result_type)
      
  | UnOp { op; operand; loc } ->
      let toperand, operand_type = infertype_expr env operand in
      let result_type = match op with
        | Lnot _ when operand_type = TAst.Bool -> TAst.Bool
        | Neg _ when operand_type = TAst.Int -> TAst.Int
        | Lnot _ ->
            raise (TypeError (TypeMismatch { expected = TAst.Bool; actual = operand_type; loc = loc }))
        | Neg _ ->
            raise (TypeError (TypeMismatch { expected = TAst.Int; actual = operand_type; loc = loc }))
      in 
      (TAst.UnOp { op = convert_unop op; operand = toperand; tp = result_type }, result_type)

  | Call { fname; args; loc } -> 
    let Ident { name; _ } = fname in
    begin match lookup_fun env name with
    | Some (Ast.Function { f_name; return_type; params; _ }) ->  
        (* Manually convert Ast.Function to a TypedAst.Function here *)

        (* Convert function return type and parameters *)
        let ret = convert_type return_type in
        let tparams = List.map (fun (Ast.Parameter { name; tp; _ }) ->
          let Ast.Ident { name = param_name; _ } = name in  (* Extract string from Ast.ident *)
          TypedAst.Param {
            paramname = TypedAst.Ident { sym = Symbol.symbol param_name };
            typ = convert_type tp
          }
        ) params in

        (* Check argument arity and types, same as before *)
        if List.length args <> List.length tparams then
            raise (TypeError (ArityMismatch {
              expected = List.length tparams;
              actual = List.length args;
              loc = loc
            }));
        
        let targs = List.map2 (fun arg (TypedAst.Param { typ; _ }) -> 
            let targ, targ_type = infertype_expr env arg in
            if targ_type <> typ then
                raise (TypeError (TypeMismatch { expected = typ; actual = targ_type; loc = loc }));
            targ
        ) args tparams in
        
        (* Return the correctly typed function call *)
        (TypedAst.Call { fname = TypedAst.Ident { sym = Symbol.symbol name }; args = targs; tp = ret }, ret)
    | None -> 
        raise (TypeError (UndefinedFunction { name = name; loc = loc }))
    end


  | Lval lval ->
      let tlval, tp = infertype_lval env lval in
      (TAst.Lval tlval, tp)

  | Assignment { lvl; rhs; loc } ->
      let tlvl, tplvl = infertype_lval env lvl in
      let trhs, tprhs = infertype_expr env rhs in
      if tplvl <> tprhs then
        raise (TypeError (TypeMismatch { expected = tplvl; actual = tprhs; loc = loc }));
      (TAst.Assignment { lvl = tlvl; rhs = trhs; tp = tplvl }, tplvl)

  | CommaExpr { exprs; loc } ->
    (* Validate context specifically for CommaExpr *)
    validate_expr_context env expr loc;

    (* Process comma-separated expressions *)
    let typed_exprs = List.map (fun e -> fst (infertype_expr env e)) exprs in
    match List.rev exprs with
    | last :: _ -> 
        let _, last_type = infertype_expr env last in
        (TAst.CommaExpr { exprs = typed_exprs; tp = last_type }, last_type)
    | [] -> 
        raise (TypeError (InvalidExpression { msg = "Empty comma expression"; loc = loc }))

and infertype_lval env = function
  | Var id ->
      let Ident { name; loc } = id in
      match lookup_var env name with
      | Some tp -> 
          (TypedAst.Var { ident = TypedAst.Ident { sym = Symbol.symbol name }; tp }, tp)
      | None -> raise (TypeError (UndefinedVariable { name; loc = loc }))

let process_single_decl (env, typed_decls: environment * single_declaration list) 
  (Ast.Declaration { name; tp; body; loc }) =
  (* Extract the name from the ident *)
  let Ident { name = id_name; loc = name_loc } = name in
  
  (* Infer the type of the initialization expression *)
  let texpr, expr_tp = infertype_expr env body in

  (* Convert the explicitly declared type, if present *)
  let declared_tp = match tp with
    | Some declared_tp -> convert_type declared_tp
    | None -> expr_tp (* If no type is provided, infer from the expression *)
  in

  (* Ensure the declared type matches the expression type *)
  if declared_tp <> expr_tp then
    raise (TypeError (TypeMismatch { expected = declared_tp; actual = expr_tp; loc = loc }));

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
 

  let typecheck_declaration_block (env : environment) (Ast.DeclBlock decls) =
    (* Fold over the declarations and process each one *)
    let decls = decls.declarations in
    let new_env, typed_decls = List.fold_left process_single_decl (env, []) decls in
    (* Return a DeclBlock with the correct field name *)
    (TypedAst.DeclBlock { declarations = List.rev typed_decls }, new_env)

  let rec typecheck_statement env (stm: Ast.statement) =
    match stm with
    | VarDeclStm (DeclBlock declarations) ->
      (* Fold over the list of declarations, processing each one in sequence *)
      let declarations = declarations.declarations in
      let final_env, typed_decls = List.fold_left process_single_decl (env, []) declarations in

      (* Reverse the list of typed declarations since fold_left accumulates them in reverse order *)
      TypedAst.VarDeclStm { decl_block = DeclBlock {declarations = List.rev typed_decls }}, final_env

    | BreakStm { loc } ->
        if not env.in_loop then
          raise (TypeError (InvalidBreakContinue { msg = "Break statement outside of loop"; loc = loc }));
        TypedAst.BreakStm, env

    | ContinueStm { loc } ->
        if not env.in_loop then
          raise (TypeError (InvalidBreakContinue { msg = "Continue statement outside of loop"; loc = loc }));
        TypedAst.ContinueStm, env

    | WhileStm { cond; body; loc } ->
        let tcond, cond_tp = infertype_expr env cond in
        if cond_tp <> TAst.Bool then
          raise (TypeError (TypeMismatch { expected = TAst.Bool; actual = cond_tp; loc = loc }));
        let new_env = { env with in_loop = true } in (* Enter the loop *)
        let tbody, _ = typecheck_statement new_env body in
        let updated_env = { env with in_loop = false } in (* Exit the loop *)
        TAst.WhileStm { cond = tcond; body = tbody }, updated_env

    | ForStm { init; cond; update; body; loc } ->
      let update_env = { env with expr_context = FuncArgContext } in
      validate_expr_context update_env (Option.get update) loc;
      let tinit, env_after_init = match init with
        | Some (FIExpr expr) -> 
            let texpr, _ = infertype_expr env expr in
            (Some (TypedAst.FIExpr texpr), env)
        | Some (FIDecl decl_block) ->
            let tdecl_block, new_env = typecheck_declaration_block env decl_block in
            (Some (TypedAst.FIDecl tdecl_block), new_env)
        | None -> (None, env) in
        
      (* Handle the conditional expression *)
      let tcond, cond_tp = 
        match cond with
        | Some expr -> 
            let texpr, tp = infertype_expr env_after_init expr in
            if tp <> TAst.Bool then
              raise (TypeError (TypeMismatch { expected = TAst.Bool; actual = tp; loc = loc }));
            (Some texpr, tp)
        | None -> 
            (None, TAst.Bool)
      in

      let titer, _ = match update with
        | Some expr -> 
            let texpr, tp = infertype_expr env_after_init expr in
            (Some texpr, tp)
        | None -> 
            (None, TAst.Int)
      in

      let new_env = { env_after_init with in_loop = true } in  (* Enter the loop *)
      let tbody, _ = typecheck_statement new_env body in
      let updated_env = { env with in_loop = false } in  (* Exit the loop *)

      TAst.ForStm { init = tinit; cond = tcond; update = titer; body = tbody }, updated_env

    | CompoundStm { stms; _ } ->
      let rec check_statements env acc = function
        | [] -> List.rev acc, env
        | stm :: stms ->
            let typed_stm, new_env = typecheck_statement env stm in
            check_statements new_env (typed_stm :: acc) stms
      in
      let typed_stms, final_env = check_statements env [] stms in
      TAst.CompoundStm { stms = typed_stms }, env

    | ReturnStm { ret; loc } ->
        let texpr, _ = infertype_expr env ret in
        TAst.ReturnStm { ret = texpr }, env

    | ExprStm { expr = Some expr; loc } -> 
      let stmt_env = { env with expr_context = ExprStmtContext } in
      validate_expr_context stmt_env expr loc;
      let texpr, _ = infertype_expr stmt_env expr in
      TAst.ExprStm { expr = Some texpr }, env
      
    | ExprStm { expr = None; loc } -> 
        (* Handle the case where there is no expression, e.g., a placeholder for missing expression *)
        raise (TypeError (InvalidExpression {
          msg = "Expression statement must have an expression.";
          loc = loc
        }))
          
    | IfThenElseStm { cond; thbr; elbro; loc} ->
        let tcond, cond_tp = infertype_expr env cond in
        if cond_tp <> TAst.Bool then
          raise (TypeError (TypeMismatch { expected = TAst.Bool; actual = cond_tp; loc = loc }));
        let tthbr, _ = typecheck_statement env thbr in
        let telbro, _ = match elbro with
          | Some elbr -> let telbr, _ = typecheck_statement env elbr in Some telbr, env
          | None -> None, env in
        TAst.IfThenElseStm { cond = tcond; thbr = tthbr; elbro = telbro }, env


let collect_function_signatures (functions: Ast.function_decl list) : environment =
  let initial_env = make_env library_functions in
  
  (* Validate and add each function to the environment *)
  let validate_and_add_function env (Ast.Function {f_name; return_type; params; body; loc}) =
    let Ast.Ident { name; _ } = f_name in
    
    (* Check for duplicate function definitions *)
    if lookup_fun env name <> None then
      raise (TypeError (DuplicateFunction { name; loc }));
    
    (* Add function to environment *)
    insert_fun env name (Ast.Function { f_name; return_type; params; body; loc })
  in
  
  (* Add all functions to the environment *)
  let env_with_functions = List.fold_left validate_and_add_function initial_env functions in
  
  (* Check if main function exists with return type int *)
  let check_main_function env =
    match lookup_fun env "main" with
    | Some (Ast.Function {return_type = Ast.Int _; _}) -> env
    | Some _ -> raise (TypeError (InvalidMainFunction { msg = "Invalidain" }))
    | None -> raise (TypeError (MissingMainFunction { msg = "main" }))
  in

  (* Perform the check *)
  check_main_function env_with_functions


let typecheck_function_body env (Ast.Function { f_name; return_type; params; body; loc }) =
  let Ident { name; _ } = f_name in
  let ret_type = convert_type return_type in
  
  (* Create new environment with parameters *)
  let env_with_params = List.fold_left (fun env (Parameter { name = param_name; tp; _ }) ->
    let Ident { name = param_name_str; _ } = param_name in
    insert_local_decl env param_name_str (convert_type tp)
  ) env params in
  
  (* Type check the function body *)
  let typed_body = List.map (fun stmt ->
    let typed_stmt, _ = typecheck_statement env_with_params stmt in
    typed_stmt
  ) body in
  
  (* Verify return type matches all return statements *)
  let verify_returns ret_type stmt =
    match stmt with
    | Ast.ReturnStm { ret; _ } ->  (* Use TypedAst instead of Ast *)
        let _, ret_tp = infertype_expr env_with_params ret in
        if ret_tp <> ret_type then
          raise (TypeError (ReturnTypeMismatch { 
            expected = ret_type; 
            actual = ret_tp; 
            loc = loc 
          }))
    | _ -> ()
  in
  List.iter (verify_returns ret_type) body;

  TAst.Function {
    f_name = TAst.Ident { sym = Symbol.symbol name };
    return_type = ret_type;
    params = List.map (fun (Parameter p) -> 
      TAst.Param {
        paramname = TAst.Ident { sym = Symbol.symbol (let Ident { name; _ } = p.name in name) };
        typ = convert_type p.tp;
      }
    ) params;
    body = typed_body;
  }

  let typecheck_prog (prog: Ast.program) : TypedAst.program =
    (* First pass: collect function signatures *)
    let fun_env = collect_function_signatures prog in
    
    (* Second pass: type check function bodies *)
    let typed_functions = List.map (typecheck_function_body fun_env) prog in
    
    typed_functions 
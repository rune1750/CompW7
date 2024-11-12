(* codegen.ml *)
open Ll
open Semant
module Cfg = CfgBuilder
module Sym = Symbol
open Printf

(* Exception for code generation errors *)

exception CodegenError of string

(* Environment mapping variable symbols to LLVM uids and types *)
module Env = Sym.Table

type environment = {
  vars: (Ll.uid * Ll.ty) Env.t;            (* Current scope variable environment *)
  params: (Ll.uid * Ll.ty) Env.t;          (* Function parameters *)
  env_stack: ( ((Ll.uid * Ll.ty) Env.t) * ((Ll.uid * Ll.ty) Env.t) ) list; (* Stack to manage nested environments, including variables, params, and loop stack *)
  loop_stack: (Ll.lbl * Ll.lbl) list;      (* Stack of (continue_lbl, break_lbl) for loops *)
}
let push_env env =
  { env with
    env_stack = (env.vars, env.params) :: env.env_stack;
  }

(* Pop the environment from the stack and restore vars, params, and loop_stack *)
let pop_env env =
  match env.env_stack with
  | [] -> failwith "Environment stack underflow"
  | (prev_vars, prev_params) :: stack -> 
      { env with 
        vars = prev_vars; 
        params = prev_params; 
        env_stack = stack 
      }
let tmp_counter = ref 0

let generate_unique_tmp sym =
  incr tmp_counter;
  Sym.symbol (Sym.name sym ^ "_val" ^ string_of_int !tmp_counter)

let generate_unique_name string =
  incr tmp_counter;
  Sym.symbol (string ^ string_of_int !tmp_counter)

let empty_env = {
  vars = Env.empty;         (* Start with an empty variable map *)
  params = Env.empty;       (* Start with an empty parameter map *)
  env_stack = [];           (* An empty list for the environment stack *)
  loop_stack = [];          (* Empty loop stack *)
}

(* Convert Dolphin types to LLVM types *)
let ll_type_of_typ = function
  | TypedAst.Int -> Ll.I64
  | TypedAst.Bool -> Ll.I1
  | TypedAst.Void -> Ll.Void
  | TypedAst.ErrorType -> raise (CodegenError "ErrorType encountered in code generation")

(* Helper function to determine the type of an expression *)
let rec type_of_expr expr =
  match expr with
  | TypedAst.Integer _ -> TypedAst.Int
  | TypedAst.Boolean _ -> TypedAst.Bool
  | TypedAst.BinOp {tp; _} -> tp
  | TypedAst.UnOp {tp; _} -> tp
  | TypedAst.Lval lval -> type_of_lval lval
  | TypedAst.Assignment {tp; _} -> tp
  | TypedAst.Call {tp; _} -> tp
  | TypedAst.CommaExpr {tp; _} -> tp

and type_of_lval lval =
  match lval with
  | TypedAst.Var {tp; _} -> tp

(* Helper function to find a variable in the environment *)
let find_variable env sym =
  (* Traverse through the environment stack, checking each scope for the variable *)
  let all_scopes = (env.vars, env.params) :: env.env_stack in
  let rec find_in_scopes scopes =
    match scopes with
    | [] -> None
    | (vars, _) :: rest ->  (* Check the vars part of the tuple *)
        match Env.find_opt sym vars with
        | Some x -> Some x
        | None -> find_in_scopes rest
  in
  find_in_scopes all_scopes
  let find_parameter env sym =
    (* Traverse through the environment stack, checking each scope for the parameter *)
    let all_scopes = (env.vars, env.params) :: env.env_stack in
    let rec find_in_scopes scopes =
      match scopes with
      | [] -> None
      | (_, params) :: rest ->  (* Check the params part of the tuple *)
          match Env.find_opt sym params with
          | Some x -> Some x
          | None -> find_in_scopes rest
    in
    find_in_scopes all_scopes

(* Generate code for expressions *)
let rec codegen_expr (env : environment) (cfg : Cfg.cfg_builder) (e : TypedAst.expr) : (Ll.operand * environment * Cfg.cfg_builder) =
  match e with
  | TypedAst.Integer {int} ->
      let operand = Ll.IConst64 int in
      (operand, env, cfg)

  | TypedAst.Boolean {bool} ->
      let operand = Ll.BConst bool in
      (operand, env, cfg)

  | TypedAst.Lval lval ->
      codegen_lval env cfg lval

  | TypedAst.BinOp {left; op; right; tp} ->
      codegen_binop env cfg left op right tp

  | TypedAst.UnOp {op; operand; tp} ->
      codegen_unop env cfg op operand tp

  | TypedAst.Assignment {lvl; rhs; tp} ->
      codegen_assignment env cfg lvl rhs tp

  | TypedAst.Call {fname; args; tp} ->
      codegen_call env cfg fname args tp

  | TypedAst.CommaExpr {left; right; tp} ->
      (* Generate code for the left expression *)
      let (_, env, cfg) = codegen_expr env cfg left in
      (* Discard the result of the left expression *)

      (* Generate code for the right expression *)
      codegen_expr env cfg right
      (* The result of the comma expression is the result of the right expression *)

and codegen_lval (env : environment) (cfg : Cfg.cfg_builder) (lval : TypedAst.lval) : (Ll.operand * environment * Cfg.cfg_builder) =
  match lval with
  | TypedAst.Var { ident; tp } ->
      (* Extract the symbol from the identifier *)
      let sym = match ident with TypedAst.Ident { sym } -> sym in

      (* First, try to find the variable in the parameters environment *)
      begin
          (* If not found in parameters, try to find in the variables environment *)
          match find_variable env sym with
          | Some (uid, ll_ty) ->
              (* If it's a local variable, generate the load instruction *)
              let tmp_uid = generate_unique_tmp sym in
              let load_insn = (Some tmp_uid, Ll.Load (ll_ty, Ll.Id uid)) in
              let cfg = Cfg.add_insn load_insn cfg in
              (Ll.Id tmp_uid, env,  cfg)
          | None ->
                match find_parameter env sym with
                  | Some (uid, ll_ty) ->
                      (* If it's a parameter, directly return the operand (no load needed) *)
                      (Ll.Id uid, env, cfg)
                  | None ->
                    (* If the variable is not found in either environment, raise an error *)
                    raise (CodegenError ("Variable not found: " ^ Sym.name sym))
      end

and codegen_binop env cfg left_expr op right_expr result_tp =
  match op with
  | TypedAst.Lor | TypedAst.Land ->
      codegen_short_circuit_binop env cfg left_expr op right_expr result_tp
  | _ ->
      let (left_operand, env, cfg) = codegen_expr env cfg left_expr in
      let (right_operand,env, cfg) = codegen_expr env cfg right_expr in
      let result_ty = ll_type_of_typ result_tp in
      let tmp_uid = generate_unique_name "tmp" in
      let insn =
        match op with
        | TypedAst.Plus -> Ll.Binop (Ll.Add, result_ty, left_operand, right_operand)
        | TypedAst.Minus -> Ll.Binop (Ll.Sub, result_ty, left_operand, right_operand)
        | TypedAst.Mul -> Ll.Binop (Ll.Mul, result_ty, left_operand, right_operand)
        | TypedAst.Div -> Ll.Binop (Ll.SDiv, result_ty, left_operand, right_operand)
        | TypedAst.Rem -> Ll.Binop (Ll.SRem, result_ty, left_operand, right_operand)
        | TypedAst.Lt | TypedAst.Le | TypedAst.Gt | TypedAst.Ge | TypedAst.Eq | TypedAst.NEq ->
            let cmp =
              match op with
              | TypedAst.Lt -> Ll.Slt
              | TypedAst.Le -> Ll.Sle
              | TypedAst.Gt -> Ll.Sgt
              | TypedAst.Ge -> Ll.Sge
              | TypedAst.Eq -> Ll.Eq
              | TypedAst.NEq -> Ll.Ne
              | _ -> raise (CodegenError "Invalid comparison operator")
            in
            let left_type = type_of_expr left_expr in
            Ll.Icmp (cmp, ll_type_of_typ left_type, left_operand, right_operand)
        | _ -> raise (CodegenError "Unsupported binary operation")
      in
      let cfg = Cfg.add_insn (Some tmp_uid, insn) cfg in
      (Ll.Id tmp_uid, env,  cfg)

and codegen_unop env cfg op operand_expr result_tp =
  let (operand, env, cfg) = codegen_expr env cfg operand_expr in
  let result_ty = ll_type_of_typ result_tp in
  let tmp_uid = generate_unique_name "tmp" in
  let insn =
    match op with
    | TypedAst.Neg ->
        let zero_operand =
          match result_ty with
          | Ll.I64 -> Ll.IConst64 0L
          | _ -> raise (CodegenError "Invalid type for Negation")
        in
        Ll.Binop (Ll.Sub, result_ty, zero_operand, operand)
    | TypedAst.Lnot ->
        Ll.Binop (Ll.Xor, result_ty, operand, Ll.BConst true)
  in
  let cfg = Cfg.add_insn (Some tmp_uid, insn) cfg in
  (Ll.Id tmp_uid, env, cfg)

  and codegen_assignment env cfg lval rhs_expr result_tp =
    (* First generate code for RHS expression *)
    let (rhs_operand, env, cfg) = codegen_expr env cfg rhs_expr in
  
    (* Get the address of the lvalue and updated environment *)
    let (lval_operand, updated_env, cfg) = codegen_lval_address env cfg lval in
  
    let ll_ty = ll_type_of_typ result_tp in
  
    (* Generate store instruction *)
    let store_insn = (None, Ll.Store (ll_ty, rhs_operand, lval_operand)) in
    let cfg = Cfg.add_insn store_insn cfg in
  
    (* The assignment expression itself results in the value assigned *)
    (rhs_operand, updated_env, cfg)
  and codegen_lval_address (env : environment) (cfg : Cfg.cfg_builder) (lval : TypedAst.lval) : (Ll.operand * environment * Cfg.cfg_builder) =
    match lval with
    | TypedAst.Var {ident; tp} ->
        let sym = match ident with TypedAst.Ident {sym} -> sym in
  
        (* Try finding the variable in vars, and if not found, look in params *)
        begin
          match find_variable env sym with
          | Some (uid, ll_ty) -> (Ll.Id uid, env, cfg)
          | None ->
              (* Check in params if not found in vars *)
              match find_parameter env sym with
              | Some (param_uid, param_ll_ty) ->  
                  (* Generate a unique identifier *)
                  let new_uid = generate_unique_name (Sym.name sym) in
                  (* Add the allocation for the variable to the CFG *)
                  let cfg = Cfg.add_alloca (new_uid, param_ll_ty) cfg in
                  
                  (* Update environment: add to vars and remove from params *)
                  let updated_env = {
                      env with
                      vars = Env.add sym (new_uid, param_ll_ty) env.vars;
                      params = Env.remove sym env.params;
                  } in
                  (* Return the operand, updated environment, and cfg *)
                  (Ll.Id new_uid, updated_env, cfg)
              | None -> raise (CodegenError ("Variable not found: " ^ Sym.name sym))
        end

and codegen_call env cfg fname args result_tp =
  let sym = match fname with TypedAst.Ident {sym} -> sym in
  let ll_fname = Ll.Gid sym in
  (* Generate code for arguments *)
  let rec gen_args args cfg accum =
    match args with
    | [] -> (List.rev accum, cfg)
    | arg_expr :: rest ->
        let (arg_operand, env, cfg) = codegen_expr env cfg arg_expr in
        let arg_type = type_of_expr arg_expr in
        let arg_ty = ll_type_of_typ arg_type in
        gen_args rest cfg ((arg_ty, arg_operand) :: accum)
  in
  let (arg_list, cfg) = gen_args args cfg [] in
  let result_ty = ll_type_of_typ result_tp in
  (* If the function returns void, we don't need a result *)
  if result_ty = Ll.Void then
    let call_insn = (None, Ll.Call (result_ty, ll_fname, arg_list)) in
    let cfg = Cfg.add_insn call_insn cfg in
    (Ll.Null,env, cfg)
  else
    let tmp_uid = generate_unique_name "tmp" in
    let call_insn = (Some tmp_uid, Ll.Call (result_ty, ll_fname, arg_list)) in
    let cfg = Cfg.add_insn call_insn cfg in
    (Ll.Id tmp_uid,env, cfg)

and codegen_short_circuit_binop env cfg left_expr op right_expr result_tp =
  let result_ty = ll_type_of_typ result_tp in
  let tmp_uid = generate_unique_name "tmp" in
  let right_lbl = generate_unique_name "right_eval" in
  let end_lbl = generate_unique_name "end" in

  (* Allocate space to store the result *)
  let cfg = Cfg.add_insn (Some tmp_uid, Ll.Alloca result_ty) cfg in
  let result_ptr = Ll.Id tmp_uid in

  (* Evaluate left operand *)
  let (left_operand, env, cfg) = codegen_expr env cfg left_expr in

  let cfg = match op with
    | TypedAst.Land ->
        (* For AND, if left is false, short-circuit *)
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, left_operand, result_ptr)) cfg in
        let cfg = Cfg.term_block (Ll.Cbr (left_operand, right_lbl, end_lbl)) cfg in
        (* Right operand evaluation *)
        let cfg = Cfg.start_block right_lbl cfg in
        let (right_operand, env, cfg) = codegen_expr env cfg right_expr in
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, right_operand, result_ptr)) cfg in
        Cfg.term_block (Ll.Br end_lbl) cfg
    | TypedAst.Lor ->
        (* For OR, if left is true, short-circuit *)
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, left_operand, result_ptr)) cfg in
        let cfg = Cfg.term_block (Ll.Cbr (left_operand, end_lbl, right_lbl)) cfg in
        (* Right operand evaluation *)
        let cfg = Cfg.start_block right_lbl cfg in
        let (right_operand,env, cfg) = codegen_expr env cfg right_expr in
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, right_operand, result_ptr)) cfg in
        Cfg.term_block (Ll.Br end_lbl) cfg
    | _ -> raise (CodegenError "Invalid operator for short-circuiting")
  in

  (* End block *)
  let cfg = Cfg.start_block end_lbl cfg in
  let tmp_val_uid = generate_unique_name "tmp_val" in
  let cfg = Cfg.add_insn (Some tmp_val_uid, Ll.Load (result_ty, result_ptr)) cfg in
  (Ll.Id tmp_val_uid,env, cfg)

(* Generate code for variable declaration block *)
and codegen_var_decl_block env cfg decls =
  List.fold_left
    (fun (env, cfg) (TypedAst.Declaration {name; tp; body}) ->
      (* Same as VarDeclStm case *)
      (* Extract the symbol from the variable name *)
      let sym = match name with TypedAst.Ident {sym} -> sym in

      (* Check if the variable already exists in the current environment *)
      let env =
        if Env.mem sym env.vars then
          push_env env  (* Push current scope to stack to handle shadowing *)
        else
          env
      in

      (* Generate a unique LLVM variable name *)
      let new_uid = generate_unique_name (Sym.name sym) in
      let ll_ty = ll_type_of_typ tp in

      (* Add the allocation for the variable to the CFG *)
      let cfg = Cfg.add_alloca (new_uid, ll_ty) cfg in

      (* Update the environment with the new variable *)
      let env = { env with vars = Env.add sym (new_uid, ll_ty) env.vars } in

      (* Initialize the variable *)
      let (init_operand,env, cfg) = codegen_expr env cfg body in

      (* Generate the store instruction to initialize the variable with its value *)
      let store_insn = (None, Ll.Store (ll_ty, init_operand, Ll.Id new_uid)) in

      (* Add the store instruction to the CFG *)
      let cfg = Cfg.add_insn store_insn cfg in

      (env, cfg)
    )
    (env, cfg)
    decls

(* Generate code for statements *)
let rec codegen_statement env cfg stmt =
  match stmt with
  | TypedAst.VarDeclStm decl_block ->
      let decl_block = match decl_block with TypedAst.DeclBlock {declarations} -> declarations in
      codegen_var_decl_block env cfg decl_block

  | TypedAst.WhileStm {cond; body} ->
      codegen_while env cfg cond body

  | TypedAst.ForStm {init; cond; update; body} ->
      codegen_for env cfg init cond update body

  | TypedAst.BreakStm ->
      codegen_break env cfg

  | TypedAst.ContinueStm ->
      codegen_continue env cfg

  | TypedAst.ExprStm {expr = Some expr} ->
      let (_, env, cfg) = codegen_expr env cfg expr in
      (env, cfg)

  | TypedAst.ExprStm {expr = None} ->
      (* Empty statement; do nothing *)
      (env, cfg)

  | TypedAst.IfThenElseStm {cond; thbr; elbro} ->
    (* Generate code for condition *)
      let (cond_operand, env, cfg) = codegen_expr env cfg cond in
      
      (* Create labels for the then, else branches, and the merge point *)
      let then_lbl = generate_unique_name "then" in
      let else_lbl = generate_unique_name "else" in
      let merge_lbl = generate_unique_name "if_end" in
      
      (* Terminate the current block with a conditional branch *)
      let cfg = Cfg.term_block (Ll.Cbr (cond_operand, then_lbl, else_lbl)) cfg in
      
      (* Then branch *)
      let cfg = Cfg.start_block then_lbl cfg in
      let env_then = push_env env in
      let (env_then, cfg) = codegen_statement env_then cfg thbr in
      (* If the then branch isn't terminated, jump to the merge label *)
      let cfg =
        if (Cfg.is_labelled cfg) then
          Cfg.term_block (Ll.Br merge_lbl) cfg
        else
          cfg
      in
      
      (* Else branch *)
      let cfg =
        match elbro with
        | Some elbr ->
            let cfg = Cfg.start_block else_lbl cfg in
            let env_else = push_env env in
            let (env_else, cfg) = codegen_statement env_else cfg elbr in
            if (Cfg.is_labelled cfg) then
              Cfg.term_block (Ll.Br merge_lbl) cfg
            else
              cfg
        | None ->
            (* If no else branch, the else block just goes to the merge point *)
            let cfg = Cfg.start_block else_lbl cfg in
            Cfg.term_block (Ll.Br merge_lbl) cfg
      in
      
      (* Merge point *)
      let cfg = Cfg.start_block merge_lbl cfg in
      (env, cfg)
    

  | TypedAst.CompoundStm {stms} ->
      (* Save the current environment by pushing it onto the stack *)
      let env = push_env env in
      (* Generate code for the statements inside the block *)
      let (env, cfg) = codegen_statements env cfg stms in
      (* Restore the outer environment after the block *)
      let env = pop_env env in
      (env, cfg)

  | TypedAst.ReturnStm {ret} ->
      let (ret_operand,env, cfg) = codegen_expr env cfg ret in
      let ret_type = type_of_expr ret in
      let ll_ty = ll_type_of_typ ret_type in
      let cfg = Cfg.term_block (Ll.Ret (ll_ty, Some ret_operand)) cfg in
      (env, cfg)

and codegen_statements env cfg stms =
  List.fold_left
    (fun (env, cfg) stm -> codegen_statement env cfg stm)
    (env, cfg)
    stms

and codegen_while env cfg cond body =
  (* Generate labels *)
  let cond_lbl = generate_unique_name "while_cond" in
  let body_lbl = generate_unique_name "while_body" in
  let end_lbl = generate_unique_name "while_end" in

  (* Start condition check *)
  let cfg = Cfg.term_block (Ll.Br cond_lbl) cfg in

  (* cond_lbl *)
  let cfg = Cfg.start_block cond_lbl cfg in

  (* Generate code for condition *)
  let (cond_operand,env, cfg) = codegen_expr env cfg cond in

  (* Branch based on condition *)
  let cfg = Cfg.term_block (Ll.Cbr (cond_operand, body_lbl, end_lbl)) cfg in

  (* Push loop labels onto loop_stack *)
  let env = { env with loop_stack = (cond_lbl, end_lbl) :: env.loop_stack } in

  (* body_lbl *)
  let cfg = Cfg.start_block body_lbl cfg in

  (* Generate code for body *)
  let (env, cfg) = codegen_statement env cfg body in


  (* After body, jump back to condition *)
  let cfg = Cfg.term_block (Ll.Br cond_lbl) cfg in

  (* Pop loop_stack *)
  let env = { env with loop_stack = List.tl env.loop_stack } in

  (* Start end_lbl *)
  let cfg = Cfg.start_block end_lbl cfg in

  (env, cfg)

  and codegen_for env cfg init cond update body =
    (* Handle init *)
    let (env, cfg) = match init with
      | Some (TypedAst.FIDecl decl_block) ->
        let decl_block = match decl_block with TypedAst.DeclBlock {declarations} -> declarations in
          codegen_var_decl_block env cfg decl_block
      | Some (TypedAst.FIExpr expr) ->
          let (_, env, cfg) = codegen_expr env cfg expr in
          (env, cfg)
      | None ->
          (env, cfg)
    in
  
    (* Generate labels *)
    let cond_lbl = generate_unique_name "for_cond" in
    let body_lbl = generate_unique_name "for_body" in
    let update_lbl = generate_unique_name "for_update" in
    let end_lbl = generate_unique_name "for_end" in
  
    (* Terminate the current block by jumping to cond_lbl *)
    let cfg = Cfg.term_block (Ll.Br cond_lbl) cfg in
  
    (* Start cond_lbl block *)
    let cfg = Cfg.start_block cond_lbl cfg in
  
    (* Generate code for condition, if any *)
    let cfg = match cond with
      | Some cond_expr ->
          let (cond_operand,env, cfg) = codegen_expr env cfg cond_expr in
          (* Branch based on condition *)
          Cfg.term_block (Ll.Cbr (cond_operand, body_lbl, end_lbl)) cfg
      | None ->
          (* No condition, always proceed to body *)
          Cfg.term_block (Ll.Br body_lbl) cfg
    in
  
    (* Push loop labels onto loop_stack *)
    let env = { env with loop_stack = (update_lbl, end_lbl) :: env.loop_stack } in
  
    (* Start body_lbl block *)
    let cfg = Cfg.start_block body_lbl cfg in
  
    (* Generate code for body *)
    let (env, cfg) = codegen_statement env cfg body in
  
    (* After body, jump to update_lbl only if the block isn't already terminated *)
    let cfg = 
      if (Cfg.is_labelled cfg) then
        Cfg.term_block (Ll.Br update_lbl) cfg
      else 
        cfg
    in
    Printf.printf "test1";
    (* Start update_lbl block *)
    let cfg = Cfg.start_block update_lbl cfg in
  
    (* Generate code for update, if any *)
    let cfg = match update with
      | Some update_expr ->
          let (_,env, cfg) = codegen_expr env cfg update_expr in
          cfg
      | None -> cfg
    in
  
    (* After update, terminate by jumping back to cond_lbl *)
    let cfg = Cfg.term_block (Ll.Br cond_lbl) cfg in
  
    (* Pop loop_stack *)
    let env = { env with loop_stack = List.tl env.loop_stack } in
  
    (* Start end_lbl block *)
    let cfg = Cfg.start_block end_lbl cfg in
  
    (env, cfg)

and codegen_break env cfg =
  match env.loop_stack with
  | (_, break_lbl) :: _ ->
      let cfg = Cfg.term_block (Ll.Br break_lbl) cfg in
      (env, cfg)
  | [] ->
      raise (CodegenError "Break statement not inside a loop")

and codegen_continue env cfg =
  match env.loop_stack with
  | (continue_lbl, _) :: _ ->
      let cfg = Cfg.term_block (Ll.Br continue_lbl) cfg in
      (env, cfg)
  | [] ->
      raise (CodegenError "Continue statement not inside a loop")

(* Generate code for the entire program *)
let codegen_prog (prog : TypedAst.program) : Ll.prog =
  (* Start with an empty environment and an empty CFG builder *)
  let env = empty_env in
  let cfg = Cfg.empty_cfg_builder in
  (* Function to generate an LLVM function declaration from a TypedAst.function_decl *)
  let codegen_function (env : environment) (func_decl : TypedAst.function_decl) =
    match func_decl with
    | TypedAst.Function { f_name; return_type; params; body } ->
       (* Convert parameter types to LLVM types *)
       let param_types = List.map (fun (TypedAst.Param { typ; _ }) -> ll_type_of_typ typ) params in
       (* Extract parameter names and generate unique names for each *)
       let param_names = List.map (fun (TypedAst.Param { paramname = TypedAst.Ident { sym }; _ }) -> sym)
       params in

       (* Load parameters into the environment by modifying the param section directly *)
       let params_env = List.fold_left2 (fun env param_name param_type ->
        Env.add param_name (param_name, param_type) env
      ) env.params param_names param_types in

       (* Update the environment to reflect the function parameters *)
       let updated_env = { env with params = params_env } in

       let () =
          List.iter (fun param_name ->
            match Env.find_opt param_name updated_env.params with
            | Some (uid, ll_ty) -> 
                Printf.printf "Param '%s' found with UID %s and Type %s\n" (Symbol.name param_name) (Symbol.name uid) (Ll.string_of_ty ll_ty)
            | None -> Printf.printf "Param '%s' not found in params environment\n" (Symbol.name param_name)
          ) param_names in

       (* Generate code for the function body with the updated environment *)
       let (_, cfg) = codegen_statements updated_env cfg body in
       (* Ensure the last block is properly terminated *)
       let cfg =
         if Cfg.is_labelled cfg then
           Cfg.term_block (Ll.Ret (Ll.I64, Some (Ll.IConst64 0L))) cfg
         else
           cfg
       in
       (* Get the entry block and all other blocks in the CFG *)
       let (entry_block, blocks) = Cfg.get_cfg cfg in
       (* Construct the function type and declaration *)
       let fdecl : Ll.fdecl = {
         fty = (param_types, Ll.I64);  (* Use param_types for function type and return type *)
         param = param_names;         (* Use param_names for function parameters *)
         cfg = (entry_block, blocks);
       } in
       fdecl

  in

let get_function_name func_decl =
  match func_decl with
  | TypedAst.Function { f_name; _ } ->
      (* Unpack the Ident to get the sym, then extract the name string from sym *)
      (match f_name with
       | TypedAst.Ident { sym } -> sym) in

(* Map each function in the program to an LLVM function declaration *)
let fdecls = 
List.map 
  (fun func -> 
     let name = 
       if Sym.name (get_function_name func) = "main" then 
         Sym.symbol "dolphin_main" 
       else 
         get_function_name func 
     in
     (name, codegen_function env func)
  ) 
  prog 
in
(* Build the final LLVM program *)
{
  tdecls = [];
  extgdecls = [];
  gdecls = [];
  extfuns = [
    (Sym.symbol "read_integer", ([], Ll.I64));
    (Sym.symbol "print_integer", ([Ll.I64], Ll.Void));
  ];
  fdecls = fdecls;
}

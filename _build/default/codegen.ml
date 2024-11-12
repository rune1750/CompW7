(* codegen.ml *)
open Ll
open Semant
module Cfg = CfgBuilder
module Sym = Symbol

exception CodegenError of string

(* Environment mapping variable symbols to LLVM uids and types *)
module Env = Sym.Table

type environment = {
  vars: (Ll.uid * Ll.ty) Env.t;             (* Current scope variable environment *)
  env_stack: (Ll.uid * Ll.ty) Env.t list;   (* Stack to manage nested environments *)
  loop_stack: (Ll.lbl * Ll.lbl) list;       (* Stack of (continue_lbl, break_lbl) for loops *)
}

let push_env env =
  { env with env_stack = env.vars :: env.env_stack }

(* Pop the environment from the stack and restore it *)
let pop_env env =
  match env.env_stack with
  | [] -> failwith "Environment stack underflow"
  | prev_vars :: stack -> { env with vars = prev_vars; env_stack = stack }

let tmp_counter = ref 0

let generate_unique_tmp sym =
  incr tmp_counter;
  Sym.symbol (Sym.name sym ^ "_val" ^ string_of_int !tmp_counter)

let generate_unique_name string =
  incr tmp_counter;
  Sym.symbol (string ^ string_of_int !tmp_counter)

let empty_env = {
  vars = Env.empty;         (* Start with an empty variable map *)
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
  let all_scopes = env.vars :: env.env_stack in
  let rec find_in_scopes scopes =
    match scopes with
    | [] -> None
    | scope :: rest ->
        match Env.find_opt sym scope with
        | Some x -> Some x
        | None -> find_in_scopes rest
  in
  find_in_scopes all_scopes

(* Generate code for expressions *)
let rec codegen_expr (env : environment) (cfg : Cfg.cfg_builder) (e : TypedAst.expr) : (Ll.operand * Cfg.cfg_builder) =
  match e with
  | TypedAst.Integer {int} ->
      let operand = Ll.IConst64 int in
      (operand, cfg)

  | TypedAst.Boolean {bool} ->
      let operand = Ll.BConst bool in
      (operand, cfg)

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
      let (_, cfg) = codegen_expr env cfg left in
      (* Discard the result of the left expression *)

      (* Generate code for the right expression *)
      codegen_expr env cfg right
      (* The result of the comma expression is the result of the right expression *)

and codegen_lval (env : environment) (cfg : Cfg.cfg_builder) (lval : TypedAst.lval) : (Ll.operand * Cfg.cfg_builder) =
  match lval with
  | TypedAst.Var {ident; tp} ->
      (* Extract the symbol from the identifier *)
      let sym = match ident with TypedAst.Ident {sym} -> sym in

      (* Attempt to find the variable in the environment *)
      begin
        match find_variable env sym with
        | Some (uid, ll_ty) ->
            (* Generate a temporary unique ID for the loaded value *)
            let tmp_uid = generate_unique_tmp sym in

            (* Create the load instruction to load the value from memory *)
            let load_insn = (Some tmp_uid, Ll.Load (ll_ty, Ll.Id uid)) in

            (* Add the load instruction to the CFG *)
            let cfg = Cfg.add_insn load_insn cfg in

            (* Return the operand (the loaded value) and the updated CFG *)
            (Ll.Id tmp_uid, cfg)
        | None ->
            (* If the variable is not found in any scope, raise an error *)
            raise (CodegenError ("Variable not found: " ^ Sym.name sym))
      end

and codegen_binop env cfg left_expr op right_expr result_tp =
  match op with
  | TypedAst.Lor | TypedAst.Land ->
      codegen_short_circuit_binop env cfg left_expr op right_expr result_tp
  | _ ->
      let (left_operand, cfg) = codegen_expr env cfg left_expr in
      let (right_operand, cfg) = codegen_expr env cfg right_expr in
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
      (Ll.Id tmp_uid, cfg)

and codegen_unop env cfg op operand_expr result_tp =
  let (operand, cfg) = codegen_expr env cfg operand_expr in
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
  (Ll.Id tmp_uid, cfg)

and codegen_assignment env cfg lval rhs_expr result_tp =
  (* First generate code for RHS expression *)
  let (rhs_operand, cfg) = codegen_expr env cfg rhs_expr in
  (* Get the address of the lvalue *)
  let (lval_operand, cfg) = codegen_lval_address env cfg lval in
  let ll_ty = ll_type_of_typ result_tp in
  (* Generate store instruction *)
  let store_insn = (None, Ll.Store (ll_ty, rhs_operand, lval_operand)) in
  let cfg = Cfg.add_insn store_insn cfg in
  (* The assignment expression itself results in the value assigned *)
  (rhs_operand, cfg)

and codegen_lval_address (env : environment) (cfg : Cfg.cfg_builder) (lval : TypedAst.lval) : (Ll.operand * Cfg.cfg_builder) =
  match lval with
  | TypedAst.Var {ident; tp} ->
      (* Extract the symbol from the identifier *)
      let sym = match ident with TypedAst.Ident {sym} -> sym in

      (* Attempt to find the variable in the environment *)
      begin
        match find_variable env sym with
        | Some (uid, ll_ty) ->
            (* Return the address (uid) of the variable without dereferencing it *)
            (Ll.Id uid, cfg)
        | None ->
            (* If the variable is not found in any scope, raise an error *)
            raise (CodegenError ("Variable not found: " ^ Sym.name sym))
      end

and codegen_call env cfg fname args result_tp =
  let sym = match fname with TypedAst.Ident {sym} -> sym in
  let ll_fname = Ll.Gid sym in
  (* Generate code for arguments *)
  let rec gen_args args cfg accum =
    match args with
    | [] -> (List.rev accum, cfg)
    | arg_expr :: rest ->
        let (arg_operand, cfg) = codegen_expr env cfg arg_expr in
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
    (Ll.Null, cfg)
  else
    let tmp_uid = generate_unique_name "tmp" in
    let call_insn = (Some tmp_uid, Ll.Call (result_ty, ll_fname, arg_list)) in
    let cfg = Cfg.add_insn call_insn cfg in
    (Ll.Id tmp_uid, cfg)

and codegen_short_circuit_binop env cfg left_expr op right_expr result_tp =
  let result_ty = ll_type_of_typ result_tp in
  let tmp_uid = generate_unique_name "tmp" in
  let right_lbl = generate_unique_name "right_eval" in
  let end_lbl = generate_unique_name "end" in

  (* Allocate space to store the result *)
  let cfg = Cfg.add_insn (Some tmp_uid, Ll.Alloca result_ty) cfg in
  let result_ptr = Ll.Id tmp_uid in

  (* Evaluate left operand *)
  let (left_operand, cfg) = codegen_expr env cfg left_expr in

  let cfg = match op with
    | TypedAst.Land ->
        (* For AND, if left is false, short-circuit *)
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, left_operand, result_ptr)) cfg in
        let cfg = Cfg.term_block (Ll.Cbr (left_operand, right_lbl, end_lbl)) cfg in
        (* Right operand evaluation *)
        let cfg = Cfg.start_block right_lbl cfg in
        let (right_operand, cfg) = codegen_expr env cfg right_expr in
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, right_operand, result_ptr)) cfg in
        Cfg.term_block (Ll.Br end_lbl) cfg
    | TypedAst.Lor ->
        (* For OR, if left is true, short-circuit *)
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, left_operand, result_ptr)) cfg in
        let cfg = Cfg.term_block (Ll.Cbr (left_operand, end_lbl, right_lbl)) cfg in
        (* Right operand evaluation *)
        let cfg = Cfg.start_block right_lbl cfg in
        let (right_operand, cfg) = codegen_expr env cfg right_expr in
        let cfg = Cfg.add_insn (None, Ll.Store (result_ty, right_operand, result_ptr)) cfg in
        Cfg.term_block (Ll.Br end_lbl) cfg
    | _ -> raise (CodegenError "Invalid operator for short-circuiting")
  in

  (* End block *)
  let cfg = Cfg.start_block end_lbl cfg in
  let tmp_val_uid = generate_unique_name "tmp_val" in
  let cfg = Cfg.add_insn (Some tmp_val_uid, Ll.Load (result_ty, result_ptr)) cfg in
  (Ll.Id tmp_val_uid, cfg)

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
      let (init_operand, cfg) = codegen_expr env cfg body in

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
      let (_, cfg) = codegen_expr env cfg expr in
      (env, cfg)

  | TypedAst.ExprStm {expr = None} ->
      (* Empty statement; do nothing *)
      (env, cfg)

  | TypedAst.IfThenElseStm {cond; thbr; elbro} ->
    (* Generate code for condition *)
      let (cond_operand, cfg) = codegen_expr env cfg cond in
      
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
      let (ret_operand, cfg) = codegen_expr env cfg ret in
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
  let (cond_operand, cfg) = codegen_expr env cfg cond in

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
          let (_, cfg) = codegen_expr env cfg expr in
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
          let (cond_operand, cfg) = codegen_expr env cfg cond_expr in
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
          let (_, cfg) = codegen_expr env cfg update_expr in
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

  (* Function to generate an LLVM function declaration from a TypedAst.function_decl *)
  let codegen_function (env : environment) (func : TypedAst.function_decl) : Ll.fdecl =
    (* Initialize the CFG for the function *)
    let cfg = Cfg.empty_cfg_builder in
    (* Extract function details *)
    let TypedAst.Function { f_name; return_type; params; body } = func in

    let env_with_params = 
      List.fold_left
        (fun env (TypedAst.Param { paramname; typ }) ->
           let param_sym = match paramname with
             | TypedAst.Ident { sym } -> sym
           in
           let ll_ty = ll_type_of_typ typ in
           let uid = generate_unique_name (Symbol.name param_sym) in
           { env with vars = Env.add param_sym (uid, ll_ty) env.vars })
        env
        params
    in
    
    (* Generate code for the function body *)
    let (new_env, cfg) = codegen_statements env_with_params cfg body in
    
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
      fty = ([], Ll.I64);  (* Modify the type according to actual parameter types and return type *)
      param = [];          (* Parameter names and types *)
      cfg = (entry_block, blocks);
    } in
    fdecl
  in

  let get_function_name func_decl =
    match func_decl with
    | TypedAst.Function { f_name; _ } ->
        (* Unpack the Ident to get the sym, then extract the name string from sym *)
        (match f_name with
         | TypedAst.Ident { sym } -> Sym.name sym) in

  (* Map each function in the program to an LLVM function declaration *)
  let fdecls = 
    List.map 
      (fun func -> (Sym.symbol (get_function_name func), codegen_function env func)) 
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

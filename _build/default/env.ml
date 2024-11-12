module Loc = Location
module TAst = TypedAst
open Ast
open Printf

type expr_context = 
  | NormalContext
  | ExprStmtContext
  | FuncArgContext
  | LoopContext

type environment = {
  variables : (string * TAst.typ) list;
  functions : (string * Ast.function_decl) list;  (* List of function names and function declarations *)
  in_loop : bool;
  expr_context : expr_context;
}

let get_name = function
  | Ident { name; _ } -> name

(* Create the initial environment with the given functions defined *)
let make_env function_decls =
  let function_names = List.map (fun func ->
    match func with
    | Function { f_name; _ } -> (get_name f_name, func)
  ) function_decls in
  {
    variables = [];
    functions = function_names;
    in_loop = false;
    expr_context = NormalContext
  }

(* Insert a local declaration into the environment with a TypedAst.typ *)
let insert_local_decl env name typ =
  { env with variables = (name, typ) :: env.variables }

let insert_fun env name func_decl =
  { env with functions = (name, func_decl) :: env.functions }

(* Lookup a variable in the environment, returning its TypedAst.typ *)
let lookup_var env name =
  try Some (List.assoc name env.variables) with
  | Not_found -> None

(* Lookup a function in the environment, returning its Ast.function_decl *)
let lookup_fun env name =
  try Some (List.assoc name env.functions) with
  | Not_found -> None

  let print_variables env =
    Printf.printf "Variables in environment:\n";
    List.iter (fun (name, typ) ->
      Printf.printf "  %s \n" name 
    ) env.variables
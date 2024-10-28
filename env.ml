exception Unimplemented

type environment = {
  variables : (string * TypedAst.typ) list;  (* Variable types *)
  functions : (string * TypedAst.funtype) list;  (* Function types *)
  in_loop : bool;  (* Track if inside a loop for semantic analysis *)
}

(* Create the initial environment with the given functions defined *)
let make_env function_types =
  { variables = []; functions = function_types; in_loop = false }

(* Insert a local declaration into the environment with a TypedAst.typ *)
let insert_local_decl env name typ =
  { env with variables = (name, typ) :: env.variables }

(* Lookup a variable in the environment, returning its TypedAst.typ *)
let lookup_var env name =
  try Some (List.assoc name env.variables) with
  | Not_found -> None

(* Lookup a function in the environment, returning its TypedAst.funtype *)
let lookup_fun env name =
  try Some (List.assoc name env.functions) with
  | Not_found -> None

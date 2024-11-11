(* Errors.ml *)

module Sym = Symbol
module TAst = TypedAst
module TPretty = TypedPretty
module Loc = Location
open PrintBox

(* Define the type of errors *)
type error =
  | TypeMismatch of {expected : TAst.typ; actual : TAst.typ; loc : Loc.location}
  | UndefinedVariable of {name : string; loc : Loc.location}
  | UndefinedFunction of {name : string; loc : Loc.location}
  | InvalidVoidUsage of {name : string; loc : Loc.location}
  | InvalidExpression of {msg : string; loc : Loc.location}
  | MissingReturn of {loc : Loc.location}
  | ArityMismatch of {expected : int; actual : int; loc : Loc.location}
  | InvalidBreakContinue of {msg : string; loc : Loc.location}
  | DuplicateFunction of {name : string; loc : Loc.location}  (* New error type *)
  | ReturnTypeMismatch of {expected : TAst.typ; actual : TAst.typ; loc : Loc.location}  (* New error type *)
  | InvalidCommaExpression of {msg : string; loc : Loc.location}  (* New error type *)
  | InvalidMainFunction of {msg : string}  (* New error type *)
  | MissingMainFunction of {msg : string}  (* New error type *)

(* Define custom exceptions *)
exception LexError of string * Loc.location
exception ParseError of string * Loc.location
exception TypeError of error

(* Convert errors to string *)
let error_to_string err =
  match err with
  | TypeMismatch {expected; actual; loc} ->
      let msg = Printf.sprintf "Type mismatch at %s: expected %s but found %s"
        (Loc.string_of_location loc)
        (TPretty.typ_to_string expected)
        (TPretty.typ_to_string actual) in
      msg
  | UndefinedVariable {name; loc} ->
      Printf.sprintf "Undefined variable '%s' at %s" name (Loc.string_of_location loc)
  | UndefinedFunction {name; loc} ->
      Printf.sprintf "Undefined function '%s' at %s" name (Loc.string_of_location loc)
  | InvalidVoidUsage {name; loc} ->
      Printf.sprintf "Invalid void usage '%s' at %s" name (Loc.string_of_location loc)
  | InvalidExpression {msg; loc} ->
      Printf.sprintf "Invalid expression at %s: %s" (Loc.string_of_location loc) msg
  | MissingReturn {loc} ->
      Printf.sprintf "Missing return statement at %s" (Loc.string_of_location loc)
  | ArityMismatch {expected; actual; loc} ->
      Printf.sprintf "Arity mismatch at %s: expected %d arguments but found %d"
        (Loc.string_of_location loc) expected actual
  | InvalidBreakContinue {msg; loc} ->
      Printf.sprintf "Invalid break/continue at %s: %s" (Loc.string_of_location loc) msg
  | DuplicateFunction {name; loc} ->
      Printf.sprintf "Duplicate function '%s' at %s" name (Loc.string_of_location loc)
  | ReturnTypeMismatch {expected; actual; loc} -> 
        let msg = Printf.sprintf "Return type mismatch at %s: expected %s but found %s"
            (Loc.string_of_location loc)
            (TPretty.typ_to_string expected)
            (TPretty.typ_to_string actual) in
        msg
  | InvalidCommaExpression {msg; loc} ->
        Printf.sprintf "Invalid comma expression at %s: %s" (Loc.string_of_location loc) msg
  | InvalidMainFunction {msg} ->
        Printf.sprintf "Invalid main function at %s"  msg
  | MissingMainFunction {msg} -> 
        Printf.sprintf "Missing main function%s" msg
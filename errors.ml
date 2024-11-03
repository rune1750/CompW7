module Sym = Symbol
module TAst = TypedAst
module TPretty = TypedPretty
module Loc = Location
open PrintBox

(* Define the type of errors *)

type error =
  | TypeMismatch of {expected : TAst.typ; actual : TAst.typ; loc : Loc.location}
  | UndefinedVariable of {name : string}
  | UndefinedFunction of {name : string}
  | InvalidVoidUsage of {name : string}
  | InvalidExpression of {msg : string}
  | MissingReturn
  | ArityMismatch of {expected : int; actual : int}
  | InvalidBreakContinue of {msg : string}

(* Convert errors to string *)
let error_to_string err =
  match err with
  | TypeMismatch {expected; actual; loc} ->
      let msg = Printf.sprintf "Type mismatch: expected %s but found %s"
        (TPretty.typ_to_string expected) (TPretty.typ_to_string actual) in
      PrintBox_text.output stdout (Location.location_to_tree loc);
      msg
  | UndefinedVariable {name} ->
      Printf.sprintf "Undefined variable: %s" name
  | UndefinedFunction {name} -> 
      Printf.sprintf "Undefined function: %s" name
  | InvalidVoidUsage {name} -> 
      Printf.sprintf "Invalid Void Usage: %s" name
  | InvalidExpression {msg} -> 
      Printf.sprintf "%s" msg
  | MissingReturn -> 
      Printf.sprintf "Missing return statement"
  | ArityMismatch {expected; actual}->
     Printf.sprintf "Number of arguments does not match function definition. Expected: %i and Actual: %i" expected actual
  | InvalidBreakContinue {msg} -> 
      Printf.sprintf "%s" msg

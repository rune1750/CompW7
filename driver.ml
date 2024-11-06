open Printf
open Pretty
open Semant
open Codegen     (* Include the Codegen module *)
open Errors
open Location
open Ll

let compile_prog filename =
  try
    let inch = open_in filename in
    let lexbuf = Lexing.from_channel inch in
    lexbuf.Lexing.lex_curr_p <- { lexbuf.Lexing.lex_curr_p with Lexing.pos_fname = filename };
    try
      let ast = Parser.program Lexer.tokenize lexbuf in
      close_in inch;
      printf "Parsing successful!\n";
      printf "AST:\n%!";
      (* Convert AST to pretty-printed tree and print it *)
      let tree = program_to_tree ast in
      PrintBox_text.output stdout tree;
      printf "\n%!";
      (* Perform semantic analysis *)
      let typed_ast = Semant.typecheck_prog ast in
      printf "Semantic analysis successful!\n";
      (* Generate code *)
      let code = Codegen.codegen_prog typed_ast in
      printf "Code generation successful!\n";
      (* Output the generated code *)
      let code = Ll.string_of_prog code in
      printf "Generated Code:\n%s\n" code;
      ()
    with
    | Parser.Error ->
        let pos = lexbuf.Lexing.lex_curr_p in
        eprintf "Parser error at %s\n"
          (Location.string_of_position pos);
        close_in inch;
        exit 1
    | LexError (msg, loc) ->
        eprintf "Lexical error at %s: %s\n"
          (Location.string_of_location loc)
          msg;
        close_in inch;
        exit 1
    | TypeError err ->
        eprintf "Semantic error: %s\n" (Errors.error_to_string err);
        close_in inch;
        exit 1
    | e ->
        close_in inch;
        raise e
  with
  | Sys_error msg ->
      eprintf "Cannot open file: %s\n" msg;
      exit 1

(* Helper functions to format position and location *)
module Location = struct
  include Location

  let string_of_position pos =
    Printf.sprintf "line %d, character %d"
      pos.Lexing.pos_lnum
      (pos.Lexing.pos_cnum - pos.Lexing.pos_bol)

  let string_of_location { start_pos; end_pos } =
    if start_pos.pos_lnum = end_pos.pos_lnum then
      Printf.sprintf "%s: line %d, characters %d-%d"
        start_pos.pos_fname
        start_pos.pos_lnum
        (start_pos.pos_cnum - start_pos.pos_bol)
        (end_pos.pos_cnum - end_pos.pos_bol)
    else
      Printf.sprintf "%s: line %d, character %d to line %d, character %d"
        start_pos.pos_fname
        start_pos.pos_lnum
        (start_pos.pos_cnum - start_pos.pos_bol)
        end_pos.pos_lnum
        (end_pos.pos_cnum - end_pos.pos_bol)
end

let () =
  if Array.length Sys.argv <> 2 then
    eprintf "Usage: %s <filename>\n" Sys.argv.(0)
  else
    try
      compile_prog Sys.argv.(1);
      printf "Compilation successful!\n";
      exit 0
    with e -> 
      eprintf "An error occurred: %s\n" (Printexc.to_string e);
      exit 1
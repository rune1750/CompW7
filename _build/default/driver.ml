open Printf
open Pretty
open Semant

let parse_file filename =
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
      PrintBox_text.output stdout (tree);
      printf "\n%!";
      (* Perform semantic analysis *)
      Semant.typecheck_program ast;
      ast
    with
    | Parser.Error ->
        let pos = lexbuf.Lexing.lex_curr_p in
        printf "Parser error at line %d, character %d\n"
          pos.Lexing.pos_lnum
          (pos.Lexing.pos_cnum - pos.Lexing.pos_bol);
        close_in inch;
        exit 1
    | e ->
        close_in inch;
        raise e
  with Sys_error msg ->
    printf "Cannot open file: %s\n" msg;
    exit 1

let () =
  if Array.length Sys.argv <> 2 then
    printf "Usage: %s <filename>\n" Sys.argv.(0)
  else
    ignore (parse_file Sys.argv.(1)) 
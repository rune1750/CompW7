open Lexer

let () =
  let lexbuf = Lexing.from_channel (open_in "test.txt") in
  try
    while true do
      let token = Lexer.token lexbuf in  (* Call the lexer function to get tokens *)
      match token with
      | EOF -> print_endline "End of file"
      | _ -> print_endline ("Token: " ^ (string_of_token token))  (* Replace with your token handling *)
    done
  with
  | Lexer.Error msg ->
      Printf.eprintf "Lexer error: %s\n" msg
  | End_of_file ->
      ()
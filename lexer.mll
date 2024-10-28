{
  (* lexer.mll *)

  open Parser        (* Assuming your parser is named 'Parser' *)
  open Ast           (* Access to AST definitions *)
  open Location      (* Access to Location module for tracking positions *)

  (* Initialize a keyword table to differentiate between keywords and identifiers *)
  let keyword_table = Hashtbl.create 20

  let () = List.iter (fun (kwd, tok) ->
    Hashtbl.add keyword_table kwd tok
  ) [
    "true", TRUE;
    "false", FALSE;
    "nil", NIL;
    "var", VAR;
    "let", LET;
    "if", IF;
    "else", ELSE;
    "while", WHILE;
    "for", FOR;
    "break", BREAK;
    "continue", CONTINUE;
    "return", RETURN;
    "int", INT;
    "byte", BYTE;
    "bool", BOOL;
    "string", STRING;
    "void", VOID;
    "record", RECORD;
    "new", NEW;
    "length_of", LENGTHOF;
  ]

  (* Helper function to create location information *)
  let make_location lexbuf =
    let startp = Lexing.lex_start_p lexbuf in
    let endp = Lexing.lex_curr_p lexbuf in
    Location.make_location (startp, endp)

}

(* Define regular expressions for different token categories *)
let whitespace = [' ' '\t']+
let newline = '\n' | "\r\n"
let digit = ['0'-'9']
let nondigit = ['a'-'z' 'A'-'Z' '_']
let ident = nondigit (nondigit | digit)*
let int_lit = ['-']? digit+
let string_lit = '\"' ( '\\' . | [^ '\"' '\\'] )* '\"'
let anychar = _

rule tokenize = parse
  (* Ignore whitespace *)
  | whitespace { tokenize lexbuf }

  (* Handle newlines and update lexer state *)
  | newline { Lexing.new_line lexbuf; tokenize lexbuf }

  (* Single-line comments starting with // *)
  | "//" [^ '\n' '\r']* ("\n" | "\r\n")? { 
      Lexing.new_line lexbuf; 
      tokenize lexbuf 
    }

  (* Start of multi-line comment *)
  | "/*" { comment 1 lexbuf }

  (* Handle multi-character operators first *)
  | "||" { LOR }
  | "&&" { LAND }
  | "==" { EQ }
  | "!=" { NEQ }
  | "<=" { LE }
  | ">=" { GE }

  (* Single-character operators and punctuation *)
  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { MUL }
  | '/' { DIV }
  | '%' { REM }
  | '<' { LT }
  | '>' { GT }
  | '!' { LNOT }
  | '=' { ASSIGN }
  | '?' { QUESTIONMARK }
  | ':' { COLON }
  | ',' { COMMA }
  | ';' { SEMICOLON }
  | '.' { DOT }
  | '[' { LBRACKET }
  | ']' { RBRACKET }
  | '{' { LBRACE }
  | '}' { RBRACE }
  | '(' { LPAREN }
  | ')' { RPAREN }

  (* String literals *)
  | string_lit as s { 
      STRING_LIT (String.sub s 1 (String.length s - 2))  (* Remove the surrounding quotes *)
    }

  (* Identifiers and Keywords *)
  | ident as id { 
      try 
        Hashtbl.find keyword_table id 
      with 
        Not_found -> IDENT id 
    }

  (* Integer literals *)
  | int_lit as num { 
      try 
        INT_LIT (Int64.of_string num) 
      with 
        Failure _ -> 
          let loc = make_location lexbuf in
          failwith ("Lexer error at " ^ Location.location_to_string loc ^ ": Integer literal out of bounds: " ^ num) 
    }

  (* End of file *)
  | eof { EOF }

  (* Handle unexpected characters *)
  | anychar as c { 
      let loc = make_location lexbuf in
      failwith ("Lexer error at " ^ Location.location_to_string loc ^ ": Unexpected character '" ^ String.escaped (String.make 1 c) ^ "'")
    }

and comment depth = parse
  (* Nested multi-line comments: /* ... /* ... */ ... */ *)
  | "/*" { comment (depth + 1) lexbuf }

  (* End of a multi-line comment *)
  | "*/" { 
      if depth = 1 then 
        tokenize lexbuf  (* Exit the comment mode *)
      else 
        comment (depth - 1) lexbuf  (* Handle nested comment *)
    }

  (* Handle newlines within comments *)
  | newline { 
      Lexing.new_line lexbuf; 
      comment depth lexbuf 
    }

  (* Any other character inside a comment *)
  | anychar { 
      comment depth lexbuf 
    }

  (* Handle unexpected end of file within a comment *)
  | eof { 
      let loc = make_location lexbuf in
      failwith ("Lexer error at " ^ Location.location_to_string loc ^ ": Unterminated comment") 
    }
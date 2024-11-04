
(* The type of tokens. *)

type token = 
  | WHILE
  | VOID
  | VAR
  | TRUE
  | STRING_LIT of (string)
  | STRING
  | SEMICOLON
  | RPAREN
  | RETURN
  | REM
  | RECORD
  | RBRACKET
  | RBRACE
  | QUESTIONMARK
  | PLUS
  | NIL
  | NEW
  | NEQ
  | MUL
  | MINUS
  | LT
  | LPAREN
  | LOR
  | LNOT
  | LET
  | LE
  | LBRACKET
  | LBRACE
  | LAND
  | INT_LIT of (int64)
  | INT
  | IF
  | IDENT of (string)
  | GT
  | GE
  | FOR
  | FALSE
  | EQ
  | EOF
  | ELSE
  | DOT
  | DIV
  | CONTINUE
  | COMMA
  | COLON
  | BYTE
  | BREAK
  | BOOL
  | ASSIGN

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)

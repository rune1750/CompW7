
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WHILE
    | VOID
    | VAR
    | TRUE
    | STRING_LIT of (
# 14 "parser.mly"
       (string)
# 19 "parser.ml"
  )
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
    | INT_LIT of (
# 13 "parser.mly"
       (int64)
# 48 "parser.ml"
  )
    | INT
    | IF
    | IDENT of (
# 12 "parser.mly"
       (string)
# 55 "parser.ml"
  )
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
  
end

include MenhirBasics

# 3 "parser.mly"
  
  open Ast
  open Location

  let mk_loc startpos endpos = 
    { Location.start_pos = startpos;
      Location.end_pos = endpos }

# 87 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState000 : ('s, _menhir_box_program) _menhir_state
    (** State 000.
        Stack shape : .
        Start symbol: program. *)

  | MenhirState006 : (('s, _menhir_box_program) _menhir_cell1_type_expr _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_program) _menhir_state
    (** State 006.
        Stack shape : type_expr IDENT LPAREN.
        Start symbol: program. *)

  | MenhirState008 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 008.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState012 : ((('s, _menhir_box_program) _menhir_cell1_type_expr _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_param_list _menhir_cell0_RPAREN _menhir_cell0_LBRACE, _menhir_box_program) _menhir_state
    (** State 012.
        Stack shape : type_expr IDENT LPAREN param_list RPAREN LBRACE.
        Start symbol: program. *)

  | MenhirState014 : (('s, _menhir_box_program) _menhir_cell1_WHILE _menhir_cell0_LPAREN, _menhir_box_program) _menhir_state
    (** State 014.
        Stack shape : WHILE LPAREN.
        Start symbol: program. *)

  | MenhirState016 : (('s, _menhir_box_program) _menhir_cell1_MINUS, _menhir_box_program) _menhir_state
    (** State 016.
        Stack shape : MINUS.
        Start symbol: program. *)

  | MenhirState017 : (('s, _menhir_box_program) _menhir_cell1_LPAREN, _menhir_box_program) _menhir_state
    (** State 017.
        Stack shape : LPAREN.
        Start symbol: program. *)

  | MenhirState018 : (('s, _menhir_box_program) _menhir_cell1_LNOT, _menhir_box_program) _menhir_state
    (** State 018.
        Stack shape : LNOT.
        Start symbol: program. *)

  | MenhirState021 : (('s, _menhir_box_program) _menhir_cell1_IDENT _menhir_cell0_LPAREN, _menhir_box_program) _menhir_state
    (** State 021.
        Stack shape : IDENT LPAREN.
        Start symbol: program. *)

  | MenhirState024 : (('s, _menhir_box_program) _menhir_cell1_lval, _menhir_box_program) _menhir_state
    (** State 024.
        Stack shape : lval.
        Start symbol: program. *)

  | MenhirState026 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 026.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState030 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 030.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState032 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 032.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState034 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 034.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState036 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 036.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState039 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 039.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState041 : (('s, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_MINUS, _menhir_box_program) _menhir_state
    (** State 041.
        Stack shape : expr MINUS.
        Start symbol: program. *)

  | MenhirState043 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 043.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState045 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 045.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState047 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 047.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState049 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 049.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState051 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 051.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState053 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 053.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState055 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 055.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState058 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 058.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState068 : ((('s, _menhir_box_program) _menhir_cell1_WHILE _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_RPAREN, _menhir_box_program) _menhir_state
    (** State 068.
        Stack shape : WHILE LPAREN expr RPAREN.
        Start symbol: program. *)

  | MenhirState069 : (('s, _menhir_box_program) _menhir_cell1_VAR, _menhir_box_program) _menhir_state
    (** State 069.
        Stack shape : VAR.
        Start symbol: program. *)

  | MenhirState071 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 071.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState074 : (('s, _menhir_box_program) _menhir_cell1_IDENT _menhir_cell0_type_opt, _menhir_box_program) _menhir_state
    (** State 074.
        Stack shape : IDENT type_opt.
        Start symbol: program. *)

  | MenhirState080 : (('s, _menhir_box_program) _menhir_cell1_declaration, _menhir_box_program) _menhir_state
    (** State 080.
        Stack shape : declaration.
        Start symbol: program. *)

  | MenhirState083 : (('s, _menhir_box_program) _menhir_cell1_RETURN, _menhir_box_program) _menhir_state
    (** State 083.
        Stack shape : RETURN.
        Start symbol: program. *)

  | MenhirState086 : (('s, _menhir_box_program) _menhir_cell1_LBRACE, _menhir_box_program) _menhir_state
    (** State 086.
        Stack shape : LBRACE.
        Start symbol: program. *)

  | MenhirState088 : (('s, _menhir_box_program) _menhir_cell1_IF _menhir_cell0_LPAREN, _menhir_box_program) _menhir_state
    (** State 088.
        Stack shape : IF LPAREN.
        Start symbol: program. *)

  | MenhirState090 : ((('s, _menhir_box_program) _menhir_cell1_IF _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_RPAREN, _menhir_box_program) _menhir_state
    (** State 090.
        Stack shape : IF LPAREN expr RPAREN.
        Start symbol: program. *)

  | MenhirState092 : (('s, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_state
    (** State 092.
        Stack shape : FOR LPAREN.
        Start symbol: program. *)

  | MenhirState093 : ((('s, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_VAR, _menhir_box_program) _menhir_state
    (** State 093.
        Stack shape : FOR LPAREN VAR.
        Start symbol: program. *)

  | MenhirState096 : ((('s, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_for_init_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_state
    (** State 096.
        Stack shape : FOR LPAREN for_init_opt SEMICOLON.
        Start symbol: program. *)

  | MenhirState098 : (((('s, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_for_init_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_cell1_expr_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_state
    (** State 098.
        Stack shape : FOR LPAREN for_init_opt SEMICOLON expr_opt SEMICOLON.
        Start symbol: program. *)

  | MenhirState100 : ((((('s, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_for_init_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_cell1_expr_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_cell1_expr_opt _menhir_cell0_RPAREN, _menhir_box_program) _menhir_state
    (** State 100.
        Stack shape : FOR LPAREN for_init_opt SEMICOLON expr_opt SEMICOLON expr_opt RPAREN.
        Start symbol: program. *)

  | MenhirState121 : (((('s, _menhir_box_program) _menhir_cell1_IF _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_RPAREN, _menhir_box_program) _menhir_cell1_statement, _menhir_box_program) _menhir_state
    (** State 121.
        Stack shape : IF LPAREN expr RPAREN statement.
        Start symbol: program. *)

  | MenhirState125 : (('s, _menhir_box_program) _menhir_cell1_statement, _menhir_box_program) _menhir_state
    (** State 125.
        Stack shape : statement.
        Start symbol: program. *)

  | MenhirState131 : (('s, _menhir_box_program) _menhir_cell1_param, _menhir_box_program) _menhir_state
    (** State 131.
        Stack shape : param.
        Start symbol: program. *)

  | MenhirState136 : (('s, _menhir_box_program) _menhir_cell1_function_decl, _menhir_box_program) _menhir_state
    (** State 136.
        Stack shape : function_decl.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_declaration = 
  | MenhirCell1_declaration of 's * ('s, 'r) _menhir_state * (
# 39 "parser.mly"
      (Ast.single_declaration)
# 310 "parser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (
# 42 "parser.mly"
      (Ast.expr)
# 317 "parser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_expr_opt = 
  | MenhirCell1_expr_opt of 's * ('s, 'r) _menhir_state * (
# 41 "parser.mly"
      (Ast.expr option)
# 324 "parser.ml"
)

and ('s, 'r) _menhir_cell1_for_init_opt = 
  | MenhirCell1_for_init_opt of 's * ('s, 'r) _menhir_state * (
# 31 "parser.mly"
      (Ast.for_init option)
# 331 "parser.ml"
)

and ('s, 'r) _menhir_cell1_function_decl = 
  | MenhirCell1_function_decl of 's * ('s, 'r) _menhir_state * (
# 51 "parser.mly"
      (Ast.function_decl)
# 338 "parser.ml"
)

and ('s, 'r) _menhir_cell1_lval = 
  | MenhirCell1_lval of 's * ('s, 'r) _menhir_state * (
# 43 "parser.mly"
      (Ast.lval)
# 345 "parser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_param = 
  | MenhirCell1_param of 's * ('s, 'r) _menhir_state * (
# 48 "parser.mly"
      (Ast.parameter)
# 352 "parser.ml"
)

and ('s, 'r) _menhir_cell1_param_list = 
  | MenhirCell1_param_list of 's * ('s, 'r) _menhir_state * (
# 49 "parser.mly"
      (Ast.parameter list)
# 359 "parser.ml"
)

and ('s, 'r) _menhir_cell1_statement = 
  | MenhirCell1_statement of 's * ('s, 'r) _menhir_state * (
# 25 "parser.mly"
      (Ast.statement)
# 366 "parser.ml"
) * Lexing.position

and ('s, 'r) _menhir_cell1_type_expr = 
  | MenhirCell1_type_expr of 's * ('s, 'r) _menhir_state * (
# 47 "parser.mly"
      (Ast.typ)
# 373 "parser.ml"
) * Lexing.position * Lexing.position

and 's _menhir_cell0_type_opt = 
  | MenhirCell0_type_opt of 's * (
# 40 "parser.mly"
      (Ast.typ option)
# 380 "parser.ml"
)

and ('s, 'r) _menhir_cell1_FOR = 
  | MenhirCell1_FOR of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 12 "parser.mly"
       (string)
# 390 "parser.ml"
) * Lexing.position * Lexing.position

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 12 "parser.mly"
       (string)
# 397 "parser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_LBRACE = 
  | MenhirCell1_LBRACE of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_LBRACE = 
  | MenhirCell0_LBRACE of 's * Lexing.position

and ('s, 'r) _menhir_cell1_LNOT = 
  | MenhirCell1_LNOT of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_LPAREN = 
  | MenhirCell0_LPAREN of 's * Lexing.position

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_MINUS = 
  | MenhirCell0_MINUS of 's * Lexing.position

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_RPAREN = 
  | MenhirCell0_RPAREN of 's * Lexing.position

and 's _menhir_cell0_SEMICOLON = 
  | MenhirCell0_SEMICOLON of 's * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_VAR = 
  | MenhirCell1_VAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state * Lexing.position

and _menhir_box_program = 
  | MenhirBox_program of (
# 23 "parser.mly"
      (Ast.program)
# 443 "parser.ml"
) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 272 "parser.mly"
      ( [] )
# 451 "parser.ml"
     : (
# 46 "parser.mly"
      (Ast.expr list)
# 455 "parser.ml"
    ))

let _menhir_action_02 =
  fun _1 ->
    (
# 274 "parser.mly"
      ( [_1] )
# 463 "parser.ml"
     : (
# 46 "parser.mly"
      (Ast.expr list)
# 467 "parser.ml"
    ))

let _menhir_action_03 =
  fun _1 _3 ->
    (
# 276 "parser.mly"
      ( _1 :: _3 )
# 475 "parser.ml"
     : (
# 46 "parser.mly"
      (Ast.expr list)
# 479 "parser.ml"
    ))

let _menhir_action_04 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 282 "parser.mly"
      ( Assignment { lvl = _1; rhs = _3; loc = mk_loc _startpos _endpos } )
# 489 "parser.ml"
     : (
# 44 "parser.mly"
      (Ast.expr)
# 493 "parser.ml"
    ))

let _menhir_action_05 =
  fun _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 100 "parser.mly"
      ( BreakStm { loc = mk_loc _startpos _endpos } )
# 503 "parser.ml"
     : (
# 33 "parser.mly"
      (Ast.statement)
# 507 "parser.ml"
    ))

let _menhir_action_06 =
  fun _1 _3 _endpos__4_ _startpos__1_ ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos__1_ in
    (
# 268 "parser.mly"
      ( Call { fname = Ident { name = _1; loc = mk_loc _startpos _endpos }; args = _3; loc = mk_loc _startpos _endpos } )
# 517 "parser.ml"
     : (
# 45 "parser.mly"
      (Ast.expr)
# 521 "parser.ml"
    ))

let _menhir_action_07 =
  fun _2 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 213 "parser.mly"
      ( CompoundStm { stms = _2; loc = mk_loc _startpos _endpos } )
# 531 "parser.ml"
     : (
# 35 "parser.mly"
      (Ast.statement)
# 535 "parser.ml"
    ))

let _menhir_action_08 =
  fun _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 104 "parser.mly"
      ( ContinueStm { loc = mk_loc _startpos _endpos } )
# 545 "parser.ml"
     : (
# 34 "parser.mly"
      (Ast.statement)
# 549 "parser.ml"
    ))

let _menhir_action_09 =
  fun _1 _2 _4 _endpos__4_ _startpos__1_ ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos__1_ in
    (
# 122 "parser.mly"
      ( 
        Declaration { 
          name = Ident { name = _1; loc = mk_loc _startpos _endpos }; 
          tp = _2; 
          body = _4;
          loc = mk_loc _startpos _endpos 
        } 
      )
# 566 "parser.ml"
     : (
# 39 "parser.mly"
      (Ast.single_declaration)
# 570 "parser.ml"
    ))

let _menhir_action_10 =
  fun _1 _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 112 "parser.mly"
      ( DeclBlock { declarations = _1; loc = mk_loc _startpos _endpos } )
# 580 "parser.ml"
     : (
# 37 "parser.mly"
      (Ast.declaration_block)
# 584 "parser.ml"
    ))

let _menhir_action_11 =
  fun _1 ->
    (
# 116 "parser.mly"
      ( [_1] )
# 592 "parser.ml"
     : (
# 38 "parser.mly"
      (Ast.single_declaration list)
# 596 "parser.ml"
    ))

let _menhir_action_12 =
  fun _1 _3 ->
    (
# 118 "parser.mly"
      ( _1 :: _3 )
# 604 "parser.ml"
     : (
# 38 "parser.mly"
      (Ast.single_declaration list)
# 608 "parser.ml"
    ))

let _menhir_action_13 =
  fun _1 _3 _endpos__4_ _startpos__1_ ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos__1_ in
    (
# 220 "parser.mly"
      ( CommaExpr { left = _1; right = _3F; loc = mk_loc _startpos _endpos } )
# 618 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 622 "parser.ml"
    ))

let _menhir_action_14 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 222 "parser.mly"
      ( BinOp { left = _1; op = Plus { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 632 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 636 "parser.ml"
    ))

let _menhir_action_15 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 224 "parser.mly"
      ( BinOp { left = _1; op = Minus { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 646 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 650 "parser.ml"
    ))

let _menhir_action_16 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 226 "parser.mly"
      ( BinOp { left = _1; op = Mul { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 660 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 664 "parser.ml"
    ))

let _menhir_action_17 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 228 "parser.mly"
      ( BinOp { left = _1; op = Div { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 674 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 678 "parser.ml"
    ))

let _menhir_action_18 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 230 "parser.mly"
      ( BinOp { left = _1; op = Rem { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 688 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 692 "parser.ml"
    ))

let _menhir_action_19 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 232 "parser.mly"
      ( BinOp { left = _1; op = Lt { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 702 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 706 "parser.ml"
    ))

let _menhir_action_20 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 234 "parser.mly"
      ( BinOp { left = _1; op = Le { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 716 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 720 "parser.ml"
    ))

let _menhir_action_21 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 236 "parser.mly"
      ( BinOp { left = _1; op = Gt { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 730 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 734 "parser.ml"
    ))

let _menhir_action_22 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 238 "parser.mly"
      ( BinOp { left = _1; op = Ge { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 744 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 748 "parser.ml"
    ))

let _menhir_action_23 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 240 "parser.mly"
      ( BinOp { left = _1; op = Lor { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 758 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 762 "parser.ml"
    ))

let _menhir_action_24 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 242 "parser.mly"
      ( BinOp { left = _1; op = Land { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 772 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 776 "parser.ml"
    ))

let _menhir_action_25 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 244 "parser.mly"
      ( BinOp { left = _1; op = Eq { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 786 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 790 "parser.ml"
    ))

let _menhir_action_26 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 246 "parser.mly"
      ( BinOp { left = _1; op = NEq { loc = mk_loc _startpos _endpos }; right = _3; loc = mk_loc _startpos _endpos } )
# 800 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 804 "parser.ml"
    ))

let _menhir_action_27 =
  fun _2 _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 248 "parser.mly"
      ( UnOp { op = Neg { loc = mk_loc _startpos _endpos }; operand = _2; loc = mk_loc _startpos _endpos } )
# 814 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 818 "parser.ml"
    ))

let _menhir_action_28 =
  fun _2 _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 250 "parser.mly"
      ( UnOp { op = Lnot { loc = mk_loc _startpos _endpos }; operand = _2; loc = mk_loc _startpos _endpos } )
# 828 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 832 "parser.ml"
    ))

let _menhir_action_29 =
  fun _2 ->
    (
# 252 "parser.mly"
      ( _2 )
# 840 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 844 "parser.ml"
    ))

let _menhir_action_30 =
  fun _1 ->
    (
# 254 "parser.mly"
      ( Lval _1 )
# 852 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 856 "parser.ml"
    ))

let _menhir_action_31 =
  fun _1 ->
    (
# 256 "parser.mly"
      ( _1 )
# 864 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 868 "parser.ml"
    ))

let _menhir_action_32 =
  fun _1 _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 258 "parser.mly"
      ( Integer { int = _1; loc = mk_loc _startpos _endpos } )
# 878 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 882 "parser.ml"
    ))

let _menhir_action_33 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 260 "parser.mly"
      ( Boolean { bool = true; loc = mk_loc _startpos _endpos } )
# 892 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 896 "parser.ml"
    ))

let _menhir_action_34 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 262 "parser.mly"
      ( Boolean { bool = false; loc = mk_loc _startpos _endpos } )
# 906 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 910 "parser.ml"
    ))

let _menhir_action_35 =
  fun _1 ->
    (
# 264 "parser.mly"
      ( _1 )
# 918 "parser.ml"
     : (
# 42 "parser.mly"
      (Ast.expr)
# 922 "parser.ml"
    ))

let _menhir_action_36 =
  fun _1 ->
    (
# 207 "parser.mly"
      ( Some _1 )
# 930 "parser.ml"
     : (
# 41 "parser.mly"
      (Ast.expr option)
# 934 "parser.ml"
    ))

let _menhir_action_37 =
  fun () ->
    (
# 209 "parser.mly"
      ( None )
# 942 "parser.ml"
     : (
# 41 "parser.mly"
      (Ast.expr option)
# 946 "parser.ml"
    ))

let _menhir_action_38 =
  fun _1 _endpos__2_ _startpos__1_ ->
    let _endpos = _endpos__2_ in
    let _startpos = _startpos__1_ in
    (
# 147 "parser.mly"
      ( ExprStm { expr = Some _1; loc = mk_loc _startpos _endpos } )
# 956 "parser.ml"
     : (
# 27 "parser.mly"
      (Ast.statement)
# 960 "parser.ml"
    ))

let _menhir_action_39 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 149 "parser.mly"
      ( ExprStm { expr = None; loc = mk_loc _startpos _endpos } )
# 970 "parser.ml"
     : (
# 27 "parser.mly"
      (Ast.statement)
# 974 "parser.ml"
    ))

let _menhir_action_40 =
  fun _2 ->
    (
# 201 "parser.mly"
      ( FIDecl _2 )
# 982 "parser.ml"
     : (
# 32 "parser.mly"
      (Ast.for_init)
# 986 "parser.ml"
    ))

let _menhir_action_41 =
  fun _1 ->
    (
# 203 "parser.mly"
      ( FIExpr _1 )
# 994 "parser.ml"
     : (
# 32 "parser.mly"
      (Ast.for_init)
# 998 "parser.ml"
    ))

let _menhir_action_42 =
  fun _1 ->
    (
# 195 "parser.mly"
      ( Some _1 )
# 1006 "parser.ml"
     : (
# 31 "parser.mly"
      (Ast.for_init option)
# 1010 "parser.ml"
    ))

let _menhir_action_43 =
  fun () ->
    (
# 197 "parser.mly"
      ( None )
# 1018 "parser.ml"
     : (
# 31 "parser.mly"
      (Ast.for_init option)
# 1022 "parser.ml"
    ))

let _menhir_action_44 =
  fun _3 _5 _7 _9 _endpos__9_ _startpos__1_ ->
    let _endpos = _endpos__9_ in
    let _startpos = _startpos__1_ in
    (
# 183 "parser.mly"
      ( 
        ForStm {
          init = _3;
          cond = _5;
          update = _7;
          body = _9;
          loc = mk_loc _startpos _endpos
        }
      )
# 1040 "parser.ml"
     : (
# 30 "parser.mly"
      (Ast.statement)
# 1044 "parser.ml"
    ))

let _menhir_action_45 =
  fun _1 _2 _4 _7 _endpos__8_ _startpos__1_ ->
    let _endpos = _endpos__8_ in
    let _startpos = _startpos__1_ in
    (
# 295 "parser.mly"
      ( 
        Function {
          return_type = _1;            
          f_name = Ident { name = _2; loc = mk_loc _startpos _endpos };
          params = _4;               
          body = _7;                    
          loc = mk_loc _startpos _endpos;
        }
      )
# 1062 "parser.ml"
     : (
# 51 "parser.mly"
      (Ast.function_decl)
# 1066 "parser.ml"
    ))

let _menhir_action_46 =
  fun _1 ->
    (
# 290 "parser.mly"
                ( [_1] )
# 1074 "parser.ml"
     : (
# 50 "parser.mly"
      (Ast.function_decl list)
# 1078 "parser.ml"
    ))

let _menhir_action_47 =
  fun _1 _2 ->
    (
# 291 "parser.mly"
                          ( _1 :: _2 )
# 1086 "parser.ml"
     : (
# 50 "parser.mly"
      (Ast.function_decl list)
# 1090 "parser.ml"
    ))

let _menhir_action_48 =
  fun _3 _5 _endpos__5_ _startpos__1_ ->
    let _endpos = _endpos__5_ in
    let _startpos = _startpos__1_ in
    (
# 153 "parser.mly"
      (
        IfThenElseStm {
          cond = _3;
          thbr = _5;
          elbro = None;
          loc = mk_loc _startpos _endpos
        }
      )
# 1107 "parser.ml"
     : (
# 28 "parser.mly"
      (Ast.statement)
# 1111 "parser.ml"
    ))

let _menhir_action_49 =
  fun _3 _5 _7 _endpos__7_ _startpos__1_ ->
    let _endpos = _endpos__7_ in
    let _startpos = _startpos__1_ in
    (
# 162 "parser.mly"
      (
        IfThenElseStm {
          cond = _3;
          thbr = _5;
          elbro = Some _7;
          loc = mk_loc _startpos _endpos
        }
      )
# 1128 "parser.ml"
     : (
# 28 "parser.mly"
      (Ast.statement)
# 1132 "parser.ml"
    ))

let _menhir_action_50 =
  fun _1 _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 286 "parser.mly"
      ( Var (Ident { name = _1; loc = mk_loc _startpos _endpos }) )
# 1142 "parser.ml"
     : (
# 43 "parser.mly"
      (Ast.lval)
# 1146 "parser.ml"
    ))

let _menhir_action_51 =
  fun _1 _3 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 315 "parser.mly"
      ( 
        Parameter { 
          name = Ident { name = _1; loc = mk_loc _startpos _endpos }; 
          tp = _3;
          loc = mk_loc _startpos _endpos
        } 
      )
# 1162 "parser.ml"
     : (
# 48 "parser.mly"
      (Ast.parameter)
# 1166 "parser.ml"
    ))

let _menhir_action_52 =
  fun () ->
    (
# 307 "parser.mly"
      ( [] )
# 1174 "parser.ml"
     : (
# 49 "parser.mly"
      (Ast.parameter list)
# 1178 "parser.ml"
    ))

let _menhir_action_53 =
  fun _1 ->
    (
# 309 "parser.mly"
      ( [_1] )
# 1186 "parser.ml"
     : (
# 49 "parser.mly"
      (Ast.parameter list)
# 1190 "parser.ml"
    ))

let _menhir_action_54 =
  fun _1 _3 ->
    (
# 311 "parser.mly"
      ( _1 :: _3 )
# 1198 "parser.ml"
     : (
# 49 "parser.mly"
      (Ast.parameter list)
# 1202 "parser.ml"
    ))

let _menhir_action_55 =
  fun _1 ->
    (
# 68 "parser.mly"
                  ( _1 )
# 1210 "parser.ml"
     : (
# 23 "parser.mly"
      (Ast.program)
# 1214 "parser.ml"
    ))

let _menhir_action_56 =
  fun _2 _endpos__3_ _startpos__1_ ->
    let _endpos = _endpos__3_ in
    let _startpos = _startpos__1_ in
    (
# 96 "parser.mly"
      ( ReturnStm { ret = _2; loc = mk_loc _startpos _endpos } )
# 1224 "parser.ml"
     : (
# 36 "parser.mly"
      (Ast.statement)
# 1228 "parser.ml"
    ))

let _menhir_action_57 =
  fun _1 ->
    (
# 76 "parser.mly"
      ( _1 )
# 1236 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1240 "parser.ml"
    ))

let _menhir_action_58 =
  fun _1 ->
    (
# 78 "parser.mly"
      ( _1 )
# 1248 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1252 "parser.ml"
    ))

let _menhir_action_59 =
  fun _1 ->
    (
# 80 "parser.mly"
      ( _1 )
# 1260 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1264 "parser.ml"
    ))

let _menhir_action_60 =
  fun _1 ->
    (
# 82 "parser.mly"
      ( _1 )
# 1272 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1276 "parser.ml"
    ))

let _menhir_action_61 =
  fun _1 ->
    (
# 84 "parser.mly"
      ( _1 )
# 1284 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1288 "parser.ml"
    ))

let _menhir_action_62 =
  fun _1 ->
    (
# 86 "parser.mly"
      ( _1 )
# 1296 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1300 "parser.ml"
    ))

let _menhir_action_63 =
  fun _1 ->
    (
# 88 "parser.mly"
      ( _1 )
# 1308 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1312 "parser.ml"
    ))

let _menhir_action_64 =
  fun _1 _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 90 "parser.mly"
      ( CompoundStm { stms = [_1]; loc = mk_loc _startpos _endpos } )
# 1322 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1326 "parser.ml"
    ))

let _menhir_action_65 =
  fun _1 ->
    (
# 92 "parser.mly"
      ( _1 )
# 1334 "parser.ml"
     : (
# 25 "parser.mly"
      (Ast.statement)
# 1338 "parser.ml"
    ))

let _menhir_action_66 =
  fun _1 ->
    (
# 71 "parser.mly"
            ( [_1] )
# 1346 "parser.ml"
     : (
# 24 "parser.mly"
      (Ast.statement list)
# 1350 "parser.ml"
    ))

let _menhir_action_67 =
  fun _1 _2 ->
    (
# 72 "parser.mly"
                       ( _1 :: _2 )
# 1358 "parser.ml"
     : (
# 24 "parser.mly"
      (Ast.statement list)
# 1362 "parser.ml"
    ))

let _menhir_action_68 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 139 "parser.mly"
      ( Int { loc = mk_loc _startpos _endpos } )
# 1372 "parser.ml"
     : (
# 47 "parser.mly"
      (Ast.typ)
# 1376 "parser.ml"
    ))

let _menhir_action_69 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 141 "parser.mly"
      ( Bool { loc = mk_loc _startpos _endpos } )
# 1386 "parser.ml"
     : (
# 47 "parser.mly"
      (Ast.typ)
# 1390 "parser.ml"
    ))

let _menhir_action_70 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 143 "parser.mly"
      ( Void { loc = mk_loc _startpos _endpos } )
# 1400 "parser.ml"
     : (
# 47 "parser.mly"
      (Ast.typ)
# 1404 "parser.ml"
    ))

let _menhir_action_71 =
  fun _2 ->
    (
# 133 "parser.mly"
      ( Some _2 )
# 1412 "parser.ml"
     : (
# 40 "parser.mly"
      (Ast.typ option)
# 1416 "parser.ml"
    ))

let _menhir_action_72 =
  fun () ->
    (
# 135 "parser.mly"
      ( None )
# 1424 "parser.ml"
     : (
# 40 "parser.mly"
      (Ast.typ option)
# 1428 "parser.ml"
    ))

let _menhir_action_73 =
  fun _2 ->
    (
# 108 "parser.mly"
      ( VarDeclStm _2 )
# 1436 "parser.ml"
     : (
# 26 "parser.mly"
      (Ast.statement)
# 1440 "parser.ml"
    ))

let _menhir_action_74 =
  fun _3 _5 _endpos__5_ _startpos__1_ ->
    let _endpos = _endpos__5_ in
    let _startpos = _startpos__1_ in
    (
# 173 "parser.mly"
      ( 
        WhileStm { 
          cond = _3; 
          body = _5;
          loc = mk_loc _startpos _endpos
        } 
      )
# 1456 "parser.ml"
     : (
# 29 "parser.mly"
      (Ast.statement)
# 1460 "parser.ml"
    ))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ASSIGN ->
        "ASSIGN"
    | BOOL ->
        "BOOL"
    | BREAK ->
        "BREAK"
    | BYTE ->
        "BYTE"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | CONTINUE ->
        "CONTINUE"
    | DIV ->
        "DIV"
    | DOT ->
        "DOT"
    | ELSE ->
        "ELSE"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | FALSE ->
        "FALSE"
    | FOR ->
        "FOR"
    | GE ->
        "GE"
    | GT ->
        "GT"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | INT ->
        "INT"
    | INT_LIT _ ->
        "INT_LIT"
    | LAND ->
        "LAND"
    | LBRACE ->
        "LBRACE"
    | LBRACKET ->
        "LBRACKET"
    | LE ->
        "LE"
    | LET ->
        "LET"
    | LNOT ->
        "LNOT"
    | LOR ->
        "LOR"
    | LPAREN ->
        "LPAREN"
    | LT ->
        "LT"
    | MINUS ->
        "MINUS"
    | MUL ->
        "MUL"
    | NEQ ->
        "NEQ"
    | NEW ->
        "NEW"
    | NIL ->
        "NIL"
    | PLUS ->
        "PLUS"
    | QUESTIONMARK ->
        "QUESTIONMARK"
    | RBRACE ->
        "RBRACE"
    | RBRACKET ->
        "RBRACKET"
    | RECORD ->
        "RECORD"
    | REM ->
        "REM"
    | RETURN ->
        "RETURN"
    | RPAREN ->
        "RPAREN"
    | SEMICOLON ->
        "SEMICOLON"
    | STRING ->
        "STRING"
    | STRING_LIT _ ->
        "STRING_LIT"
    | TRUE ->
        "TRUE"
    | VAR ->
        "VAR"
    | VOID ->
        "VOID"
    | WHILE ->
        "WHILE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_134 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let _1 = _v in
      let _v = _menhir_action_55 _1 in
      MenhirBox_program _v
  
  let rec _menhir_goto_functions : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState136 ->
          _menhir_run_137 _menhir_stack _v
      | MenhirState000 ->
          _menhir_run_134 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_137 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_function_decl -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_function_decl (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_47 _1 _2 in
      _menhir_goto_functions _menhir_stack _v _menhir_s
  
  let rec _menhir_run_001 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_70 _endpos__1_ _startpos__1_ in
      _menhir_goto_type_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_goto_type_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState071 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState008 ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState136 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState000 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_072 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _2 = _v in
      let _v = _menhir_action_71 _2 in
      _menhir_goto_type_opt _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_type_opt : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_type_opt (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | ASSIGN ->
          let _menhir_s = MenhirState074 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_015 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_33 _endpos__1_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState092 ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState098 ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState012 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState068 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState086 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState100 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState088 ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState083 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState016 ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState017 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState018 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState058 ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState021 ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState055 ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState053 ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState051 ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState049 ->
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState045 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState043 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState041 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState039 ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState036 ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState034 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState032 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState030 ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState024 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_119 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _1 = _v in
          let _v = _menhir_action_41 _1 in
          _menhir_goto_for_init _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_026 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState026 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_016 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState016 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_017 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState017 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_018 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LNOT (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState018 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_019 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_32 _1 _endpos__1_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_020 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LPAREN (_menhir_stack, _startpos_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState021
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState021
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState021
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState021
          | INT_LIT _v_1 ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState021
          | IDENT _v_2 ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState021
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState021
          | RPAREN ->
              let _v_3 = _menhir_action_01 () in
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3
          | _ ->
              _eRR ())
      | ASSIGN | COMMA | DIV | EQ | GE | GT | LAND | LE | LOR | LT | MINUS | MUL | NEQ | PLUS | REM | RPAREN | SEMICOLON ->
          let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_50 _1 _endpos__1_ _startpos__1_ in
          let (_endpos, _startpos) = (_endpos__1_, _startpos__1_) in
          (match (_tok : MenhirBasics.token) with
          | ASSIGN ->
              let _menhir_stack = MenhirCell1_lval (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
              let _menhir_s = MenhirState024 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRUE ->
                  _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | MINUS ->
                  _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LPAREN ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LNOT ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT_LIT _v ->
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | IDENT _v ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FALSE ->
                  _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | COMMA | DIV | EQ | GE | GT | LAND | LE | LOR | LT | MINUS | MUL | NEQ | PLUS | REM | RPAREN | SEMICOLON ->
              let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
              let _v = _menhir_action_30 _1 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
          | _ ->
              _menhir_fail ())
      | _ ->
          _eRR ()
  
  and _menhir_run_022 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_34 _endpos__1_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_061 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT _menhir_cell0_LPAREN -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let (_3, _endpos__4_) = (_v, _endpos) in
      let _v = _menhir_action_06 _1 _3 _endpos__4_ _startpos__1_ in
      let (_endpos, _startpos) = (_endpos__4_, _startpos__1_) in
      let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_35 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_030 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState030 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_039 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState039 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState032 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_041 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell0_MINUS (_menhir_stack, _startpos) in
      let _menhir_s = MenhirState041 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_043 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState043 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_045 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState045 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_047 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState047 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_049 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState049 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_051 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState051 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_053 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState053 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_055 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState055 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_034 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState034 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_036 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState036 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_for_init : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _1 = _v in
      let _v = _menhir_action_42 _1 in
      _menhir_goto_for_init_opt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_for_init_opt : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_for_init_opt (_menhir_stack, _menhir_s, _v) in
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_SEMICOLON (_menhir_stack, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | INT_LIT _v_0 ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState096
      | IDENT _v_1 ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState096
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState096
      | SEMICOLON ->
          let _v_2 = _menhir_action_37 () in
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState096 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_for_init_opt _menhir_cell0_SEMICOLON as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_opt (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_SEMICOLON (_menhir_stack, _startpos, _endpos) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
          | INT_LIT _v_0 ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState098
          | IDENT _v_1 ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState098
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
          | RPAREN ->
              let _v_2 = _menhir_action_37 () in
              _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState098 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_099 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_for_init_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_cell1_expr_opt _menhir_cell0_SEMICOLON as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_opt (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_RPAREN (_menhir_stack, _endpos) in
          let _menhir_s = MenhirState100 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SEMICOLON ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RETURN ->
              _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FOR ->
              _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONTINUE ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BREAK ->
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_013 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LPAREN (_menhir_stack, _startpos) in
          let _menhir_s = MenhirState014 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_069 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState069 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_070 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState071 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | ASSIGN ->
          let _v = _menhir_action_72 () in
          _menhir_goto_type_opt _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_002 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_68 _endpos__1_ _startpos__1_ in
      _menhir_goto_type_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_003 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_69 _endpos__1_ _startpos__1_ in
      _menhir_goto_type_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_082 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_39 _endpos__1_ _startpos__1_ in
      _menhir_goto_expr_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
  
  and _menhir_goto_expr_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      let (_endpos__1_, _1) = (_endpos, _v) in
      let _v = _menhir_action_58 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
  
  and _menhir_goto_statement : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState068 ->
          _menhir_run_127 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState012 ->
          _menhir_run_125 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_125 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | MenhirState086 ->
          _menhir_run_125 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState090 ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | MenhirState100 ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_127 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_RPAREN -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell0_RPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, _3, _, _) = _menhir_stack in
      let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos__5_, _5) = (_endpos, _v) in
      let _v = _menhir_action_74 _3 _5 _endpos__5_ _startpos__1_ in
      let _endpos = _endpos__5_ in
      let (_endpos__1_, _1) = (_endpos, _v) in
      let _v = _menhir_action_60 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
  
  and _menhir_run_125 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | VAR ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | TRUE ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | SEMICOLON ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | RETURN ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | MINUS ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | LPAREN ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | LNOT ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | LBRACE ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | INT_LIT _v_0 ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState125
      | IF ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | IDENT _v_1 ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState125
      | FOR ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | FALSE ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | CONTINUE ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | BREAK ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | RBRACE ->
          let _1 = _v in
          let _v = _menhir_action_66 _1 in
          _menhir_goto_statements _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_083 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState083 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_086 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState086 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | VAR ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | SEMICOLON ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | RETURN ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FOR ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CONTINUE ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BREAK ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_087 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LPAREN (_menhir_stack, _startpos) in
          let _menhir_s = MenhirState088 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_091 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_FOR (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LPAREN (_menhir_stack, _startpos) in
          let _menhir_s = MenhirState092 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VAR ->
              let _menhir_stack = MenhirCell1_VAR (_menhir_stack, _menhir_s) in
              let _menhir_s = MenhirState093 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SEMICOLON ->
              let _v = _menhir_action_43 () in
              _menhir_goto_for_init_opt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_101 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_startpos__1_, _endpos__2_) = (_startpos, _endpos) in
          let _v = _menhir_action_08 _endpos__2_ _startpos__1_ in
          let _endpos = _endpos__2_ in
          let (_endpos__1_, _1) = (_endpos, _v) in
          let _v = _menhir_action_63 _1 in
          _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_103 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_startpos__1_, _endpos__2_) = (_startpos, _endpos) in
          let _v = _menhir_action_05 _endpos__2_ _startpos__1_ in
          let _endpos = _endpos__2_ in
          let (_endpos__1_, _1) = (_endpos, _v) in
          let _v = _menhir_action_62 _1 in
          _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_statements : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState012 ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState125 ->
          _menhir_run_126 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState086 ->
          _menhir_run_123 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_128 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_type_expr _menhir_cell0_IDENT _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_param_list _menhir_cell0_RPAREN _menhir_cell0_LBRACE -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_LBRACE (_menhir_stack, _) = _menhir_stack in
      let MenhirCell0_RPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_param_list (_menhir_stack, _, _4) = _menhir_stack in
      let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2, _, _) = _menhir_stack in
      let MenhirCell1_type_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let (_7, _endpos__8_) = (_v, _endpos) in
      let _v = _menhir_action_45 _1 _2 _4 _7 _endpos__8_ _startpos__1_ in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          let _menhir_stack = MenhirCell1_function_decl (_menhir_stack, _menhir_s, _v) in
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState136
      | INT ->
          let _menhir_stack = MenhirCell1_function_decl (_menhir_stack, _menhir_s, _v) in
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState136
      | BOOL ->
          let _menhir_stack = MenhirCell1_function_decl (_menhir_stack, _menhir_s, _v) in
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState136
      | EOF ->
          let _1 = _v in
          let _v = _menhir_action_46 _1 in
          _menhir_goto_functions _menhir_stack _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_126 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_statement -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_statement (_menhir_stack, _menhir_s, _1, _) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_67 _1 _2 in
      _menhir_goto_statements _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_123 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_2, _endpos__3_) = (_v, _endpos) in
      let _v = _menhir_action_07 _2 _endpos__3_ _startpos__1_ in
      let (_endpos, _startpos) = (_endpos__3_, _startpos__1_) in
      let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_64 _1 _endpos__1_ _startpos__1_ in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
  
  and _menhir_run_122 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_RPAREN, _menhir_box_program) _menhir_cell1_statement -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_statement (_menhir_stack, _, _5, _) = _menhir_stack in
      let MenhirCell0_RPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, _3, _, _) = _menhir_stack in
      let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos__7_, _7) = (_endpos, _v) in
      let _v = _menhir_action_49 _3 _5 _7 _endpos__7_ _startpos__1_ in
      _menhir_goto_if_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__7_ _v _menhir_s _tok
  
  and _menhir_goto_if_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      let (_endpos__1_, _1) = (_endpos, _v) in
      let _v = _menhir_action_59 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
  
  and _menhir_run_120 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_RPAREN as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v, _endpos) in
          let _menhir_s = MenhirState121 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SEMICOLON ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RETURN ->
              _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FOR ->
              _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONTINUE ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BREAK ->
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | BREAK | CONTINUE | FALSE | FOR | IDENT _ | IF | INT_LIT _ | LBRACE | LNOT | LPAREN | MINUS | RBRACE | RETURN | SEMICOLON | TRUE | VAR | WHILE ->
          let MenhirCell0_RPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _, _3, _, _) = _menhir_stack in
          let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos__5_, _5) = (_endpos, _v) in
          let _v = _menhir_action_48 _3 _5 _endpos__5_ _startpos__1_ in
          _menhir_goto_if_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__5_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_107 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_for_init_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_cell1_expr_opt _menhir_cell0_SEMICOLON, _menhir_box_program) _menhir_cell1_expr_opt _menhir_cell0_RPAREN -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell0_RPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr_opt (_menhir_stack, _, _7) = _menhir_stack in
      let MenhirCell0_SEMICOLON (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_expr_opt (_menhir_stack, _, _5) = _menhir_stack in
      let MenhirCell0_SEMICOLON (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_for_init_opt (_menhir_stack, _, _3) = _menhir_stack in
      let MenhirCell0_LPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_FOR (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos__9_, _9) = (_endpos, _v) in
      let _v = _menhir_action_44 _3 _5 _7 _9 _endpos__9_ _startpos__1_ in
      let _endpos = _endpos__9_ in
      let (_endpos__1_, _1) = (_endpos, _v) in
      let _v = _menhir_action_61 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
  
  and _menhir_run_117 : type  ttv_stack. (ttv_stack _menhir_cell0_SEMICOLON as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN | SEMICOLON ->
          let _1 = _v in
          let _v = _menhir_action_36 _1 in
          _menhir_goto_expr_opt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr_opt : type  ttv_stack. (ttv_stack _menhir_cell0_SEMICOLON as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState098 ->
          _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_112 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_startpos__1_, _1, _endpos__2_) = (_startpos, _v, _endpos_1) in
          let _v = _menhir_action_38 _1 _endpos__2_ _startpos__1_ in
          _menhir_goto_expr_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__2_ _v _menhir_s _tok
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_089 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IF _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_RPAREN (_menhir_stack, _endpos) in
          let _menhir_s = MenhirState090 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SEMICOLON ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RETURN ->
              _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FOR ->
              _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONTINUE ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BREAK ->
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | REM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_084 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_RETURN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_RETURN (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_2, _endpos__3_) = (_v, _endpos_1) in
          let _v = _menhir_action_56 _2 _endpos__3_ _startpos__1_ in
          let _endpos = _endpos__3_ in
          let (_endpos__1_, _1) = (_endpos, _v) in
          let _v = _menhir_action_65 _1 in
          _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_075 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IDENT _menhir_cell0_type_opt as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let MenhirCell0_type_opt (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__4_, _4) = (_endpos, _v) in
          let _v = _menhir_action_09 _1 _2 _4 _endpos__4_ _startpos__1_ in
          let (_endpos, _startpos) = (_endpos__4_, _startpos__1_) in
          let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_11 _1 in
          _menhir_goto_declarations _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_declarations : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s ->
      match _menhir_s with
      | MenhirState080 ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v
      | MenhirState093 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s
      | MenhirState069 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_081 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_declaration -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v ->
      let MenhirCell1_declaration (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let (_endpos__3_, _3) = (_endpos, _v) in
      let _v = _menhir_action_12 _1 _3 in
      _menhir_goto_declarations _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s
  
  and _menhir_run_076 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_VAR as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s ->
      let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_10 _1 _endpos__1_ _startpos__1_ in
      _menhir_goto_declaration_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_declaration_block : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_VAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState093 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState069 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_094 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_LPAREN, _menhir_box_program) _menhir_cell1_VAR -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_VAR (_menhir_stack, _menhir_s) = _menhir_stack in
      let _2 = _v in
      let _v = _menhir_action_40 _2 in
      _menhir_goto_for_init _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_077 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_VAR -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_VAR (_menhir_stack, _menhir_s) = _menhir_stack in
      let (_2, _endpos__3_) = (_v, _endpos) in
      let _v = _menhir_action_73 _2 in
      let _endpos = _endpos__3_ in
      let (_endpos__1_, _1) = (_endpos, _v) in
      let _v = _menhir_action_57 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _menhir_s _tok
  
  and _menhir_run_067 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_RPAREN (_menhir_stack, _endpos) in
          let _menhir_s = MenhirState068 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SEMICOLON ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RETURN ->
              _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FOR ->
              _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONTINUE ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BREAK ->
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | REM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_066 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos__2_, _2) = (_endpos, _v) in
      let _v = _menhir_action_27 _2 _endpos__2_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__2_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_064 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LPAREN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_2, _endpos__3_) = (_v, _endpos_0) in
          let _v = _menhir_action_29 _2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_063 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_LNOT -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_LNOT (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos__2_, _2) = (_endpos, _v) in
      let _v = _menhir_action_28 _2 _endpos__2_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__2_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_059 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | REM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_038 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_expr (_menhir_stack, _, _3, _, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let _endpos__4_ = _endpos in
      let _v = _menhir_action_13 _1 _3 _endpos__4_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__4_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_058 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | MINUS ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | LPAREN ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | LNOT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | INT_LIT _v ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState058
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState058
      | FALSE ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | RPAREN ->
          let _v = _menhir_action_01 () in
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_060 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _, _) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_03 _1 _3 in
      _menhir_goto_arg_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_arg_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState021 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState058 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_057 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IDENT _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _1 = _v in
          let _v = _menhir_action_02 _1 in
          _menhir_goto_arg_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_056 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | NEQ | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_25 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_054 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | NEQ | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_22 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_052 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | NEQ | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_21 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_050 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND | LOR | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_24 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_048 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | NEQ | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_20 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_046 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_23 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_044 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | NEQ | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_19 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_042 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr _menhir_cell0_MINUS as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | MINUS | NEQ | PLUS | RPAREN | SEMICOLON ->
          let MenhirCell0_MINUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_15 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | NEQ | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_26 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_037 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | REM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LOR ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_035 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let (_endpos__3_, _3) = (_endpos, _v) in
      let _v = _menhir_action_17 _1 _3 _endpos__3_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_033 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let (_endpos__3_, _3) = (_endpos, _v) in
      let _v = _menhir_action_16 _1 _3 _endpos__3_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_031 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ | GE | GT | LAND | LE | LOR | LT | MINUS | NEQ | PLUS | RPAREN | SEMICOLON ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_14 _1 _3 _endpos__3_ _startpos__1_ in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_027 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let (_endpos__3_, _3) = (_endpos, _v) in
      let _v = _menhir_action_18 _1 _3 _endpos__3_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_025 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_lval as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | REM ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LAND | LOR | RPAREN | SEMICOLON ->
          let MenhirCell1_lval (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
          let (_endpos__3_, _3) = (_endpos, _v) in
          let _v = _menhir_action_04 _1 _3 _endpos__3_ _startpos__1_ in
          let (_endpos, _startpos) = (_endpos__3_, _startpos__1_) in
          let (_endpos__1_, _startpos__1_, _1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_31 _1 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_009 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1, _startpos__1_, _) = _menhir_stack in
      let (_endpos__3_, _3) = (_endpos, _v) in
      let _v = _menhir_action_51 _1 _3 _endpos__3_ _startpos__1_ in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_param (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState131
          | RPAREN ->
              let _v_1 = _menhir_action_52 () in
              _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1
          | _ ->
              _eRR ())
      | RPAREN ->
          let _1 = _v in
          let _v = _menhir_action_53 _1 in
          _menhir_goto_param_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_007 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState008 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_132 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_param -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_param (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_54 _1 _3 in
      _menhir_goto_param_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_param_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState131 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState006 ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_010 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_type_expr _menhir_cell0_IDENT _menhir_cell0_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_param_list (_menhir_stack, _menhir_s, _v) in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_RPAREN (_menhir_stack, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LBRACE (_menhir_stack, _startpos) in
          let _menhir_s = MenhirState012 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | VAR ->
              _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TRUE ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | SEMICOLON ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RETURN ->
              _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LNOT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT_LIT _v ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FOR ->
              _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FALSE ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CONTINUE ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BREAK ->
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_004 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_type_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _startpos_1 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_2 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_0, _startpos_1, _endpos_2) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _startpos_3 = _menhir_lexbuf.Lexing.lex_start_p in
              let _menhir_stack = MenhirCell0_LPAREN (_menhir_stack, _startpos_3) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_4 ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState006
              | RPAREN ->
                  let _v_5 = _menhir_action_52 () in
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState006
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState000 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VOID ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

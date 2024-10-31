(* parser.mly *)

%{
  open Ast
  open Location

  let mk_loc startpos endpos = 
    { Location.start_pos = startpos;
      Location.end_pos = endpos }
%}

%token <string> IDENT
%token <int64> INT_LIT
%token <string> STRING_LIT
%token TRUE FALSE NIL VAR LET IF ELSE WHILE FOR BREAK CONTINUE RETURN NEW
%token INT BOOL STRING BYTE VOID RECORD
%token PLUS MINUS MUL DIV REM LT LE GT GE LOR LAND LNOT
%token EQ NEQ ASSIGN QUESTIONMARK COLON COMMA SEMICOLON
%token DOT LBRACKET RBRACKET LBRACE RBRACE LPAREN RPAREN
%token EOF

%start program
%type <Ast.program> program

%left LOR
%left LAND
%nonassoc EQ NEQ
%nonassoc LT LE GT GE
%left PLUS MINUS
%left MUL DIV REM
%right UMINUS LNOT

%%

program:
  | statements EOF { $1 }

statements:
  | statement
    { [$1] }
  | statement statements
    { $1 :: $2 }

statement:
  | var_decl_stmt
    { VarDeclStm $1 }
  | expr_stmt
    { ExprStm { expr = $1; loc = mk_loc $startpos $endpos } }
  | if_stmt
    { $1 }
  | while_stmt
    { $1 }
  | for_stmt
    { $1 }
  | break_stmt
    { $1 }
  | continue_stmt
    { $1 }
  | compound_stmt
    { CompoundStm { stms = $1; loc = mk_loc $startpos $endpos } }
  | return_stmt
    { ReturnStm { ret = $1; loc = mk_loc $startpos $endpos } }


return_stmt:
  | RETURN expr_opt SEMICOLON
    { $2 }

(* Break Statement *)
break_stmt:
  | BREAK SEMICOLON
    { BreakStm { loc = mk_loc $startpos $endpos } }

(* Continue Statement *)
continue_stmt:
  | CONTINUE SEMICOLON
    { ContinueStm { loc = mk_loc $startpos $endpos } }

var_decl_stmt:
  | VAR declaration_block SEMICOLON
    { $2 }

declaration_block:
  | declarations
    { DeclBlock { declarations = $1; loc = mk_loc $startpos $endpos } }

declarations:
  | declaration
    { [$1] }
  | declaration COMMA declarations
    { $1 :: $3 }

declaration:
  | IDENT type_opt ASSIGN expr
    { 
      Declaration { 
        name = Ident { name = $1; loc = mk_loc $startpos1 $endpos1 }; 
        tp = $2; 
        body = $4;
        loc = mk_loc $startpos $endpos 
      } 
    }

type_opt:
  | COLON type_new
    { Some $2 }
  | /* empty */
    { None }

expr_stmt:
  | expr SEMICOLON
    { Some $1 }
  | SEMICOLON
    { None }

if_stmt:
  | IF LPAREN expr RPAREN statement
    { 
      IfThenElseStm {
        cond = $3;
        thbr = $5;
        elbro = None;
        loc = mk_loc $startpos $endpos
      }
    }
  | IF LPAREN expr RPAREN statement ELSE statement
    { 
      IfThenElseStm {
        cond = $3;
        thbr = $5;
        elbro = Some $7;
        loc = mk_loc $startpos $endpos
      }
    }

while_stmt:
  | WHILE LPAREN expr RPAREN statement
    { 
      WhileStm { 
        cond = $3; 
        body = $5;
        loc = mk_loc $startpos $endpos
      } 
    }

for_stmt:
  | FOR LPAREN for_init_opt SEMICOLON expr_opt SEMICOLON expr_opt RPAREN statement
    { 
      ForStm {
        init = $3;
        cond = $5;
        update = $7;
        body = $9;
        loc = mk_loc $startpos $endpos
      }
    }

for_init_opt:
  | for_init
    { Some $1 }
  | /* empty */
    { None }

for_init:
  | declaration_block
    { FIDecl $1 }
  | expr
    { FIExpr $1 }

expr_opt:
  | expr
    { Some $1 }
  | /* empty */
    { None }

compound_stmt:
  | LBRACE statements RBRACE
    { $2 }

expr:
  | expr PLUS expr
    { BinOp { left = $1; op = Plus { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr MINUS expr
    { BinOp { left = $1; op = Minus { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr MUL expr
    { BinOp { left = $1; op = Mul { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr DIV expr
    { BinOp { left = $1; op = Div { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr REM expr
    { BinOp { left = $1; op = Rem { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LT expr
    { BinOp { left = $1; op = Lt { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LE expr
    { BinOp { left = $1; op = Le { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr GT expr
    { BinOp { left = $1; op = Gt { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr GE expr
    { BinOp { left = $1; op = Ge { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LOR expr
    { BinOp { left = $1; op = Lor { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LAND expr
    { BinOp { left = $1; op = Land { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr EQ expr
    { BinOp { left = $1; op = Eq { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr NEQ expr
    { BinOp { left = $1; op = NEq { loc = mk_loc $startpos2 $endpos2 }; right = $3; loc = mk_loc $startpos $endpos } }
  | MINUS expr %prec UMINUS
    { UnOp { op = Neg { loc = mk_loc $startpos1 $endpos1 }; operand = $2; loc = mk_loc $startpos $endpos } }
  | LNOT expr %prec LNOT
    { UnOp { op = Lnot { loc = mk_loc $startpos1 $endpos1 }; operand = $2; loc = mk_loc $startpos $endpos } }
  | LPAREN expr RPAREN
    { $2 }
  | lval
    { Lval $1 }
  | assignment
    { $1 }
  | call
    { $1 }
  | INT_LIT
    { Integer { int = $1; loc = mk_loc $startpos $endpos } }
  | TRUE
    { Boolean { bool = true; loc = mk_loc $startpos $endpos } }
  | FALSE
    { Boolean { bool = false; loc = mk_loc $startpos $endpos } }

lval:
  | IDENT
    { Var (Ident { name = $1; loc = mk_loc $startpos $endpos }) }

assignment:
  | lval ASSIGN expr
    { 
      Assignment { 
        lvl = $1; 
        rhs = $3;
        loc = mk_loc $startpos $endpos 
      } 
    }

call:
  | IDENT LPAREN arg_list RPAREN
    { 
      Call { 
        fname = Ident { name = $1; loc = mk_loc $startpos1 $endpos1 }; 
        args = $3;
        loc = mk_loc $startpos $endpos 
      } 
    }

arg_list:
  | expr
    { [$1] }
  | expr COMMA arg_list
    { $1 :: $3 }
  | /* empty */
    { [] }

type_new:
  | INT
    { Int { loc = mk_loc $startpos $endpos } }
  | BOOL
    { Bool { loc = mk_loc $startpos $endpos } }
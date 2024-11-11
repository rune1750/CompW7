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
%token TRUE FALSE VAR IF ELSE WHILE FOR BREAK CONTINUE RETURN BYTE NIL LET NEW 
%token INT BOOL STRING VOID RECORD QUESTIONMARK DOT
%token PLUS MINUS MUL DIV REM LT LE GT GE LOR LAND LNOT
%token EQ NEQ ASSIGN COLON COMMA SEMICOLON
%token LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET
%token EOF

%start program
%type <Ast.program> program
%type <Ast.statement list> statements
%type <Ast.statement> statement
%type <Ast.statement> var_decl_stmt
%type <Ast.statement> expr_stmt
%type <Ast.statement> if_stmt
%type <Ast.statement> while_stmt
%type <Ast.statement> for_stmt
%type <Ast.for_init option> for_init_opt
%type <Ast.for_init> for_init
%type <Ast.statement> break_stmt
%type <Ast.statement> continue_stmt
%type <Ast.statement> compound_stmt
%type <Ast.statement> return_stmt
%type <Ast.declaration_block> declaration_block
%type <Ast.single_declaration list> declarations
%type <Ast.single_declaration> declaration
%type <Ast.typ option> type_opt
%type <Ast.expr option> expr_opt
%type <Ast.expr> expr
%type <Ast.lval> lval
%type <Ast.expr> assignment
%type <Ast.expr> call
%type <Ast.expr list> arg_list
%type <Ast.typ> type_expr

(*New rules for W7*)
%type <Ast.single_declaration> function_decl
%type <Ast.param list> param_list
%type <Ast.param> param

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%nonassoc EQ NEQ LT LE GT GE
%left LOR
%left LAND
%left PLUS MINUS
%left MUL DIV REM
%right UMINUS LNOT

%%

program:
    functions_and_statements EOF { { functions = fst $1; main_body = snd $1 } }

statements:
    statement
      { [$1] }
  | statement statements
      { $1 :: $2 }

statement:
    var_decl_stmt
      { $1 }
  | expr_stmt
      { $1 }
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
      { CompoundStm { stms = [$1]; loc = mk_loc $startpos $endpos } }
  | return_stmt
      { $1 }

return_stmt:
    RETURN expr SEMICOLON
      { ReturnStm { ret = $2; loc = mk_loc $startpos $endpos } }

break_stmt:
    BREAK SEMICOLON
      { BreakStm { loc = mk_loc $startpos $endpos } }

continue_stmt:
    CONTINUE SEMICOLON
      { ContinueStm { loc = mk_loc $startpos $endpos } }

var_decl_stmt:
    VAR declaration_block SEMICOLON
      { VarDeclStm $2 }
      
declaration_block:
    declarations
      { DeclBlock { declarations = $1; loc = mk_loc $startpos $endpos } }

declarations:
    declaration
      { [$1] }
  | declaration COMMA declarations
      { $1 :: $3 }

declaration:
    IDENT type_opt ASSIGN expr
      { 
        Declaration { 
          name = Ident { name = $1; loc = mk_loc $startpos $endpos }; 
          tp = $2; 
          body = $4;
          loc = mk_loc $startpos $endpos 
        } 
      }

type_opt:
    COLON type_expr
      { Some $2 }
  | /* empty */
      { None }

type_expr:
    INT
      { Int { loc = mk_loc $startpos $endpos } }
  | BOOL
      { Bool { loc = mk_loc $startpos $endpos } }

expr_stmt:
    expr SEMICOLON
      { ExprStm { expr = Some $1; loc = mk_loc $startpos $endpos } }
  | SEMICOLON
      { ExprStm { expr = None; loc = mk_loc $startpos $endpos } }

if_stmt:
    IF LPAREN expr RPAREN statement %prec LOWER_THAN_ELSE
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
    WHILE LPAREN expr RPAREN statement
      { 
        WhileStm { 
          cond = $3; 
          body = $5;
          loc = mk_loc $startpos $endpos
        } 
      }

for_stmt:
    FOR LPAREN for_init_opt SEMICOLON expr_opt SEMICOLON expr_opt RPAREN statement
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
    for_init
      { Some $1 }
  | /* empty */
      { None }

for_init:
    VAR declaration_block
      { FIDecl $2 }
  | expr
      { FIExpr $1 }

expr_opt:
    expr
      { Some $1 }
  | /* empty */
      { None }

compound_stmt:
    LBRACE statements RBRACE
      { CompoundStm { stms = $2; loc = mk_loc $startpos $endpos } }

expr:
    expr PLUS expr
      { BinOp { left = $1; op = Plus { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr MINUS expr
      { BinOp { left = $1; op = Minus { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr MUL expr
      { BinOp { left = $1; op = Mul { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr DIV expr
      { BinOp { left = $1; op = Div { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr REM expr
      { BinOp { left = $1; op = Rem { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LT expr
      { BinOp { left = $1; op = Lt { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LE expr
      { BinOp { left = $1; op = Le { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr GT expr
      { BinOp { left = $1; op = Gt { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr GE expr
      { BinOp { left = $1; op = Ge { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LOR expr
      { BinOp { left = $1; op = Lor { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr LAND expr
      { BinOp { left = $1; op = Land { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr EQ expr
      { BinOp { left = $1; op = Eq { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | expr NEQ expr
      { BinOp { left = $1; op = NEq { loc = mk_loc $startpos $endpos }; right = $3; loc = mk_loc $startpos $endpos } }
  | MINUS expr %prec UMINUS
      { UnOp { op = Neg { loc = mk_loc $startpos $endpos }; operand = $2; loc = mk_loc $startpos $endpos } }
  | LNOT expr %prec LNOT
      { UnOp { op = Lnot { loc = mk_loc $startpos $endpos }; operand = $2; loc = mk_loc $startpos $endpos } }
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
  | expr COMMA expr
      {}

lval:
    IDENT
      { Var (Ident { name = $1; loc = mk_loc $startpos $endpos }) }

assignment:
    lval ASSIGN expr %prec EQ
      { Assignment { lvl = $1; rhs = $3; loc = mk_loc $startpos $endpos } }

call:
    IDENT LPAREN arg_list RPAREN
      { 
        Call { 
          fname = Ident { name = $1; loc = mk_loc $startpos $endpos }; 
          args = $3;
          loc = mk_loc $startpos $endpos 
        } 
      }

arg_list:
    expr
      { [$1] }
  | expr COMMA arg_list
      { $1 :: $3 }
  | /* empty */
      { [] }

(*New rules for W7*)
functions_and_statements:
    function_decl functions_and_statements
      { ($1 :: fst $2, snd $2) }
  | statement functions_and_statements
      { (fst $2, $1 :: snd $2) }
  | /* empty */
      { ([], []) }

function_decl:
    IDENT LPAREN param_list RPAREN COLON type_expr LBRACE statements RBRACE
      { 
        Function { 
          fname = Ident { name = $1; loc = mk_loc $startpos $endpos };
          funtype = FunTyp { ret = $6; params = $3 };
          body = $8;
          loc = mk_loc $startpos $endpos 
        } 
      }

param_list:
    param COMMA param_list
      { $1 :: $3 }
  | param
      { [$1] }
  | /* empty */
      { [] }

param:
    IDENT COLON type_expr
      { 
        Param { 
          paramname = Ident { name = $1; loc = mk_loc $startpos $endpos }; 
          typ = $3 
        } 
      }
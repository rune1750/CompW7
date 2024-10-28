(* parser.mly *)

%{
  (* Header Section *)

  open Ast
  open Location

  (* You can add helper functions or open additional modules here *)
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

(* Grammar Rules *)

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
    { ExprStm $1 }
  | if_stmt
    { IfThenElseStm $1 }
  | while_stmt
    { WhileStm $1 }
  | for_stmt
    { ForStm $1 }
  | break_stmt
    { BreakStm }
  | continue_stmt
    { ContinueStm }
  | compound_stmt
    { CompoundStm { stms = $1 } }
  | return_stmt
    { ReturnStm { ret = $1 } }

(* Variable Declaration Statement *)
var_decl_stmt:
  | VAR declaration_block SEMICOLON
    { $2 }

(* Declaration Block *)
declaration_block:
  | declarations
    { DeclBlock $1 }

declarations:
  | declaration
    { [$1] }
  | declaration COMMA declarations
    { $1 :: $3 }

declaration:
  | IDENT type_opt ASSIGN expr
    { 
      Declaration { 
        name = Ident { name = $1 }; 
        tp = $2; 
        body = $4 
      } 
    }

type_opt:
  | COLON type
    { Some $2 }
  | /* empty */
    { None }

(* Expression Statement *)
expr_stmt:
  | expr SEMICOLON
    { Some $1 }
  | SEMICOLON
    { None }

(* If-Then-Else Statement *)
if_stmt:
  | IF LPAREN expr RPAREN statement
    { 
      { cond = $3; thbr = $5; elbro = None } 
    }
  | IF LPAREN expr RPAREN statement ELSE statement
    { 
      { cond = $3; thbr = $5; elbro = Some $7 } 
    }

(* While Statement *)
while_stmt:
  | WHILE LPAREN expr RPAREN statement
    { 
      { cond = $3; body = $5 } 
    }

(* For Statement *)
for_stmt:
  | FOR LPAREN for_init SEMICOLON expr_opt SEMICOLON expr_opt RPAREN statement
    { 
      { init = $3; cond = $5; update = $7; body = $9 } 
    }

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

(* Break Statement *)
break_stmt:
  | BREAK SEMICOLON
    { () }

(* Continue Statement *)
continue_stmt:
  | CONTINUE SEMICOLON
    { () }

(* Compound Statement *)
compound_stmt:
  | LBRACE statements RBRACE
    { $2 }

(* Return Statement *)
return_stmt:
  | RETURN expr SEMICOLON
    { $2 }

(* Expressions *)
expr:
  | expr PLUS expr
    { BinOp { left = $1; op = Plus; right = $3; tp = ErrorType } }
  | expr MINUS expr
    { BinOp { left = $1; op = Minus; right = $3; tp = ErrorType } }
  | expr MUL expr
    { BinOp { left = $1; op = Mul; right = $3; tp = ErrorType } }
  | expr DIV expr
    { BinOp { left = $1; op = Div; right = $3; tp = ErrorType } }
  | expr REM expr
    { BinOp { left = $1; op = Rem; right = $3; tp = ErrorType } }
  | expr LT expr
    { BinOp { left = $1; op = Lt; right = $3; tp = ErrorType } }
  | expr LE expr
    { BinOp { left = $1; op = Le; right = $3; tp = ErrorType } }
  | expr GT expr
    { BinOp { left = $1; op = Gt; right = $3; tp = ErrorType } }
  | expr GE expr
    { BinOp { left = $1; op = Ge; right = $3; tp = ErrorType } }
  | expr LOR expr
    { BinOp { left = $1; op = Lor; right = $3; tp = ErrorType } }
  | expr LAND expr
    { BinOp { left = $1; op = Land; right = $3; tp = ErrorType } }
  | expr EQ expr
    { BinOp { left = $1; op = Eq; right = $3; tp = ErrorType } }
  | expr NEQ expr
    { BinOp { left = $1; op = NEq; right = $3; tp = ErrorType } }
  | MINUS expr %prec UMINUS
    { UnOp { op = Neg; operand = $2; tp = ErrorType } }
  | LNOT expr %prec LNOT
    { UnOp { op = Lnot; operand = $2; tp = ErrorType } }
  | LPAREN expr RPAREN
    { $2 }
  | lval
    { Lval $1 }
  | assignment
    { $1 }
  | call
    { $1 }
  | INT_LIT
    { Integer { int = $1 } }
  | TRUE
    { Boolean { bool = true } }
  | FALSE
    { Boolean { bool = false } }

(* L-values *)
lval:
  | IDENT
    { Var { ident = Ident { name = $1 }; tp = ErrorType } }

(* Assignments *)
assignment:
  | lval ASSIGN expr
    { 
      Assignment { 
        lvl = $1; 
        rhs = $3; 
        tp = ErrorType 
      } 
    }

(* Function Calls *)
call:
  | IDENT LPAREN arg_list RPAREN
    { 
      Call { 
        fname = Ident { name = $1 }; 
        args = $3; 
        tp = ErrorType 
      } 
    }

arg_list:
  | expr
    { [$1] }
  | expr COMMA arg_list
    { $1 :: $3 }
  | /* empty */
    { [] }

(* Types *)
type:
  | INT
    { Int }
  | BOOL
    { Bool }
  | STRING
    { String }
  | BYTE
    { Byte }
  | VOID
    { Void }
  | RECORD
    { Record }
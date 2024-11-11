module Sym = Symbol

type ident = Ident of { sym : Sym.symbol }

type typ = 
  | Void 
  | Int 
  | Bool 
  | ErrorType

type binop = 
  | Plus | Minus | Mul | Div | Rem 
  | Lt | Le | Gt | Ge 
  | Lor | Land | Eq | NEq

type unop = 
  | Neg 
  | Lnot

type expr =
  | Integer of { int : int64 }
  | Boolean of { bool : bool }
  | BinOp of { left : expr; op : binop; right : expr; tp : typ }
  | UnOp of { op : unop; operand : expr; tp : typ }
  | Lval of lval
  | Assignment of { lvl : lval; rhs : expr; tp : typ }
  | Call of { fname : ident; args : expr list; tp : typ }
  | CommaExpr of { exprs : expr list; tp : typ }  (* Retained CommaExpr for sequencing *)
and lval =
  | Var of { ident : ident; tp : typ }

type single_declaration = 
  Declaration of { name : ident; tp : typ; body : expr }

type declaration_block = 
  DeclBlock of { declarations : single_declaration list }

type for_init =
  | FIDecl of declaration_block
  | FIExpr of expr

type statement =
  | VarDeclStm of declaration_block
  | ExprStm of { expr : expr option }
  | IfThenElseStm of { cond : expr; thbr : statement; elbro : statement option }
  | WhileStm of { cond : expr; body : statement }
  | ForStm of { init : for_init option; cond : expr option; update : expr option; body : statement }
  | BreakStm
  | ContinueStm
  | CompoundStm of { stms : statement list }
  | ReturnStm of { ret : expr }

type param = Param of { paramname : ident; typ : typ }

type funtype = FunTyp of { ret : typ; params : param list }

type function_decl = Function of {
  f_name : ident;
  funtype : funtype;
  body : statement list;
}

type program = function_decl list
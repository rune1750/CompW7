(* test.ml *)

open Semant
open Ast
open Errors
open TypedPretty
open Pretty
open PrintBox
open Codegen
open Ll

(* Positive Test 1: Multiple variable declarations in one statement *)
let test_program_1 : Ast.program = [
  VarDeclStm (DeclBlock [
    Declaration { name = Ident { name = "x" }; tp = Some Int; body = Integer { int = 10L } };
    Declaration { name = Ident { name = "y" }; tp = Some Int; body = Integer { int = 20L } };
    Declaration { name = Ident { name = "z" }; tp = Some Int; body = BinOp {
      left = Lval (Var (Ident { name = "x" }));
      op = Plus;
      right = Lval (Var (Ident { name = "y" }))
    }}
  ]);
  ReturnStm { ret = Lval (Var (Ident { name = "z" })) }
]

(* Positive Test 2: For loop with break and continue *)
let test_program_2 : Ast.program = [
  VarDeclStm (DeclBlock [
    Declaration { name = Ident { name = "sum" }; tp = Some Int; body = Integer { int = 0L } }
  ]);
  ForStm {
    init = Some (FIDecl (DeclBlock [
      Declaration { name = Ident { name = "i" }; tp = Some Int; body = Integer { int = 0L } }
    ]));
    cond = Some (BinOp {
      left = Lval (Var (Ident { name = "i" }));
      op = Lt;
      right = Integer { int = 10L }
    });
    update = Some (Assignment {
      lvl = Var (Ident { name = "i" });
      rhs = BinOp {
        left = Lval (Var (Ident { name = "i" }));
        op = Plus;
        right = Integer { int = 1L }
      }
    });
    body = CompoundStm {
      stms = [
        IfThenElseStm {
          cond = BinOp {
            left = BinOp {
              left = Lval (Var (Ident { name = "i" }));
              op = Rem;
              right = Integer { int = 2L }
            };
            op = Eq;
            right = Integer { int = 0L }
          };
          thbr = CompoundStm {
            stms = [
              ContinueStm
            ]
          };
          elbro = None
        };
        ExprStm { expr = Some (Assignment {
          lvl = Var (Ident { name = "sum" });
          rhs = BinOp {
            left = Lval (Var (Ident { name = "sum" }));
            op = Plus;
            right = Lval (Var (Ident { name = "i" }))
          }
        }) };
        IfThenElseStm {
          cond = BinOp {
            left = Lval (Var (Ident { name = "sum" }));
            op = Gt;
            right = Integer { int = 20L }
          };
          thbr = BreakStm;
          elbro = None
        }
      ]
    }
  };
  ReturnStm { ret = Lval (Var (Ident { name = "sum" })) }
]

(* Positive Test 3: While loop with nested loops *)
let test_program_3 : Ast.program = [
  VarDeclStm (DeclBlock [
    Declaration { name = Ident { name = "i" }; tp = Some Int; body = Integer { int = 0L } }
  ]);
  WhileStm {
    cond = BinOp {
      left = Lval (Var (Ident { name = "i" }));
      op = Lt;
      right = Integer { int = 3L }
    };
    body = CompoundStm {
      stms = [
        VarDeclStm (DeclBlock [
          Declaration { name = Ident { name = "j" }; tp = Some Int; body = Integer { int = 0L } }
        ]);
        ForStm {
          init = None;
          cond = Some (BinOp {
            left = Lval (Var (Ident { name = "j" }));
            op = Lt;
            right = Integer { int = 2L }
          });
          update = Some (Assignment {
            lvl = Var (Ident { name = "j" });
            rhs = BinOp {
              left = Lval (Var (Ident { name = "j" }));
              op = Plus;
              right = Integer { int = 1L }
            }
          });
          body = CompoundStm {
            stms = [
              ExprStm { expr = Some (Call {
                fname = Ident { name = "print_integer" };
                args = [ Lval (Var (Ident { name = "i" })) ]
              }) };
              BreakStm
            ]
          }
        };
        ExprStm { expr = Some (Assignment {
          lvl = Var (Ident { name = "i" });
          rhs = BinOp {
            left = Lval (Var (Ident { name = "i" }));
            op = Plus;
            right = Integer { int = 1L }
          }
        }) }
      ]
    }
  };
  ReturnStm { ret = Integer { int = 0L } }
]

(* Positive Test 4: Correct use of break and continue in nested loops *)
let test_program_4 : Ast.program = [
  VarDeclStm (DeclBlock [
    Declaration { name = Ident { name = "i" }; tp = Some Int; body = Integer { int = 0L } }
  ]);
  WhileStm {
    cond = BinOp {
      left = Lval (Var (Ident { name = "i" }));
      op = Lt;
      right = Integer { int = 5L }
    };
    body = CompoundStm {
      stms = [
        VarDeclStm (DeclBlock [
          Declaration { name = Ident { name = "j" }; tp = Some Int; body = Integer { int = 0L } }
        ]);
        WhileStm {
          cond = BinOp {
            left = Lval (Var (Ident { name = "j" }));
            op = Lt;
            right = Integer { int = 5L }
          };
          body = CompoundStm {
            stms = [
              IfThenElseStm {
                cond = BinOp {
                  left = Lval (Var (Ident { name = "j" }));
                  op = Eq;
                  right = Integer { int = 2L }
                };
                thbr = BreakStm;
                elbro = None
              };
              ExprStm { expr = Some (Assignment {
                lvl = Var (Ident { name = "j" });
                rhs = BinOp {
                  left = Lval (Var (Ident { name = "j" }));
                  op = Plus;
                  right = Integer { int = 1L }
                }
              }) }
            ]
          }
        };
        ExprStm { expr = Some (Assignment {
          lvl = Var (Ident { name = "i" });
          rhs = BinOp {
            left = Lval (Var (Ident { name = "i" }));
            op = Plus;
            right = Integer { int = 1L }
          }
        }) }
      ]
    }
  };
  ReturnStm { ret = Integer { int = 0L } }
]

(* Positive Test 5: All features together *)
let test_program_5 : Ast.program = [
  VarDeclStm (DeclBlock [
    Declaration { name = Ident { name = "a" }; tp = Some Int; body = Integer { int = 1L } };
    Declaration { name = Ident { name = "b" }; tp = Some Int; body = Integer { int = 2L } }
  ]);
  ForStm {
    init = Some (FIExpr (Assignment {
      lvl = Var (Ident { name = "a" });
      rhs = Integer { int = 0L }
    }));
    cond = Some (BinOp {
      left = Lval (Var (Ident { name = "a" }));
      op = Lt;
      right = Integer { int = 5L }
    });
    update = Some (Assignment {
      lvl = Var (Ident { name = "a" });
      rhs = BinOp {
        left = Lval (Var (Ident { name = "a" }));
        op = Plus;
        right = Integer { int = 1L }
      }
    });
    body = CompoundStm {
      stms = [
        WhileStm {
          cond = BinOp {
            left = Lval (Var (Ident { name = "b" }));
            op = Lt;
            right = Integer { int = 5L }
          };
          body = CompoundStm {
            stms = [
              IfThenElseStm {
                cond = BinOp {
                  left = Lval (Var (Ident { name = "b" }));
                  op = Eq;
                  right = Integer { int = 3L }
                };
                thbr = ContinueStm;
                elbro = None
              };
              ExprStm { expr = Some (Assignment {
                lvl = Var (Ident { name = "b" });
                rhs = BinOp {
                  left = Lval (Var (Ident { name = "b" }));
                  op = Plus;
                  right = Integer { int = 1L }
                }
              }) }
            ]
          }
        }
      ]
    }
  };
  ReturnStm { ret = Integer { int = 0L } }
]

(* Negative Test 1: Using break outside of loops *)
let failing_test_1 : Ast.program = [
  BreakStm;
  ReturnStm { ret = Integer { int = 0L } }
]

(* Negative Test 2: Using continue outside of loops *)
let failing_test_2 : Ast.program = [
  ContinueStm;
  ReturnStm { ret = Integer { int = 0L } }
]

(* Negative Test 3: Type mismatch in multiple variable declarations *)
let failing_test_3 : Ast.program = [
  VarDeclStm (DeclBlock [
    Declaration { name = Ident { name = "x" }; tp = Some Int; body = Integer { int = 10L } };
    Declaration { name = Ident { name = "y" }; tp = Some Int; body = Boolean { bool = true } }  (* Type mismatch *)
  ]);
  ReturnStm { ret = Integer { int = 0L } }
]

(* Negative Test 4: Using variable before declaration inside loop *)
let failing_test_4 : Ast.program = [
  ForStm {
    init = None;
    cond = Some (Boolean { bool = true });
    update = None;
    body = CompoundStm {
      stms = [
        ExprStm { expr = Some (Assignment {
          lvl = Var (Ident { name = "x" });
          rhs = Integer { int = 5L }
        }) };
        VarDeclStm (DeclBlock [
          Declaration { name = Ident { name = "x" }; tp = Some Int; body = Integer { int = 0L } }
        ])
      ]
    }
  };
  ReturnStm { ret = Integer { int = 0L } }
]

(* Negative Test 5: Calling an undeclared function *)
let failing_test_5 : Ast.program = [
  ExprStm { expr = Some (Call {
    fname = Ident { name = "undefined_function" };  (* Function is not declared *)
    args = []
  }) };
  ReturnStm { ret = Integer { int = 0L } }
]

(* Function to run a single test *)
let run_test_case (test_program : Ast.program) (test_name : string) =
  try
    (* Call the semantic checker function *)
    let typed_prog = typecheck_prog test_program in
    (* If no error occurs, proceed to code generation *)
    let llvm_module = codegen_prog typed_prog in
    let llvm_string = Ll.string_of_prog llvm_module in
    Printf.printf "Test '%s': PASSED\nLLVM IR:\n%s\n" test_name llvm_string
  with
  | TypeError error ->
      (* If a semantic error occurred, print the error *)
      Printf.printf "Test '%s': FAILED with TypeError: %s\n" test_name (Errors.error_to_string error)
  | e ->
      (* Catch any other exception *)
      Printf.printf "Test '%s': FAILED with unexpected error: %s\n" test_name (Printexc.to_string e)

(* Function to run all test cases *)
let run_all_tests () =
  Printf.printf "Running semantic analysis and code generation tests...\n";

  (* List of test cases *)
  let test_cases = [
    (test_program_1, "Positive Test 1 (Multiple variable declarations)");
    (test_program_2, "Positive Test 2 (For loop with break and continue)");
    (test_program_3, "Positive Test 3 (While loop with nested loops)");
    (test_program_4, "Positive Test 4 (Correct use of break and continue in nested loops)");
    (test_program_5, "Positive Test 5 (All features together)");
    (*(failing_test_1, "Negative Test 1 (Using break outside of loops)");*)
    (*(failing_test_2, "Negative Test 2 (Using continue outside of loops)");*)
    (*(failing_test_3, "Negative Test 3 (Type mismatch in multiple variable declarations)");*)
    (*(failing_test_4, "Negative Test 4 (Using variable before declaration inside loop)");*)
    (failing_test_5, "Negative Test 5 (Incorrect use of break in nested loops)");
  ] in

  List.iter (fun (prog, name) ->
    try
      run_test_case prog name
    with e ->
      Printf.printf "An unexpected error occurred while testing '%s': %s\n" name (Printexc.to_string e)
  ) test_cases;

  Printf.printf "All tests finished.\n"

(* Entry point *)
let () =
  (* Enable backtrace for debugging *)
  Printexc.record_backtrace true;

  (* Run all tests *)
  run_all_tests ()

# How to run
1. In terminal: dune build
2. In terminal: ./run_tests.sh

# Currently only the positive tests are active. To run the negative tests, please uncomment them on line 277-281 in test.ml. 
# Only 1 negative test can be active at a time as it stops when it encounters a semantic error. 
# Also no code for the positive tests will be generate with a negative test active, as it stops before reaching the codegen phase.
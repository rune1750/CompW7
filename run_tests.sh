#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Directory containing the test files
TEST_DIR="assignment-06-tests"

# Function to print error messages and exit
function error_exit {
    echo "$1" >&2
    exit 1
}

# Remove generated files to prevent conflicts
echo "Removing existing generated files..."
rm -f parser.ml parser.mli lexer.ml

# Generate lexer.ml using ocamllex
echo "Generating lexer.ml using ocamllex..."
ocamllex lexer.mll || error_exit "ocamllex failed."

# Generate parser.ml and parser.mli using menhir
echo "Generating parser.ml and parser.mli using menhir..."
menhir --infer parser.mly || error_exit "menhir failed."

# Build the project using dune
echo "Building the project with dune..."
dune build || error_exit "Dune build failed."

# Path to the compiler executable
COMPILER="./_build/default/driver.exe"

# Check if the compiler exists
if [ ! -f "$COMPILER" ]; then
    error_exit "Compiler executable not found after build."
fi

# Initialize counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

echo "Running tests in $TEST_DIR..."

# Iterate over all .dlp files in the test directory
for TEST_FILE in "$TEST_DIR"/*.dlp; do
    echo "---------------------------------------"
    echo "Found test file: $TEST_FILE"  
    let "TOTAL_TESTS+=1"
    echo "Test #$TOTAL_TESTS: $TEST_FILE"

    # Run the compiler on the test file
    echo "Running compiler: $COMPILER $TEST_FILE"
    "$COMPILER" "$TEST_FILE" || true  # Run compiler and don't exit on error

    # Check the exit code of the compiler
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
        echo "Test FAILED: Expected an error but compiler exited with code 0."
        let "FAILED_TESTS+=1"
    else
        echo "Test PASSED: Compiler reported an error as expected."
        let "PASSED_TESTS+=1"
    fi
    echo ""
done



echo "======================================="
echo "Test Summary:"
echo "Total Tests Run: $TOTAL_TESTS"
echo "Passed Tests:    $PASSED_TESTS"
echo "Failed Tests:    $FAILED_TESTS"
echo "======================================="

# Exit with the number of failed tests as the exit code
exit $FAILED_TESTS
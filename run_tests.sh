#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Directories containing the test files
TEST_DIR_FAILING="assignment-06-failing-tests"
TEST_DIR_PASSING="assignment-06-passing-tests"
TEST_DIR_ASSIGNMENT07_FAILING="assignment-07-failing-tests"
TEST_DIR_ASSIGNMENT07_PASSING="assignment-07-passing-tests"

# Function to print error messages and exit
function error_exit {
    echo "$1" >&2
    exit 1
}

# Remove generated files to prevent conflicts
echo "Removing existing generated files..."
rm -f parser.ml parser.mli lexer.ml test_output.txt

LOG_FILE="test_output.txt"
exec > >(tee >(sed 's/\x1b\[[0-9;]*m//g' > "$LOG_FILE")) 2>&1

echo "=== Building Lexer with ocamllex ==="
ocamllex lexer.mll || error_exit "ocamllex failed."
echo ""

echo "=== Building Parser with menhir ==="
menhir --infer parser.mly || error_exit "menhir failed."
echo ""

# Build the project using dune
echo "Building the project with dune..."
dune build || error_exit "Dune build failed."
echo ""

# Path to the compiler executable
COMPILER="_build/default/driver.exe"

# Check if the compiler exists
if [ ! -f "$COMPILER" ]; then
    error_exit "Compiler executable '$COMPILER' not found after build."
fi

# Function to run tests
function run_tests {
    local TEST_DIR="$1"
    local EXPECT_FAIL="$2"
    local TOTAL_TESTS=0
    local PASSED_TESTS=0
    local FAILED_TESTS=0

    echo "Running tests in $TEST_DIR..."

    # Check if the test directory exists
    if [ ! -d "$TEST_DIR" ]; then
        echo "Warning: Test directory '$TEST_DIR' does not exist. Skipping..."
        return 0
    fi

    # Iterate over all .dlp files in the test directory
    shopt -s nullglob  # Allows the loop to handle no matching files gracefully
    for TEST_FILE in "$TEST_DIR"/*.dlp; do
        echo "---------------------------------------"
        echo "Found test file: $TEST_FILE"
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        echo "Test #$TOTAL_TESTS: $TEST_FILE"

        # Temporarily disable 'set -e' to handle expected failures
        set +e
        # Run the compiler on the test file
        echo "Running compiler: $COMPILER $TEST_FILE"
        "$COMPILER" "$TEST_FILE"
        EXIT_CODE=$?
        # Re-enable 'set -e'
        set -e

        if [ "$EXPECT_FAIL" = true ]; then
            if [ $EXIT_CODE -ne 0 ]; then
                echo "Test PASSED: Compiler reported an error as expected."
                PASSED_TESTS=$((PASSED_TESTS + 1))
            else
                echo "Test FAILED: Compiler did not report an error as expected."
                FAILED_TESTS=$((FAILED_TESTS + 1))
            fi
        else
            if [ $EXIT_CODE -eq 0 ]; then
                echo "Test PASSED: Compiler succeeded as expected."
                PASSED_TESTS=$((PASSED_TESTS + 1))
            else
                echo "Test FAILED: Compiler reported an error unexpectedly."
                FAILED_TESTS=$((FAILED_TESTS + 1))
            fi
        fi
        echo ""
    done
    shopt -u nullglob  # Reset nullglob to default

    echo "======================================="
    echo "Test Summary for $TEST_DIR:"
    echo "Total Tests Run: $TOTAL_TESTS"
    echo "Passed Tests:    $PASSED_TESTS"
    echo "Failed Tests:    $FAILED_TESTS"
    echo "======================================="

    # Store the number of failed tests in a global variable
    TEST_RESULTS[$TEST_DIR]=$FAILED_TESTS
}

# Initialize an associative array to store test results
declare -A TEST_RESULTS

# Disable 'set -e' when running the tests to prevent the script from exiting
set +e

# Run tests that are expected to fail
run_tests "$TEST_DIR_FAILING" true

# Run tests that are expected to pass
run_tests "$TEST_DIR_PASSING" false

# Run failing tests in assignment-07
run_tests "$TEST_DIR_ASSIGNMENT07_FAILING" true

# Run passing tests in assignment-07
run_tests "$TEST_DIR_ASSIGNMENT07_PASSING" false

# Re-enable 'set -e'
set -e

# Calculate the total number of failed tests
TOTAL_FAILED_TESTS=0
for FAILED in "${TEST_RESULTS[@]}"; do
    TOTAL_FAILED_TESTS=$((TOTAL_FAILED_TESTS + FAILED))
done

echo "======================================="
echo "Overall Test Summary:"
echo "Total Failed Tests: $TOTAL_FAILED_TESTS"
echo "======================================="

# Exit with the total number of failed tests as the exit code
exit $TOTAL_FAILED_TESTS
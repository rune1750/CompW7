#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Directories containing the test files
TEST_DIR_FAILING="assignment-06-failing-tests"
TEST_DIR_PASSING="assignment-06-passing-tests"
TEST_DIR_ASSIGNMENT07="assignment-07-tests"

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

# Build the project using dune
echo "Building the project with dune..."
dune build || error_exit "Dune build failed."

# Path to the compiler executable
COMPILER="_build/default/driver.exe"

# Check if the compiler exists
if [ ! -f "$COMPILER" ]; then
    error_exit "Compiler executable not found after build."
fi

# Function to run tests
function run_tests {
    local TEST_DIR="$1"
    local EXPECT_FAIL="$2"
    local TOTAL_TESTS=0
    local PASSED_TESTS=0
    local FAILED_TESTS=0

    echo "Running tests in $TEST_DIR..."

    # Iterate over all .dlp files in the test directory
    for TEST_FILE in "$TEST_DIR"/*.dlp; do
        echo "---------------------------------------"
        echo "Found test file: $TEST_FILE"
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        echo "Test #$TOTAL_TESTS: $TEST_FILE"

        # Run the compiler on the test file
        echo "Running compiler: $COMPILER $TEST_FILE"
        "$COMPILER" "$TEST_FILE" > /dev/null 2>&1
        EXIT_CODE=$?

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

    echo "======================================="
    echo "Test Summary for $TEST_DIR:"
    echo "Total Tests Run: $TOTAL_TESTS"
    echo "Passed Tests:    $PASSED_TESTS"
    echo "Failed Tests:    $FAILED_TESTS"
    echo "======================================="

    # Return the number of failed tests
    return $FAILED_TESTS
}

# Run tests that are expected to fail
run_tests "$TEST_DIR_FAILING" true
FAILED_TESTS_FAILING=$?

# Run tests that are expected to pass
run_tests "$TEST_DIR_PASSING" false
FAILED_TESTS_PASSING=$?

# Run tests in assignment-07-tests
# Assuming that tests in assignment-07-tests are expected to pass
run_tests "$TEST_DIR_ASSIGNMENT07" false
FAILED_TESTS_ASSIGNMENT07=$?

# Total failed tests
TOTAL_FAILED_TESTS=$((FAILED_TESTS_FAILING + FAILED_TESTS_PASSING + FAILED_TESTS_ASSIGNMENT07))

echo "======================================="
echo "Overall Test Summary:"
echo "Total Failed Tests: $TOTAL_FAILED_TESTS"
echo "======================================="

# Exit with the total number of failed tests as the exit code
exit $TOTAL_FAILED_TESTS
#!/bin/bash

# Directory containing the test files
TEST_DIR="assignment-06-tests"

# Path to the compiler executable
COMPILER="./_build/default/driver.exe"

# Check if the compiler exists
if [ ! -f "$COMPILER" ]; then
    echo "Compiler executable not found. Please build the project using 'dune build'."
    exit 1
fi

# Initialize counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

echo "Running tests in $TEST_DIR..."

# Iterate over all .dlp files in the test directory
for TEST_FILE in "$TEST_DIR"/*.dlp; do
    ((TOTAL_TESTS++))
    echo "---------------------------------------"
    echo "Test #$TOTAL_TESTS: $TEST_FILE"

    # Run the compiler on the test file
    "$COMPILER" "$TEST_FILE"
    EXIT_CODE=$?

    if [ $EXIT_CODE -eq 0 ]; then
        echo "Test FAILED: Expected an error but compiler exited with code 0."
        ((FAILED_TESTS++))
    else
        echo "Test PASSED: Compiler reported an error as expected."
        ((PASSED_TESTS++))
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
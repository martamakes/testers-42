#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print test results
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
    fi
}

echo -e "${YELLOW}=== PIPEX PROJECT TEST SUITE ===${NC}"

# Test compilation
echo -e "\n${YELLOW}Testing compilation...${NC}"
make fclean > /dev/null 2>&1
if make; then
    print_result 0 "Basic compilation successful"
else
    print_result 1 "Basic compilation failed"
    exit 1
fi

if make bonus; then
    print_result 0 "Bonus compilation successful"
else
    print_result 1 "Bonus compilation failed"
    exit 1
fi

# Create test files
echo -e "\n${YELLOW}Setting up test files...${NC}"
echo "Hello World" > test_input.txt
echo "This is a test file" >> test_input.txt
echo "With multiple lines" >> test_input.txt
echo "And some special characters: !@#$%^&*()" >> test_input.txt
echo "And some numbers: 1234567890" >> test_input.txt

# Test basic functionality
echo -e "\n${YELLOW}Testing basic functionality...${NC}"

# Test 1: Basic cat and wc
./pipex test_input.txt "cat" "wc -l" test_output.txt
result=$(cat test_output.txt)
print_result $? "Basic cat and wc test (Lines: $result)"

# Test 2: grep and wc
./pipex test_input.txt "grep 'test'" "wc -l" test_output.txt
result=$(cat test_output.txt)
print_result $? "Grep and wc test (Lines: $result)"

# Test 3: tr and sort
./pipex test_input.txt "tr 'a-z' 'A-Z'" "sort" test_output.txt
print_result $? "tr and sort test"

# Test 4: sed and wc
./pipex test_input.txt "sed 's/test/TEST/g'" "wc -w" test_output.txt
result=$(cat test_output.txt)
print_result $? "sed and wc test (Words: $result)"

# Test error cases
echo -e "\n${YELLOW}Testing error cases...${NC}"

# Test 5: Non-existent input file
./pipex nonexistent.txt "cat" "wc -l" test_output.txt 2>/dev/null
print_result $? "Non-existent input file test (should fail)"

# Test 6: Invalid command
./pipex test_input.txt "invalidcmd" "wc -l" test_output.txt 2>/dev/null
print_result $? "Invalid command test (should fail)"

# Test 7: Invalid number of arguments
./pipex test_input.txt "cat" 2>/dev/null
print_result $? "Invalid number of arguments test (should fail)"

# Test bonus functionality
echo -e "\n${YELLOW}Testing bonus functionality...${NC}"

# Test 8: Heredoc basic
echo -e "line1\nline2\nEOF" | ./pipex_bonus here_doc EOF "cat" "wc -l" heredoc_output.txt
result=$(cat heredoc_output.txt)
print_result $? "Basic heredoc test (Lines: $result)"

# Test 9: Heredoc with grep
echo -e "test1\ntest2\nEOF" | ./pipex_bonus here_doc EOF "grep 'test'" "wc -l" heredoc_output.txt
result=$(cat heredoc_output.txt)
print_result $? "Heredoc with grep test (Lines: $result)"

# Test 10: Multiple pipes
./pipex_bonus test_input.txt "cat" "tr ' ' '\n'" "sort" "uniq" "wc -l" multi_output.txt
result=$(cat multi_output.txt)
print_result $? "Multiple pipes test (Unique lines: $result)"

# Test 11: Multiple pipes with grep
./pipex_bonus test_input.txt "cat" "grep 'test'" "tr ' ' '\n'" "sort" "wc -l" multi_output.txt
result=$(cat multi_output.txt)
print_result $? "Multiple pipes with grep test (Lines: $result)"

# Test 12: Heredoc with multiple pipes
echo -e "test1\ntest2\ntest3\nEOF" | ./pipex_bonus here_doc EOF "cat" "grep 'test'" "tr ' ' '\n'" "sort" "wc -l" heredoc_output.txt
result=$(cat heredoc_output.txt)
print_result $? "Heredoc with multiple pipes test (Lines: $result)"

# Test 13: Large file handling
echo -e "\n${YELLOW}Testing large file handling...${NC}"
for i in {1..1000}; do
    echo "Line $i" >> large_input.txt
done
./pipex large_input.txt "cat" "wc -l" large_output.txt
result=$(cat large_output.txt)
print_result $? "Large file test (Lines: $result)"

# Test 14: Special characters
echo -e "\n${YELLOW}Testing special characters...${NC}"
echo -e "!@#$%^&*()\n[]{}|\\\n<>?/.,;:'\"" > special_input.txt
./pipex special_input.txt "cat" "wc -l" special_output.txt
result=$(cat special_output.txt)
print_result $? "Special characters test (Lines: $result)"

# Cleanup
echo -e "\n${YELLOW}Cleaning up test files...${NC}"
rm -f test_input.txt test_output.txt heredoc_output.txt multi_output.txt large_input.txt large_output.txt special_input.txt special_output.txt

echo -e "\n${GREEN}=== ALL TESTS COMPLETED ===${NC}"
# **************************************************************************** #
#                    MVIGARA EVALUATION - SPECIFIC EVALUATION TESTS            #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### SPECIFIC TESTS FROM EVALUATION SHEET ###

# Test expr with $? (exact from evaluation)
/bin/ls archivo_que_no_existe
expr $? + $?

# Test specific weird command from evaluation
wjkgjrgwg4g43go34o

# Test "cat | cat | ls" behavior (should be "normal")
echo | cat | cat | ls

# Test long command with many arguments
echo this is a very long command with many many many arguments to test the limits of argument parsing and handling in minishell

# Test command that should not work but not crash minishell
commandnotfound

/bin/nonexistent

# Test empty command behavior
    
# Test only tabs/spaces

# Test $USER creation and testing
unset USER
echo $USER
export USER=testvalue
echo $USER

# Test multiple redirections failure exactly as in evaluation
echo "test" > file1 > file2

cat < file1 < file2

# Test return value checking
true
echo $?
false  
echo $?

# Test PATH behavior exactly as evaluation
export ORIGINAL_PATH=$PATH
unset PATH
ls
export PATH=$ORIGINAL_PATH
ls

# Test with absolute paths when no PATH
unset PATH
/bin/ls

# Restore PATH
export PATH=$ORIGINAL_PATH

# Cleanup
rm -f file1 file2
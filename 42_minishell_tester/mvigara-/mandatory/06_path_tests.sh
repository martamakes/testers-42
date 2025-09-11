# **************************************************************************** #
#                       MVIGARA EVALUATION - PATH TESTING                     #
#                              Based on 42 evaluation sheet                   #
# **************************************************************************** #

### PATH VARIABLE TESTING ###

# Save original PATH
export SAVED_PATH=$PATH

# Test commands without PATH  
ls

# Unset PATH and verify commands fail
unset PATH

# Commands should fail now (using external commands only)
ls
cat
grep --version

# Restore PATH and verify they work
export PATH=$SAVED_PATH

# Commands should work again
ls
cat
grep --version

# Test PATH directory precedence (left to right)  
export PATH="/usr/bin:/bin"
ls

# Test specific failing command from evaluation
/bin/ls archivo_que_no_existe

# Test weird command name from evaluation
wjkgjrgwg4g43go34o

# Test expr with $?
false
expr $? + $?

# Test multiple PATH directories
export PATH="/usr/local/bin:/usr/bin:/bin"
ls -la
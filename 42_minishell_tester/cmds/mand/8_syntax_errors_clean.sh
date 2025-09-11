# **************************************************************************** #
#                            SYNTAX ERRORS - CLEAN                            #
#         (Removed beyond scope functionality per minishell subject)           #
# **************************************************************************** #

# REMOVED: > (beyond scope - redirection without command)
# REMOVED: < (beyond scope - redirection without command)  
# REMOVED: << (beyond scope - redirection without command)
# REMOVED: > > > > > (beyond scope - multiple redirections without command)
# REMOVED: >> >> >> >> (beyond scope - multiple redirections without command)
# REMOVED: >>>>>>>>> (beyond scope - invalid syntax not in subject)
# REMOVED: <<<<<<<<< (beyond scope - invalid syntax not in subject)
# REMOVED: ~ (beyond scope - tilde not in subject for standalone use)
# REMOVED: < < < < < < (beyond scope - multiple redirections without command)

/bin/cat ><

/bin/cat <Makefile >

cat 42 42

echo >

echo > <

.

..

echo | |

EechoE

.echo.

# REMOVED: >echo> (beyond scope - complex redirection syntax)
# /bin/rm -f echo

# REMOVED: <echo< (beyond scope - complex redirection syntax)
# /bin/rm -f echo

# REMOVED: >>echo>> (beyond scope - complex redirection syntax)
# /bin/rm -f echo

|echo|

trying to destroy your minishell

|

| test

| | |

| | | | test

| test

echo > <

hello world
||||||||
            
cat wouaf wouaf
>

> > > >

>> >> >> >>

<<

/

# REMOVED: \\\ (beyond scope - backslashes not in mandatory)

rm -f something

| echo -n oui

trying to destroy your minishell
trying something again echo if you see this message thats not a good new
qewew
wtf
hi im zsolt
nice to meet you if these tests are green
your minishell is perfect

<<| echo wtf

>>| echo wtf

# REMOVED: >| echo wtf (beyond scope - >| not in subject)
# /bin/rm -rf echo

<| echo wtf

echo "<<| echo wtf"

echo ">>| echo wtf"

echo ">| echo wtf"

echo "<| echo wtf"

<>

< >
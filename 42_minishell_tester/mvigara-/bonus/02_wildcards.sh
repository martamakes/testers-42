# **************************************************************************** #
#                          MVIGARA EVALUATION - WILDCARDS                      #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### WILDCARDS ###

# Crear archivos de test para wildcards
touch test1.txt test2.txt test3.c program.c readme.md

# Wildcards en argumentos para el directorio actual
echo *

echo *.txt

echo *.c

ls *

ls *.txt

# Wildcards con comandos
cat *.txt

wc *.c

# Wildcards que no coinciden con nada
echo *.nonexistent

ls *.xyz

# Wildcards en diferentes posiciones
echo test*

echo *test*

echo *.t*

# Wildcards con otros argumentos
ls *.txt

echo "Files:" *.c

# Wildcards con pipes
ls *.txt | wc -l

echo *.c | tr ' ' '\n'

# Wildcards mixtos
echo *.txt *.c

ls *.txt *.md

# Cleanup
rm -f test1.txt test2.txt test3.c program.c readme.md
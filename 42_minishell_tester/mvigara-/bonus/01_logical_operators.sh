# **************************************************************************** #
#                       MVIGARA EVALUATION - LOGICAL OPERATORS                 #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### AND, OR ###

# Operadores && y ||
echo "first" && echo "second"

echo "first" || echo "second"

true && echo "success"

false && echo "should not print"

false || echo "alternative"

true || echo "should not print"

# Combinación de && y ||
true && echo "first" || echo "second"

false && echo "should not print" || echo "fallback"

# Con comandos reales
ls && echo "ls succeeded"

ls nonexistent && echo "should not print"

ls nonexistent || echo "ls failed"

### PARÉNTESIS ###

# Paréntesis para prioridades
(echo "first" && echo "second") || echo "fallback"

(false || true) && echo "parentheses work"

(echo "test" | grep "test") && echo "found"

# Paréntesis anidados
((echo "nested" && true) || false) && echo "complex"

# Paréntesis con comandos complejos
(ls -la && echo "listed") || (echo "list failed" && false)

### COMBINACIONES COMPLEJAS ###

# Como en bash - verificar que funciona igual
true && false || echo "should print"

false || true && echo "should print"

(true && false) || echo "with parentheses"

# Con pipes y redirecciones
(echo "test" | grep "test") && echo "found it"

(ls > /tmp/ls_output.txt) && cat /tmp/ls_output.txt

# **************************************************************************** #
#                                    GROUPS                                    #
# **************************************************************************** #

((echo 1) | (echo 2) | (echo 3 | (echo 4)))

echo 1 | (echo 2 || echo 3 && echo 4) || echo 5 | echo 6

echo 1 | (grep 1) | cat | (wc -l)

(/bin/echo 1 | /bin/echo 2 && ((/bin/echo 3 | /bin/echo 3) | (/bin/echo 4 | /bin/echo 4)))

(exit 4)

(sleep 0 && (exit 4))

(echo 1 | echo 2) | (exit 2)

# Cleanup
rm -f /tmp/ls_output.txt
# **************************************************************************** #
#                        MVIGARA EVALUATION - REDIRECTIONS                     #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### REDIRECCIONES < y > ###

# Crear archivos de test
echo "hello world" > test_input.txt
echo "line 1" > test_file.txt
echo "line 2" >> test_file.txt

# Redirección de entrada <
cat < test_input.txt

grep "hello" < test_input.txt

# Redirección de salida >
ls > output1.txt

echo "redirected output" > output2.txt

# Verificar contenido
cat output1.txt
cat output2.txt

# Cambiar > por >>
echo "first line" > append_test.txt
echo "second line" >> append_test.txt
echo "third line" >> append_test.txt

cat append_test.txt

# Varias redirecciones del mismo tipo (debería fallar)
echo "test" > file1.txt > file2.txt

ls < test_input.txt < test_file.txt

### REDIRECCIÓN << (HEREDOC) ###

# Heredoc básico
cat << EOF
This is a heredoc
Multiple lines
EOF

# Heredoc con comando
grep "line" << END
line 1
not a line
line 2
END

# Heredoc sin actualizar historial (según subject)
wc -l << STOP
line one
line two  
line three
STOP

### MEZCLA DE REDIRECCIONES ###

# Redirección de entrada y salida
cat < test_input.txt > mixed_output.txt

# Heredoc con redirección de salida
cat << EOF > heredoc_output.txt
This goes to file
Not to stdout
EOF

cat heredoc_output.txt

# Cleanup
rm -f test_input.txt test_file.txt output1.txt output2.txt append_test.txt file1.txt file2.txt mixed_output.txt heredoc_output.txt
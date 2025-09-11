# **************************************************************************** #
#                          MVIGARA EVALUATION - PIPES                          #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### PIPES ###

# Crear archivo de test
echo -e "apple\nbanana\ncherry\napple\ndate" > fruits.txt

# Pipes básicos
cat fruits.txt | grep apple

ls -la | grep txt

echo "hello world" | wc -w

# Pipes múltiples como en el ejemplo del evaluation
cat fruits.txt | grep apple | wc -l

ls -la | grep -v "^d" | wc -l

# Comandos que fallan en pipes
ls archivoquenoexiste | grep bla | more

cat nonexistent.txt | wc -l | sort

# Mezclar pipes y redirecciones
cat fruits.txt | grep apple > apple_results.txt

echo "test data" | cat > pipe_output.txt

# Pipes con redirección de entrada
cat < fruits.txt | grep banana

# Comando complejo como en evaluation
cat fruits.txt | grep -v date | sort | uniq

### CASOS ESPECIALES ###

# "cat | cat | ls" se comporta de forma "normal" según evaluation
cat | cat | ls

# Comando largo con muchísimos argumentos (según evaluation)
echo this is a very long command with many many many arguments to test the limits of argument parsing and handling in minishell

### VOLVERSE LOCO Y EL HISTORIAL ###

# Comandos que no deberían funcionar pero no deben terminar minishell
wjkgjrgwg4g43go34o

commandnotfound

/bin/nonexistent

# Cleanup  
rm -f fruits.txt apple_results.txt pipe_output.txt
# **************************************************************************** #
#                       MVIGARA EVALUATION - SURPRISE QUOTES                   #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### ¡SORPRESA! (O no...) ###

# Establecer la variable de entorno USER
export USER=testuser

# Prueba echo "'$USER'", esto deberá imprimir 'testuser'
echo "'$USER'"

# Prueba echo '"$USER"', deberá imprimir "$USER"  
echo '"$USER"'

# Casos adicionales de comillas mixtas
export TESTVAR=hello

echo "'$TESTVAR'"

echo '"$TESTVAR"'

# Comillas anidadas complejas
echo "He said: 'Hello $USER'"

echo 'She said: "Hello $USER"'

# Casos edge con comillas múltiples
echo "'"$USER"'"

echo '"'"$USER"'"'

echo "'\"$USER\"'"

# Variables en diferentes contextos de comillas
echo '$USER'

echo "$USER"

echo "'$USER'"

echo '"$USER"'

echo "\"$USER\""

echo '$USER said "hello"'

echo "$USER said 'hello'"
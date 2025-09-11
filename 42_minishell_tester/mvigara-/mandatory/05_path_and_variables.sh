# **************************************************************************** #
#                     MVIGARA EVALUATION - PATH AND VARIABLES                  #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### VARIABLE DE ENTORNO PATH ###

# Ejecutar comandos sin rutas (usando PATH)
ls

wc

awk --version

# Eliminar PATH y verificar que ya no funcionen
unset PATH

ls

wc

# Restablecer PATH para varios directorios y verificar orden
export PATH="/usr/bin:/bin:/usr/local/bin"

ls

# Verificar que se buscan de izquierda a derecha
export PATH="/nonexistent:/usr/bin:/bin"

ls

### VARIABLES DE ENTORNO ###

# echo con variables $
echo $USER

echo $HOME

echo $PATH

# Verificar que $ se interpreta como variable de entorno
export MYTEST=hello
echo $MYTEST

# Verificar que las comillas dobles interpolan $
echo "$USER"

echo "$HOME is my home"

# Verificar que $USER existe o crearlo
export USER=testuser
echo $USER

# echo "$USER" deberá imprimir el valor de $USER
echo "$USER"

# Test mixed quotes and variables
echo '$USER'

echo "$USER"

echo '$USER says "$HOME"'

# Variables inexistentes
echo $NONEXISTENT

echo "$NONEXISTENT"
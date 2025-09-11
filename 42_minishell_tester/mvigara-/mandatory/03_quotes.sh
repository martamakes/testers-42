# **************************************************************************** #
#                         MVIGARA EVALUATION - QUOTES                          #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### COMILLAS DOBLES ###

# Comando simple con argumentos y espacios en comillas dobles
echo "hello world"

echo "cat lol.c | cat > lol.c"

echo "hello    world   with   spaces"

# Cualquier cosa salvo $ debe ser literal en comillas dobles
echo "hello | grep world > file"

echo "hello && echo world"

### COMILLAS SIMPLES ###

# Comandos con comillas simples como argumento
echo 'hello world'

# Argumentos vacíos con comillas simples
echo ''

# Variables de entorno en comillas simples (no deben expandirse)
echo '$USER'

echo '$HOME'

echo '$PATH'

# Espacios en blanco en comillas simples
echo 'hello    world   with   spaces'

# Pipes y redirecciones en comillas simples (deben ser literales)
echo 'cat file | grep hello > output'

echo 'ls -la && echo done || echo failed'

# Nada debe interpretarse en comillas simples
echo '$USER | grep hello > file && echo done'
# **************************************************************************** #
#                         MVIGARA EVALUATION - BASIC COMMANDS                  #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### COMANDOS SIMPLES Y VARIABLE GLOBAL ###

# Comando sencillo con ruta absoluta sin argumentos
/bin/ls

# Comando vacío (solo enter)


# Solo tabuladores y espacios
	   	  

### ARGUMENTOS ###

# Comando simple con ruta absoluta y argumentos
/bin/ls

/bin/echo hello world

/bin/cat /etc/passwd

### ECHO ###

# echo sin argumentos
echo

# echo con argumentos
echo hello

echo hello world

# echo con -n
echo -n hello

echo -n hello world

echo -n

### EXIT ###

# exit sin argumentos
exit

# exit con argumento numérico
exit 42

# exit con argumento no numérico
exit hello

# exit con múltiples argumentos
exit 42 hello

### VALOR DE RETORNO ###

# Comando exitoso seguido de echo $?
/bin/ls
echo $?

# Comando que falla seguido de echo $?
/bin/ls archivo_que_no_existe
echo $?

# Expresión con $?
/bin/ls
expr $? + $?
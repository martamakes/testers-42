# **************************************************************************** #
#                         MVIGARA EVALUATION - BUILTINS                        #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### ENV ###

# Mostrar variables de entorno actuales
env

### EXPORT ###

# Exportar nueva variable
export MYVAR=hello

# Verificar con env
env

# Exportar variable con espacios (entre comillas)
export MYVAR2="hello world"

# Reemplazar variable existente  
export MYVAR=goodbye

env

### UNSET ###

# Crear variables para eliminar
export VAR1=value1
export VAR2=value2
export VAR3=value3

env

# Eliminar algunas variables
unset VAR1

unset VAR2

# Verificar resultado
env

# Intentar eliminar variable que no existe
unset NONEXISTENT

### CD ###

# Cambiar a directorio y verificar con pwd
cd /tmp
pwd

# Cambiar a directorio home
cd
pwd

# Cambiar con punto (directorio actual)
cd .
pwd

# Cambiar con doble punto (directorio padre)
cd ..
pwd

# Cambiar a directorio que no existe
cd /nonexistent/directory

# Cambiar de vuelta
cd

### PWD ###

# Comando pwd básico
pwd

# pwd en diferentes directorios
cd /tmp
pwd

cd /usr
pwd

cd
pwd

### RUTAS RELATIVAS ###

# Ejecutar comandos con rutas relativas desde diferentes directorios
cd /tmp
ls .

cd /usr/bin
ls ../lib

cd
ls ./Desktop
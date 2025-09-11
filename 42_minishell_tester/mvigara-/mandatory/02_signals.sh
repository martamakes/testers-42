# **************************************************************************** #
#                         MVIGARA EVALUATION - SIGNALS                         #
#                              Based on 42 evaluation sheet                    #
# **************************************************************************** #

### SEÑALES ###
# Nota: Estos comandos requieren interacción manual durante la evaluación

# Test ctrl-C en entrada limpia - debe mostrar nueva línea
# MANUAL: Presionar ctrl-C y verificar nueva línea con prompt limpio

# Test ctrl-\ en entrada limpia - no debe hacer nada  
# MANUAL: Presionar ctrl-\ y verificar que no pasa nada

# Test ctrl-D en entrada limpia - debe terminar minishell
# MANUAL: Presionar ctrl-D y verificar que termina

# Test ctrl-C con texto - debe limpiar buffer y mostrar nueva línea
# MANUAL: Escribir texto, presionar ctrl-C, luego enter para verificar que no se ejecuta

# Test ctrl-D con texto - no debe hacer nada
# MANUAL: Escribir texto, presionar ctrl-D, verificar que no pasa nada

# Test ctrl-\ con texto - no debe hacer nada
# MANUAL: Escribir texto, presionar ctrl-\, verificar que no pasa nada

# Test ctrl-C después de comando bloqueante
cat
# MANUAL: Ejecutar 'cat' sin argumentos, luego presionar ctrl-C

grep "algo"
# MANUAL: Ejecutar 'grep "algo"' sin archivo, luego presionar ctrl-C

# Test ctrl-\ después de comando bloqueante
cat
# MANUAL: Ejecutar 'cat' sin argumentos, luego presionar ctrl-\

# Test ctrl-D después de comando bloqueante
cat
# MANUAL: Ejecutar 'cat' sin argumentos, luego presionar ctrl-D
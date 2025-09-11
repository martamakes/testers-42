# MANUAL TESTING CHECKLIST - MINISHELL EVALUATION

## 🔴 TESTING MANUAL CRÍTICO OBLIGATORIO

Este documento contiene todos los tests que **NO SE PUEDEN AUTOMATIZAR** y deben realizarse manualmente durante la evaluación de 42.

---

## 1. SEÑALES INTERACTIVAS (CRÍTICO)

### **ctrl-C Testing**
```bash
./minishell
# Test 1: Entrada limpia
[prompt]> <PRESS CTRL-C>
# ✅ Debe mostrar nueva línea con prompt limpio

# Test 2: Con texto escrito
[prompt]> echo "test text here"<PRESS CTRL-C>
# ✅ Debe mostrar nueva línea con prompt limpio
# ✅ Presionar ENTER -> no debe ejecutar nada

# Test 3: Durante comando bloqueante
[prompt]> cat
<PRESS CTRL-C>
# ✅ Debe interrumpir cat y mostrar nuevo prompt
```

### **ctrl-D Testing**
```bash
./minishell
# Test 1: Entrada limpia
[prompt]> <PRESS CTRL-D>
# ✅ Debe terminar minishell limpiamente

./minishell
# Test 2: Con texto escrito
[prompt]> echo "some text"<PRESS CTRL-D>
# ✅ NO debe hacer nada

# Test 3: Durante comando bloqueante
[prompt]> cat
<PRESS CTRL-D>
# ✅ Debe terminar cat (EOF)
```

### **ctrl-\\ Testing**
```bash
./minishell
# Test 1: Entrada limpia
[prompt]> <PRESS CTRL-\>
# ✅ NO debe hacer nada

# Test 2: Con texto escrito  
[prompt]> echo "text"<PRESS CTRL-\>
# ✅ NO debe hacer nada

# Test 3: Durante comando bloqueante
[prompt]> grep "test"
<PRESS CTRL-\>
# ✅ Debe terminar grep con mensaje bash-compatible
```

---

## 2. HISTORIAL Y NAVEGACIÓN (CRÍTICO)

### **Arrow Keys Testing**
```bash
./minishell
[prompt]> echo "command 1"
[prompt]> ls -la
[prompt]> pwd
[prompt]> <PRESS UP ARROW>
# ✅ Debe mostrar: pwd

[prompt]> <PRESS UP ARROW>
# ✅ Debe mostrar: ls -la

[prompt]> <PRESS UP ARROW>  
# ✅ Debe mostrar: echo "command 1"

[prompt]> <PRESS DOWN ARROW>
# ✅ Debe mostrar: ls -la

[prompt]> <PRESS ENTER>
# ✅ Debe ejecutar: ls -la
```

### **Buffer Clearing Test**
```bash
./minishell
[prompt]> echo "this should not execute"<PRESS CTRL-C>
[prompt]> <PRESS ENTER>
# ✅ Buffer debe estar vacío, no debe ejecutar nada
```

---

## 3. MEMORY LEAKS (OBLIGATORIO)

### **Valgrind Session Testing**
```bash
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./minishell

# Ejecutar secuencia completa:
[prompt]> echo "test"
[prompt]> ls -la
[prompt]> cat /etc/passwd | grep root
[prompt]> export TEST=value
[prompt]> echo $TEST
[prompt]> cd /tmp
[prompt]> pwd
[prompt]> cd -
[prompt]> echo "heredoc test" << EOF
heredoc content
EOF
[prompt]> false
[prompt]> echo $?
[prompt]> exit

# ✅ Al salir: "All heap blocks were freed -- no leaks are possible"
# ✅ O solo leaks de readline (permitidos)
```

### **Extended Memory Testing**
```bash
valgrind --leak-check=full ./minishell

# Test pipes complejos
[prompt]> cat /etc/passwd | grep root | wc -l
[prompt]> ls -la | head -5 | tail -2

# Test redirecciones múltiples
[prompt]> echo "test" > file1
[prompt]> cat < file1 > file2
[prompt]> cat file2

# Test comandos largos
[prompt]> echo very long command with many arguments to test memory allocation and deallocation properly

# Test variables
[prompt]> export LONGVAR="very long value to test variable allocation"
[prompt]> echo $LONGVAR
[prompt]> unset LONGVAR

[prompt]> exit
# ✅ Sin leaks (excepto readline)
```

---

## 4. EDGE CASES INTERACTIVOS

### **Crash Resistance Testing**
```bash
./minishell

# Test comandos inexistentes
[prompt]> wjkgjrgwg4g43go34o
# ✅ Debe mostrar error, NO crashear

[prompt]> /bin/nonexistent
# ✅ Debe mostrar error, NO crashear

[prompt]> commandnotfound
# ✅ Debe mostrar error, NO crashear

# Minishell debe seguir funcionando
[prompt]> echo "still working"
# ✅ Debe funcionar normalmente
```

### **Signal During Execution**
```bash
./minishell
[prompt]> sleep 5
# Inmediatamente presionar CTRL-C
<PRESS CTRL-C>
# ✅ Debe interrumpir sleep y mostrar nuevo prompt

[prompt]> grep "test"
# Escribir algo y presionar CTRL-C
test input<PRESS CTRL-C>
# ✅ Debe interrumpir grep y mostrar nuevo prompt
```

---

## 5. CASOS ESPECÍFICOS DEL EVALUATION

### **Empty/Space Commands**
```bash
./minishell
[prompt]> 
# Presionar solo ENTER
# ✅ Debe mostrar nuevo prompt

[prompt]>     
# Solo espacios y ENTER  
# ✅ Debe mostrar nuevo prompt

[prompt]>    	  
# Solo tabs y ENTER
# ✅ Debe mostrar nuevo prompt
```

### **Complex Quote Scenarios**
```bash
./minishell
[prompt]> echo "test'quote'test"
# ✅ Debe imprimir: test'quote'test

[prompt]> echo 'test"quote"test'  
# ✅ Debe imprimir: test"quote"test

# Test manual de expansion
[prompt]> export USER=testuser
[prompt]> echo "'$USER'"
# ✅ Debe imprimir: 'testuser'

[prompt]> echo '"$USER"'
# ✅ Debe imprimir: "$USER"
```

---

## ✅ CHECKLIST DE VALIDACIÓN

### **Antes de la evaluación:**
- [ ] Compilación sin warnings (`make`)
- [ ] Tests automáticos pasan (`./tester.sh mm`)
- [ ] Tests con valgrind pasan (`./tester.sh mmv`)

### **Durante evaluación manual:**
- [ ] Todas las señales funcionan correctamente
- [ ] Historial navegable con flechas
- [ ] Buffer se limpia con ctrl-C
- [ ] No hay crashes con comandos inexistentes  
- [ ] Valgrind session completa sin leaks
- [ ] Variables de entorno funcionan correctamente
- [ ] Casos edge de comillas funcionan

### **Critical Success Criteria:**
- [ ] **ZERO CRASHES** durante toda la evaluación
- [ ] **ZERO LEAKS** (excepto readline permitidos)
- [ ] **Señales idénticas a bash**
- [ ] **Historial funcional**

---

## 🚨 RED FLAGS (FALLO AUTOMÁTICO)

- **Segfault en cualquier momento** → Nota: 0
- **Memory leaks detectados** → Usar flag apropiado  
- **Comportamiento de señales diferente a bash** → Fallo crítico
- **Minishell termina inesperadamente** → Crash flag

---

## 📝 NOTAS PARA EL EVALUADOR

1. **Comparar siempre con bash** - Cualquier duda, probar el mismo comando en bash
2. **Testing exhaustivo de señales** - Es el punto más crítico
3. **Valgrind obligatorio** - Memoria perfecta requerida
4. **No editar archivos** - Solo testing, no modificaciones
5. **Documentar cualquier problema** - Para feedback constructivo

**Tiempo estimado testing manual: 15-20 minutos**
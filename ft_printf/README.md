# Guía de uso para test_ft_printf.c

## Compilación

1. Asegúrate de que tu librería `libftprintf.a` esté compilada.
2. Compila el archivo de pruebas con el siguiente comando:

   ```bash
   gcc -Wall -Wextra -Werror test_ft_printf.c -L. -lftprintf -o test_printf
   ```

## Ejecución

Ejecuta el programa de pruebas especificando un especificador como argumento:

```bash
./test_printf <especificador>
```

## Especificadores disponibles

- `s`: Pruebas para strings (%s)
- `c`: Pruebas para caracteres (%c)
- `u`: Pruebas para enteros sin signo (%u)
- `x`: Pruebas para hexadecimal en minúsculas (%x)
- `X`: Pruebas para hexadecimal en mayúsculas (%X)
- `%`: Pruebas para el símbolo de porcentaje (%%%)
- `d`: Pruebas para enteros con signo (%d)
- `i`: Pruebas para enteros con signo (%i)
- `p`: Pruebas para punteros (%p)
- `+`: Pruebas para el flag de signo (+)
- `0`: Pruebas para el flag de cero (0)
- `simple`: Pruebas simples con múltiples conversores
- `bonus`: Pruebas para los bonus (flags #, espacio, +, 0, -)
- `all`: Ejecuta todas las pruebas

## Ejemplos de uso

```bash
./test_printf s    # Ejecuta las pruebas de strings
./test_printf d    # Ejecuta las pruebas de enteros con signo
./test_printf all  # Ejecuta todas las pruebas
```

## Nota sobre el manejo de errores

Si se proporciona un especificador no reconocido, el programa mostrará un mensaje de error:

```c
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Por favor, proporciona un especificador como argumento.\n");
        return 1;
    }

    char *specifier = argv[1];
    run_test(specifier);

    return 0;
}
```

En caso de que el especificador no sea reconocido, se mostrará el mensaje:
"Especificador no reconocido: [especificador]"

Asegúrate de usar uno de los especificadores listados anteriormente para ejecutar las pruebas correctamente.
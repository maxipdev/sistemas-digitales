# Taller 5 — Paquete para estudiantes

Resolver primero las tablas del enunciado. `ejercicios/ej1/README.md` sirve
para anotar las respuestas. Después, completar estos archivos:

| Carpeta | Archivos a completar | Top para HDL Studio | Casos de prueba |
| --- | --- | --- | --- |
| ej2 | `overflow_4b.sv` y `top_module.sv` | `top_module` | 256 |
| ej3 | Pregunta conceptual, sin HDL | — | — |
| ej4 | `negativo_4b.sv` | `negativo_4b` | 16 |
| ej5 | `zero_4b.sv` | `zero_4b` | 16 |
| ej6 | `sumador_flags_4b.sv` | `sumador_flags_4b` | 256 |
| ej7 | `shifter_4b.sv` | `shifter_4b` | 32 |

## Componentes y conexiones

Ej2 y ej6 incluyen completos `sumador_simple.sv`, `sumador_completo.sv`
y `sumador_4b.sv` del Taller 1. No hace falta tener los talleres anteriores.
El sumador provisto conserva `cin`: al instanciarlo, conectarlo a `1'b0`.
Los sumadores de este taller calculan `a + b` en complemento a dos, sin carry
de entrada externo. `overflow` indica si la suma exacta queda fuera de [−8, 7].

- **Ej2:** implementar el detector de overflow y completar en `top_module.sv`
  su conexión con el sumador. La salida `overflow` corresponde a complemento
  a dos. El detector se reutilizará por separado.
- **Ej3:** responder qué conectar al flag Carry del sumador y si tiene
  sentido distinguir entre signed y unsigned. No hay circuito a implementar.
- **Ej4 y ej5:** reciben únicamente `dato`, de 4 bits, y producen `negativo`
  o `zero`. Se prueban directamente, sin sumador ni top adicional.
- **Ej6:** reutilizar los módulos de ej2, ej4 y ej5, con una sola instancia del
  sumador en todo el circuito. Expone `sum`, `overflow`, `carry`,
  `negativo` y `zero`. N y Z se calculan sobre el resultado de 4 bits.

- **Ej7:** desplazar `dato` una posición a derecha. `aritmetico=1` extiende
  el signo y calcula N/Z sobre `resultado`; `aritmetico=0` ingresa cero y
  mantiene N/Z en cero. Reutilizar los detectores de ej4 y ej5.

Las copias de los módulos anteriores ya están en ej6. `make deps` o `make sim`
las actualiza desde ej2, ej4 y ej5: editar los originales, porque las copias se
sobrescriben. Los sumadores del Taller 1 y los testbenches están provistos;
no modificarlos. En ej7 también se incluyen copias de N/Z, que `make deps`
actualiza desde ej4 y ej5.

## Simulación y circuito

Desde la carpeta de cada ejercicio de HDL:

```sh
make sim    # comprobar todos los valores de entrada
make deps   # actualizar las dependencias sin simular
make wave   # simular e indicar dónde abrir la traza
make clean  # borrar obj_dir; conserva los fuentes
```

Las plantillas compilan, pero los tests deben fallar hasta resolverlas.
La salida correcta indica `fallos: 0`: 256 combinaciones en ej2 y ej6;
16 valores de dato en ej4 y ej5; 32 combinaciones de dato y modo en ej7.

En HDL Studio, agregar todos los `.sv` de la carpeta excepto el `*_tb.sv`
y elegir el top de la tabla. No agregar módulos de otras carpetas porque
pueden repetir nombres. En ej6 y ej7, ejecutar antes `make deps`.

**TIP:** En el sumador con flags, probar las sumas del ejercicio 1 en el
circuito sintetizado y comparar resultados y flags con las cuentas a mano.

El Makefile compila en un temporal sin espacios; la traza queda en
`obj_dir/sim.vcd` dentro del ejercicio, incluso con espacios en la ruta.


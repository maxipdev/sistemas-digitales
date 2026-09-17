# Ejercicio 7 — Shifter aritmético-lógico

Completar `shifter_4b.sv`: desplazar `dato` una posición a derecha y producir
`resultado`, ambos de 4 bits.

- `aritmetico=1`: extender el signo y calcular `negativo` (N) y `zero` (Z)
  sobre el resultado.
- `aritmetico=0`: ingresar un 0 por el bit más significativo; N y Z valen 0,
  incluso si el resultado es cero.

Reutilizar los módulos de ej4 y ej5. Sus copias están incluidas: `make deps`
o `make sim` las actualiza desde esos ejercicios. Editar los originales.

Ejecutar `make sim` y verificar los 32 casos. No modificar el testbench.
En HDL Studio agregar los tres módulos `.sv` (sin el testbench) y elegir
`shifter_4b` como top. Ver `../../README.md`.

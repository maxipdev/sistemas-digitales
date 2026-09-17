# Ejercicio 6 — Sumador con flags

Completar `sumador_flags_4b.sv` reutilizando los módulos de ej2, ej4 y ej5
y el sumador provisto. El resultado se interpreta en complemento a dos
y `overflow` corresponde a esa representación. Conectar Carry según lo respondido en ej3.
Usar una sola instancia del sumador en todo el circuito. Ejecutar `make deps`
para actualizar las copias después de resolver los ejercicios anteriores.

Ejecutar `make sim` y verificar que los 256 casos pasen. No modificar
el testbench. En HDL Studio usar `sumador_flags_4b` como top y agregar todos
los `.sv` locales salvo el testbench. Ver `../../README.md`.

**TIP:** Probar las sumas del ejercicio 1 en el circuito sintetizado y
comparar el resultado y las flags con las cuentas a mano.

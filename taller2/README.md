# Taller 2 — Circuitos secuenciales

Sintaxis, simulación, síntesis y herramientas: `sintaxis.typ`.

Cada ejercicio vive en `ejercicios/ejN`. `make sim` copia a esa carpeta los
`.sv` de ejercicios anteriores. Resolver en orden. No editar las copias.

1. Completar el módulo nuevo (el `.sv` que no es `_tb`).
2. En la carpeta del ejercicio: `make sim`.
3. `make wave` para ver `clk` y los registros alineados a los flancos.
4. HDL Studio: _Create circuit_ y **agregar** al circuito los `.sv` copiados
   (no el `_tb`). Sintetizar. Tienen que verse flip-flops.

Los testbenches no se modifican.

Entregar la carpeta `ejercicios/` completa (todos los ejercicios).

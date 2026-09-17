# Ejercicio 1 — Tablas

SS: sin signo; C2: complemento a dos. Resultados de 4 bits.

En la resta se llama Carry al acarreo de `A + ~B + 1` (con `~B` de
4 bits) y Borrow al préstamo de `A - B`: `Borrow = 1 - Carry`.

## Suma

| Op1 | Op2 | Op1 SS | Op2 SS | Res bits | Res SS | V SS | Op1 C2 | Op2 C2 | Res C2 | V C2 | Carry | Borrow |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1111 | 0001 |  |  |  |  |  |  |  |  |  |  |  |
| 0001 | 1111 |  |  |  |  |  |  |  |  |  |  |  |
| 0101 | 0101 |  |  |  |  |  |  |  |  |  |  |  |
| 1000 | 0111 |  |  |  |  |  |  |  |  |  |  |  |
| 0110 | 1010 |  |  |  |  |  |  |  |  |  |  |  |

## Resta

| Op1 | Op2 | Op1 SS | Op2 SS | Res bits | Res SS | V SS | Op1 C2 | Op2 C2 | Res C2 | V C2 | Carry | Borrow |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1000 | 0010 |  |  |  |  |  |  |  |  |  |  |  |
| 0001 | 1111 |  |  |  |  |  |  |  |  |  |  |  |
| 0101 | 0101 |  |  |  |  |  |  |  |  |  |  |  |
| 1000 | 0111 |  |  |  |  |  |  |  |  |  |  |  |
| 0110 | 1010 |  |  |  |  |  |  |  |  |  |  |  |

## Preguntas

1. Relacionar Carry/Borrow con el overflow en ambas representaciones.
2. Determinar si al sumar dos números puede aparecer un acarreo mayor que
   1 en alguna base; justificar con una demostración o un ejemplo.

Este ejercicio se resuelve en papel. Tienen que completarlo en el archivo HTML (abriendolo en el navegador) y luego haciendo click en "descargar respuestas". Ese archivo HTML se entrega. Las preguntas no.

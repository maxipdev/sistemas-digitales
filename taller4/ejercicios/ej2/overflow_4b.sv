module overflow_4b (
    input logic [3:0] a, b, sum,
    output logic overflow
);
  // COMPLETAR: implementar el flag indicado en el ENUNCIADO.


  // tenbgo que detectar si hay overflow o no
  
  // obtengo el primer bit de cada uno: (el mas significativo)
  logic a1, b1, r1;
  assign a1 = a[3];
  assign b1 = b[3];
  assign r1 = sum[3];

  // una manera de hacerlo, es mirando si lso 2 bits son iguales y luego cambia el resultado, hay overflow

  // esto es pq hacer un XOR: a1 ^ b1 == 1 si es que son distintos, si son iguales da cero
  // pero necesito que de 1 si son iguales, entonces puedo hacer un nor -> ~ (a1 ^ b1)
  // ahora  quiero ver que sea igual a la salida, ~ (a1 ^ b1) & (a1 ^ r1)
  // aca da lo mismo usar el a1 o b1, pq estamos asumiendo que a y b son iguales
  assign overflow = ~(a1 ^ b1) & (a1 ^ r1);

endmodule

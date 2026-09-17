module sumador_flags_4b (
    input logic [3:0] a, b,
    output logic [3:0] sum,
    output logic overflow, carry, negativo, zero
);
  // COMPLETAR: Instanciar el sumador provisto y los módulos de ej2, ej4 y ej5.
  // Conectar el flag Carry según lo respondido en ej3. Usar un solo sumador.

  sumador_4b sumador_4bits (
    .a   (a),
    .b   (b),
    .cin (1'b0), // le ponemos carry de inicio en cero
    .sum (sum),
    .cout(carry)
  );

  //miro si hay overflow: 
  overflow_4b overflow_4bits (
    .a       (a),
    .b       (b),
    .sum     (sum),
    .overflow(overflow)
  );

  //miro si es cero
  zero_4b zero_4bits (
    .dato(sum),
    .zero(zero)
  );

  // miro si es negativo
  negativo_4b negativo_4bits (
    .dato    (sum),
    .negativo(negativo)
  );
  
endmodule

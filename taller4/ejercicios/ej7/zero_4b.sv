module zero_4b (
    input logic [3:0] dato,
    output logic zero
);
  // COMPLETAR: Indicar si dato es cero.

  // como sabemos que hay un dato de 4 bits, entonce sya se como es la cantidad para analizar

  assign zero = ~(dato[3] || dato[2] || dato[1] || dato[0]);
endmodule

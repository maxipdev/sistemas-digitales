module negativo_4b (
    input logic [3:0] dato,
    output logic negativo
);
  // COMPLETAR: Indicar si dato es negativo en complemento a dos.

  // podemos hacer la logica que dado un numero sabemso que es negativo si el bit mas significante es 1
  // entonces es negativo <=> el bit es 1 
  // puedo comparar los bits, es decir, miro si es igual a 1 y ese va a ser mi resultrado, 1 si es negativo y 0 si es positivo, es decir, falso

  assign negativo = dato[3] & 1'b1;
endmodule

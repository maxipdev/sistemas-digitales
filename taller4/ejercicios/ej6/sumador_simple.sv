module sumador_simple (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);
  // Half-adder: suma de 1 bit sin acarreo de entrada.
  // Cumple la tabla del enunciado: sum=1 iff a y b son distintos; cout=1 iff ambos son 1.
  assign sum  = a ^ b;  // sum = a xor b
  assign cout = a & b;  // cout = a and b
endmodule

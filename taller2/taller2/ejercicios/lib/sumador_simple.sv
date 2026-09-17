// Sumador simple del Taller 1. No modificar.
module sumador_simple (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);
  assign sum  = a ^ b;
  assign cout = a & b;
endmodule

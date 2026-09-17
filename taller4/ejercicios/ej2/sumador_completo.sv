module sumador_completo (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);
  logic d1, c1, c2;

  // Full-adder con dos sumador_simple + OR, según el diagrama del enunciado.
  // Primer half-adder: a + b → suma parcial d1 y acarreo c1.
  sumador_simple ha0 (
      .a(a),
      .b(b),
      .sum(d1),
      .cout(c1)
  );

  // Segundo half-adder: d1 + cin → suma final y acarreo c2.
  sumador_simple ha1 (
      .a(d1),
      .b(cin),
      .sum(sum),
      .cout(c2)
  );

  // cout si cualquiera de los dos half-adders genera acarreo.
  assign cout = c1 | c2;
endmodule

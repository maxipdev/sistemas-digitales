

module sumador_completo (
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);
  logic d1, c1, c2;


  sumador_simple sp1 (
    .a(a),
    .b(b),
    .sum(d1),
    .cout(c1)
  );

  sumador_simple sp2 (
    .a(d1),
    .b(cin),
    .sum(sum),
    .cout(c2)
  );

  assign cout = c1 | c2;
  // instanciar dos sumador_simple y armar cout
endmodule

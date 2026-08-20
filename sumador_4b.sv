module sumador_4b (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       cin,
    output logic [3:0] sum,
    output logic       cout
);
  logic c1, c2, c3;
  // instanciar cuatro sumador_completo
  logic res1, res2, res3, res4;

  sumador_completo sc1 (
    .a(a[0]), // escribimos el bit menos significativo
    .b(b[0]),
    .cin(cin),
    .sum(res1),
    .cout(c1)
  );

  sumador_completo sc2 (
    .a(a[1]),
    .b(b[1]),
    .cin(c1),
    .sum(res2),
    .cout(c2)
  );

  sumador_completo sc3 (
    .a(a[2]),
    .b(b[2]),
    .cin(c2),
    .sum(res3),
    .cout(c3)
  );

  sumador_completo sc4 (
    .a(a[3]),
    .b(b[3]),
    .cin(c3),
    .sum(res4),
    .cout(cout) // conecta la puerta hacia afuera
  );

  // defino la suma 
  assign sum[0] = res1;
  assign sum[1] = res2;
  assign sum[2] = res3;
  assign sum[3] = res4;

endmodule

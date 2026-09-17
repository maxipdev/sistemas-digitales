module sumador_restador_4b (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       ctrl,
    output logic [3:0] y,
    output logic       cout
);
  logic [3:0] sum, diff;
  logic       add_cout, bout;

  restador_4b restador(
    .a(a),
    .b(b),
    .bin(0),
    .diff(diff),
    .bout(bout)
  );

  sumador_4b sumador (
    .a(a),
    .b(b),
    .cin(0),
    .sum(sum),
    .cout(add_cout)
  );

  
  assign y = ctrl ? diff : sum;
  assign cout = ctrl ? bout : add_cout;


endmodule

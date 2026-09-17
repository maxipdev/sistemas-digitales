module sumador_completo_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic a, b, cin, sum, cout;
  logic [2:0] value;
  logic       dv;
  logic       pass;
  logic [1:0] exp;

  assign {cin, a, b} = value;
  assign exp = {1'b0, a} + {1'b0, b} + {1'b0, cin};
  assign pass = (sum == exp[0]) && (cout == exp[1]);

  sumador_completo dut (
      .a(a),
      .b(b),
      .cin(cin),
      .sum(sum),
      .cout(cout)
  );

  oracle_tb #(
      .N(3)
  ) oracle (
      .clk(clk),
      .rst(rst),
      .pass(pass),
      .done(done),
      .value(value),
      .dv(dv),
      .pass_all(pass_all)
  );
endmodule

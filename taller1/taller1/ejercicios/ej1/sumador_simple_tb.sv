module sumador_simple_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic a, b, sum, cout;
  logic [1:0] value;
  logic       dv;
  logic       pass;
  logic [1:0] exp;

  assign {a, b} = value;
  assign exp = {1'b0, a} + {1'b0, b};
  assign pass = (sum == exp[0]) && (cout == exp[1]);

  sumador_simple dut (
      .a(a),
      .b(b),
      .sum(sum),
      .cout(cout)
  );

  oracle_tb #(
      .N(2)
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

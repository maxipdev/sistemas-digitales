module sumador_4b_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic [3:0] a, b, sum;
  logic       cin, cout;
  logic [8:0] value;
  logic       dv;
  logic       pass;
  logic [4:0] exp;

  assign {cin, a, b} = value;
  assign exp = {1'b0, a} + {1'b0, b} + {4'b0, cin};
  assign pass = (sum == exp[3:0]) && (cout == exp[4]);

  sumador_4b dut (
      .a(a),
      .b(b),
      .cin(cin),
      .sum(sum),
      .cout(cout)
  );

  oracle_tb #(
      .N(9)
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

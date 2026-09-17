module sumador_restador_4b_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic [3:0] a, b, y;
  logic       ctrl, cout;
  logic [8:0] value;
  logic       dv;
  logic       pass;
  logic [4:0] exp;

  assign {ctrl, a, b} = value;
  assign exp = ctrl ? ({1'b0, a} - {1'b0, b})
                    : ({1'b0, a} + {1'b0, b});
  assign pass = (y == exp[3:0]) && (cout == exp[4]);

  sumador_restador_4b dut (
      .a(a),
      .b(b),
      .ctrl(ctrl),
      .y(y),
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

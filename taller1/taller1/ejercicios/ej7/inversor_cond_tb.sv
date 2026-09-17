module inversor_cond_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic [3:0] x, y;
  logic       ctrl;
  logic [4:0] value;
  logic       dv;
  logic       pass;
  logic [3:0] exp;

  assign {ctrl, x} = value;
  assign exp  = x ^ {4{ctrl}};
  assign pass = (y == exp);

  inversor_cond dut (
      .x(x),
      .ctrl(ctrl),
      .y(y)
  );

  oracle_tb #(
      .N(5)
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

module formula_and_or_not_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic x, y, z, f;
  logic [2:0] value;
  logic       dv;
  logic       pass;
  logic       exp;

  assign {x, y, z} = value;
  assign exp  = (x | y) & (x | ~y) & (x | z);
  assign pass = (f == exp);

  formula_and_or_not dut (
      .x(x),
      .y(y),
      .z(z),
      .f(f)
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

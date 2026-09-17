module restador_completo_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic a, b, bin, diff, bout;
  logic [2:0] value;
  logic       dv;
  logic       pass;
  logic [1:0] tmp;

  assign {bin, a, b} = value;
  // a - b - bin en 2 bits: tmp[0] = diff, tmp[1] = borrow
  assign tmp  = {1'b0, a} - {1'b0, b} - {1'b0, bin};
  assign pass = (diff == tmp[0]) && (bout == tmp[1]);

  restador_completo dut (
      .a(a),
      .b(b),
      .bin(bin),
      .diff(diff),
      .bout(bout)
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

module restador_4b_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic [3:0] a, b, diff;
  logic       bin, bout;
  logic [8:0] value;
  logic       dv;
  logic       pass;
  logic [4:0] tmp;

  assign {bin, a, b} = value;
  assign tmp  = {1'b0, a} - {1'b0, b} - {4'b0, bin};
  assign pass = (diff == tmp[3:0]) && (bout == tmp[4]);

  restador_4b dut (
      .a(a),
      .b(b),
      .bin(bin),
      .diff(diff),
      .bout(bout)
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

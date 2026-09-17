module restador_simple_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic a, b, diff, bout;
  logic [1:0] value;
  logic       dv;
  logic       pass;

  assign {a, b} = value;
  assign pass = (diff == (a ^ b)) && (bout == (~a & b));

  restador_simple dut (
      .a(a),
      .b(b),
      .diff(diff),
      .bout(bout)
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

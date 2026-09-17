module registro_1b_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic we, din, q;
  logic rst_extra;
  logic dut_rst;

  assign dut_rst = rst | rst_extra;

  registro_1b dut (
      .clk(clk),
      .rst(dut_rst),
      .we (we),
      .din(din),
      .q  (q)
  );

  `include "tb_seq.svh"

  initial begin
    we        = 1'b0;
    din       = 1'b0;
    rst_extra = 1'b0;
    start_tb();

    expect_eq("reset inicial", q, 0);

    // Carga 1.
    we  = 1'b1;
    din = 1'b1;
    cycle();
    expect_eq("we=1 carga 1", q, 1);

    // Conserva con we=0 aunque din cambie.
    we  = 1'b0;
    din = 1'b0;
    cycle();
    expect_eq("we=0 conserva 1", q, 1);

    // Carga 0.
    we  = 1'b1;
    din = 1'b0;
    cycle();
    expect_eq("we=1 carga 0", q, 0);

    // rst y we juntos: gana rst.
    we        = 1'b1;
    din       = 1'b1;
    rst_extra = 1'b1;
    cycle();
    expect_eq("rst gana a we", q, 0);
    rst_extra = 1'b0;

    finish_tb();
  end
endmodule

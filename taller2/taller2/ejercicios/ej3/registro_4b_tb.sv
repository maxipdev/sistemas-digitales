module registro_4b_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic       we;
  logic [3:0] din;
  logic [3:0] q;
  logic       rst_extra;
  logic       dut_rst;

  assign dut_rst = rst | rst_extra;

  registro_4b dut (
      .clk(clk),
      .rst(dut_rst),
      .we (we),
      .din(din),
      .q  (q)
  );

  `include "tb_seq.svh"

  initial begin
    we        = 1'b0;
    din       = 4'b0000;
    rst_extra = 1'b0;
    start_tb();

    expect_eq("reset inicial", q, 0);

    we  = 1'b1;
    din = 4'b1010;
    cycle();
    expect_eq("carga 1010", q, 4'b1010);

    we  = 1'b0;
    din = 4'b1111;
    cycle();
    expect_eq("we=0 conserva 1010", q, 4'b1010);

    we  = 1'b1;
    din = 4'b0101;
    cycle();
    expect_eq("carga 0101", q, 4'b0101);

    we        = 1'b1;
    din       = 4'b1111;
    rst_extra = 1'b1;
    cycle();
    expect_eq("rst gana a we", q, 0);
    rst_extra = 1'b0;

    finish_tb();
  end
endmodule

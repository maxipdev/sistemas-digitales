module transferencia_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic [3:0] force_in;
  logic       force_en;
  logic [1:0] src;
  logic       we0, we1, we2, we3;
  logic [3:0] r0, r1, r2, r3;
  logic       rst_extra;
  logic       dut_rst;

  assign dut_rst = rst | rst_extra;

  transferencia dut (
      .clk     (clk),
      .rst     (dut_rst),
      .force_in(force_in),
      .force_en(force_en),
      .src     (src),
      .we0     (we0),
      .we1     (we1),
      .we2     (we2),
      .we3     (we3),
      .r0      (r0),
      .r1      (r1),
      .r2      (r2),
      .r3      (r3)
  );

  `include "tb_seq.svh"

  task automatic idle();
    force_en = 1'b0;
    force_in = 4'b0000;
    src      = 2'b00;
    we0      = 1'b0;
    we1      = 1'b0;
    we2      = 1'b0;
    we3      = 1'b0;
  endtask

  task automatic force_reg(input int dest, input logic [3:0] val);
    idle();
    force_en = 1'b1;
    force_in = val;
    we0      = (dest == 0);
    we1      = (dest == 1);
    we2      = (dest == 2);
    we3      = (dest == 3);
    cycle();
    idle();
  endtask

  task automatic copy(input logic [1:0] from, input int dest);
    idle();
    src = from;
    we0 = (dest == 0);
    we1 = (dest == 1);
    we2 = (dest == 2);
    we3 = (dest == 3);
    cycle();
    idle();
  endtask

  initial begin
    rst_extra = 1'b0;
    idle();
    start_tb();

    expect_eq("reset R0", r0, 0);
    expect_eq("reset R1", r1, 0);
    expect_eq("reset R2", r2, 0);
    expect_eq("reset R3", r3, 0);

    // Receta del enunciado: R0=1010, R0→R1, R2=0100, R2→R0, R1→R2.
    force_reg(0, 4'b1010);
    expect_eq("R0=1010", r0, 4'b1010);
    copy(2'b00, 1);  // R0 → R1
    expect_eq("R0→R1", r1, 4'b1010);
    expect_eq("R0 sigue 1010", r0, 4'b1010);

    force_reg(2, 4'b0100);
    expect_eq("R2=0100", r2, 4'b0100);
    copy(2'b10, 0);  // R2 → R0
    expect_eq("R2→R0", r0, 4'b0100);
    copy(2'b01, 2);  // R1 → R2
    expect_eq("R1→R2", r2, 4'b1010);
    expect_eq("R1 sigue 1010", r1, 4'b1010);
    expect_eq("R3 intacto", r3, 0);

    idle();
    cycle();
    expect_eq("idle R0", r0, 4'b0100);
    expect_eq("idle R1", r1, 4'b1010);
    expect_eq("idle R2", r2, 4'b1010);
    expect_eq("idle R3", r3, 0);

    // src=11 y we3 (si el mux trata 1x como R2, esto falla).
    force_reg(3, 4'b0110);
    expect_eq("R3=0110", r3, 4'b0110);
    expect_eq("force R3 no pisa R2", r2, 4'b1010);
    copy(2'b11, 1);  // R3 → R1
    expect_eq("R3→R1", r1, 4'b0110);

    finish_tb();
  end
endmodule

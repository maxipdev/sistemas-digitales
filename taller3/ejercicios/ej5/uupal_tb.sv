module uupal_tb(input logic clk, input logic rst, output logic done, output logic pass_all);
  logic [3:0] force_in;
  logic force_en, we0, we1, we2, we3, load_op_a, load_op_b;
  logic [1:0] src_a, src_b, op;
  logic [3:0] r0, r1, r2, r3, operand_a, operand_b, and_value, or_value, result;

  uupal dut(.*);
  `include "tb_helpers.svh"

  task automatic idle();
    force_in=0; force_en=0;
    we0=0; we1=0; we2=0; we3=0;
    src_a=0; src_b=0; load_op_a=0; load_op_b=0;
    op=0;
  endtask

  task automatic we_only(input logic [1:0] target);
    we0 = (target == 2'b00);
    we1 = (target == 2'b01);
    we2 = (target == 2'b10);
    we3 = (target == 2'b11);
  endtask

  task automatic force_register(input logic [1:0] target, input logic [3:0] value);
    idle(); force_en=1; force_in=value; we_only(target); cycle(); idle();
  endtask

  task automatic load_operands(input logic [1:0] source_a, input logic [1:0] source_b);
    idle(); src_a=source_a; src_b=source_b;
    load_op_a=1; load_op_b=1; cycle(); idle();
  endtask

  task automatic save_result(input logic [1:0] operation, input logic [1:0] target);
    idle(); op=operation; force_en=0; we_only(target); #1;
    cycle(); idle();
  endtask

  initial begin
    done=0; pass_all=1; nfail=0; idle(); wait(!rst); @(negedge clk);
    expect_eq("reset R0",r0,0); expect_eq("reset R1",r1,0);
    expect_eq("reset R2",r2,0); expect_eq("reset R3",r3,0);

    force_register(2'b00,4'd3);
    force_register(2'b01,4'd5);
    expect_eq("R0=3",r0,3); expect_eq("R1=5",r1,5);
    expect_eq("force R0 no toca R1",r1,5);
    expect_eq("force R1 no toca R0",r0,3);

    force_register(2'b00,4'd7);
    expect_eq("we0 reescribe R0",r0,7);
    expect_eq("we0 no toca R1",r1,5);
    force_register(2'b00,4'd3);

    load_operands(2'b00,2'b01);
    expect_eq("operando A",operand_a,3); expect_eq("operando B",operand_b,5);
    save_result(2'b10,2'b10); // R2 <- R0+R1
    expect_eq("R2=R0+R1",r2,8);

    load_operands(2'b10,2'b01);
    save_result(2'b00,2'b11); // R3 <- R2 AND R1
    expect_eq("R3=R2 AND R1",r3,0);

    load_operands(2'b11,2'b01);
    expect_eq("R3 llega a operand_a",operand_a,0);
    expect_eq("R1 llega a operand_b",operand_b,5);
    save_result(2'b01,2'b00); // R0 <- R3 OR R1
    expect_eq("R0=R3 OR R1",r0,5);

    load_operands(2'b00,2'b10);
    save_result(2'b11,2'b01); // R1 <- R0-R2 = 13 mod 16
    expect_eq("R1=R0-R2 modulo 16",r1,13);
    finish_tb();
  end
endmodule

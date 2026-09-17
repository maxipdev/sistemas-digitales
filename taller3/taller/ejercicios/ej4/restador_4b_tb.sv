module restador_4b_tb(input logic clk, input logic rst, output logic done, output logic pass_all);
  logic [3:0] a, b, diff; logic bin, bout; logic [4:0] expected; integer i;
  restador_4b dut(.a(a), .b(b), .bin(bin), .diff(diff), .bout(bout));
  `include "tb_helpers.svh"
  initial begin
    done=0; pass_all=1; nfail=0; wait(!rst);
    for (i=0; i<512; i++) begin
      {bin,a,b}=i[8:0]; #1; expected={1'b0,a}-{1'b0,b}-bin;
      if ({bout,diff} !== expected) nfail++;
    end
    finish_tb();
  end
endmodule


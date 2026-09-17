module sumador_4b_tb(input logic clk, input logic rst, output logic done, output logic pass_all);
  logic [3:0] a, b, sum; logic cin, cout; logic [4:0] expected; integer i;
  sumador_4b dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
  `include "tb_helpers.svh"
  initial begin
    done=0; pass_all=1; nfail=0; wait(!rst);
    for (i=0; i<512; i++) begin
      {cin,a,b}=i[8:0]; #1; expected={1'b0,a}+{1'b0,b}+cin;
      if ({cout,sum} !== expected) nfail++;
    end
    finish_tb();
  end
endmodule


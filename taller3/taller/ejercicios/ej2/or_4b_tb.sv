module or_4b_tb(input logic clk, input logic rst, output logic done, output logic pass_all);
  logic [3:0] a, b, y;
  integer i, j;
  compuerta_or_4b dut (.a(a), .b(b), .result(y));
  `include "tb_helpers.svh"
  initial begin
    done=0; pass_all=1; nfail=0; a=0; b=0; wait(!rst);
    for (i=0; i<16; i++) for (j=0; j<16; j++) begin
      a=i[3:0]; b=j[3:0]; #1;
      if (y !== (a | b)) nfail++;
    end
    expect_eq("OR 1010 y 0101", (4'b1010 | 4'b0101), 4'b1111);
    finish_tb();
  end
endmodule

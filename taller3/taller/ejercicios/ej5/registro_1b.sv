module registro_1b(
    input logic clk, input logic rst, input logic we, input logic din, output logic q
);
  logic d_ff;
  assign d_ff = we ? din : q;
  ff_d u_ff(.clk(clk), .rst(rst), .d(d_ff), .q(q));
endmodule


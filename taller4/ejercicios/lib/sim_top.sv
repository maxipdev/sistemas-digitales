`ifndef TB_MODULE
`define TB_MODULE dummy_tb
`endif
module sim_top;
  logic clk, rst, done, pass_all;
  initial clk = 1'b0;
  always #5 clk = ~clk;
  string trace_file;
  initial begin
    if (!$value$plusargs("trace_file=%s", trace_file)) trace_file = "obj_dir/sim.vcd";
    $dumpfile(trace_file);
    $dumpvars(0, sim_top);
    rst = 1'b1;
    repeat (2) @(posedge clk);
    @(negedge clk);
    rst = 1'b0;
    wait (done);
    repeat (2) @(posedge clk);
    if (!pass_all) $fatal(1, "Hubo tests que fallaron");
    $finish;
  end
  initial begin
    #10000;
    $fatal(1, "Timeout: el testbench no terminó");
  end
  `TB_MODULE tb (.clk(clk), .rst(rst), .done(done), .pass_all(pass_all));
endmodule


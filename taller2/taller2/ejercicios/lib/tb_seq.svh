integer nfail;
integer npass;

task automatic start_tb();
  nfail    = 0;
  npass    = 0;
  done     = 1'b0;
  pass_all = 1'b1;
  wait (!rst);
  @(negedge clk);
endtask

task automatic expect_eq(input string tag, input integer got, input integer exp);
  if (got !== exp) begin
    $display("\033[31mFAIL: %s  got=%0d (%b)  exp=%0d (%b)\033[0m",
             tag, got, got, exp, exp);
    nfail++;
  end else begin
    $display("\033[32mPASS: %s\033[0m", tag);
    npass++;
  end
endtask

task automatic finish_tb();
  if (nfail == 0) begin
    $display("");
    $display("\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    $display("  ✓  PASS: todos los tests pasaron");
    $display("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m");
    $display("");
    pass_all = 1'b1;
  end else begin
    $display("");
    $display("\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    $display("  ✗  FAIL: hubo tests que fallaron");
    $display("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m");
    $display("");
    pass_all = 1'b0;
  end
  done = 1'b1;
endtask

task automatic cycle();
  @(posedge clk);
  @(negedge clk);
endtask

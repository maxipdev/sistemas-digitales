module oracle_tb #(
    parameter integer N         = 4,
    parameter bit     FAST_FAIL = 0
) (
    input  logic         clk,
    input  logic         rst,
    input  logic         pass,
    output logic         done,
    output logic [N-1:0] value,
    output logic         dv,
    output logic         pass_all
);

  logic tests_passing;
  logic first;

  assign pass_all = tests_passing;

  always_ff @(posedge clk) begin
    if (rst) begin
      value         <= '1;
      done          <= 1'b0;
      dv            <= 1'b0;
      tests_passing <= 1'b1;
      first         <= 1'b1;
    end else if (!done) begin
      value <= value + 1'b1;
      dv    <= 1'b1;
      first <= 1'b0;
      if (!first) begin
        if (!pass) begin
          $display("\033[31mFAIL: value = %0d (%b)\033[0m", value, value);
          tests_passing <= 1'b0;
          if (FAST_FAIL || (&value)) begin
            done <= 1'b1;
            dv   <= 1'b0;
          end
        end else if (&value) begin
          done <= 1'b1;
          dv   <= 1'b0;
        end
      end
    end
  end

  initial begin
    wait (done);
    if (tests_passing) begin
      $display("");
      $display("\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      $display("  ✓  PASS: todos los tests pasaron");
      $display("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m");
      $display("");
    end else begin
      $display("");
      $display("\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      $display("  ✗  FAIL: hubo tests que fallaron");
      $display("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m");
      $display("");
    end
  end

endmodule

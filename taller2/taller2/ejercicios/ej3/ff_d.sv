module ff_d (
    input  logic clk,
    input  logic rst,
    input  logic d,
    output logic q
);
  // completar: always_ff @(posedge clk)
  // prioridad: rst → q <= 0; si no, q <= d

  always_ff @(posedge clk) begin
    if (rst) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end


endmodule

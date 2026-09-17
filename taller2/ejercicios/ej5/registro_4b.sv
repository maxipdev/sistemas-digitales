module registro_4b (
    input  logic       clk,
    input  logic       rst,
    input  logic       we,
    input  logic [3:0] din,
    output logic [3:0] q
);
  // completar: cuatro registro_1b, un bit cada uno
  registro_1b r1 (
    .clk(clk),
    .rst(rst),
    .we(we),
    .din(din[0]),
    .q(q[0])
  );

  registro_1b r2 (
    .clk(clk),
    .rst(rst),
    .we(we),
    .din(din[1]),
    .q(q[1])
  );

  registro_1b r3 (
    .clk(clk),
    .rst(rst),
    .we(we),
    .din(din[2]),
    .q(q[2])
  );

registro_1b r4 (
    .clk(clk),
    .rst(rst),
    .we(we),
    .din(din[3]),
    .q(q[3])
  );


endmodule

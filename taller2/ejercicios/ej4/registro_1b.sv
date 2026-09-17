module registro_1b (
    input  logic clk,
    input  logic rst,
    input  logic we,
    input  logic din,
    output logic q
);
  // completar: instanciar ff_d y un mux (we ? din : q)

  logic d;
  assign d = we ? din : q;

  ff_d flip_flop (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
  );
endmodule

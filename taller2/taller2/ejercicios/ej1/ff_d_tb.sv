module ff_d_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic d, q;
  logic rst_extra;
  logic dut_rst;

  assign dut_rst = rst | rst_extra;

  ff_d dut (
      .clk(clk),
      .rst(dut_rst),
      .d  (d),
      .q  (q)
  );

  `include "tb_seq.svh"

  initial begin
    d         = 1'b0;
    rst_extra = 1'b0;
    start_tb();

    // Tras el reset de sim_top, q tiene que ser 0.
    expect_eq("reset inicial", q, 0);

    // d=1 estable antes del flanco → q pasa a 1.
    d = 1'b1;
    cycle();
    expect_eq("carga 1", q, 1);

    // d baja a mitad de ciclo: q no sigue a d (no es un cable).
    d = 1'b0;
    expect_eq("d cambio entre flancos, q conserva", q, 1);
    cycle();
    expect_eq("flanco captura d=0", q, 0);

    // Reset a mitad de la prueba, con d=1: gana rst.
    d         = 1'b1;
    rst_extra = 1'b1;
    cycle();
    expect_eq("rst gana a d", q, 0);
    rst_extra = 1'b0;

    finish_tb();
  end
endmodule

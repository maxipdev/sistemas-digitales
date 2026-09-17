module datapath_sumador_tb (
    input  logic clk,
    input  logic rst,
    output logic done,
    output logic pass_all
);
  logic [3:0] force_in;
  logic       we_a, we_b, we_s;
  logic [3:0] r_a, r_b, r_s;
  logic       cout;
  logic       rst_extra;
  logic       dut_rst;

  assign dut_rst = rst | rst_extra;

  datapath_sumador dut (
      .clk     (clk),
      .rst     (dut_rst),
      .force_in(force_in),
      .we_a    (we_a),
      .we_b    (we_b),
      .we_s    (we_s),
      .r_a     (r_a),
      .r_b     (r_b),
      .r_s     (r_s),
      .cout    (cout)
  );

  `include "tb_seq.svh"

  task automatic idle();
    force_in = 4'b0000;
    we_a     = 1'b0;
    we_b     = 1'b0;
    we_s     = 1'b0;
  endtask

  initial begin
    rst_extra = 1'b0;
    idle();
    start_tb();

    expect_eq("reset A", r_a, 0);
    expect_eq("reset B", r_b, 0);
    expect_eq("reset S", r_s, 0);

    // Cargar 3 en A y 5 en B (dos ciclos).
    force_in = 4'b0011;
    we_a     = 1'b1;
    cycle();
    idle();
    expect_eq("A=3", r_a, 4'b0011);

    force_in = 4'b0101;
    we_b     = 1'b1;
    cycle();
    idle();
    expect_eq("B=5", r_b, 4'b0101);
    expect_eq("A sigue 3", r_a, 4'b0011);

    // Capturar suma. El sumador ya estaba calculando 3+5.
    we_s = 1'b1;
    cycle();
    idle();
    expect_eq("S=3+5", r_s, 4'b1000);
    expect_eq("A no se movio al sumar", r_a, 4'b0011);
    expect_eq("B no se movio al sumar", r_b, 4'b0101);

    // Mismo flanco: cargar A=7 y capturar S. S tiene que guardar 3+5, no 7+5.
    force_in = 4'b0111;
    we_a     = 1'b1;
    we_s     = 1'b1;
    cycle();
    idle();
    expect_eq("mismo flanco: A=7", r_a, 4'b0111);
    expect_eq("mismo flanco: S sigue 3+5 (operandos viejos)", r_s, 4'b1000);
    expect_eq("mismo flanco: B intacto", r_b, 4'b0101);

    finish_tb();
  end
endmodule

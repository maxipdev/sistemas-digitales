module flags_ej4_tb (
    input logic clk, rst,
    output logic done, pass_all
);
  logic [3:0] dato;
  logic negativo;
  `include "tb_helpers.svh"
  negativo_4b dut (.dato(dato), .negativo(negativo));
  initial begin
    done = 0;
    pass_all = 0;
    nfail = 0;
    dato = 0;
    wait (!rst);
    for (int i = 0; i < 16; i++) begin
      dato = 4'(i);
      #1;
      expect_eq($sformatf("dato=%0d negativo", i), int'(negativo), int'(i >= 8));
    end
    $display("16 combinaciones comprobadas; fallos: %0d", nfail);
    finish_tb();
  end
endmodule

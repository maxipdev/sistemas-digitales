module flags_ej5_tb (
    input logic clk, rst,
    output logic done, pass_all
);
  logic [3:0] dato;
  logic zero;
  `include "tb_helpers.svh"
  zero_4b dut (.dato(dato), .zero(zero));
  initial begin
    done = 0;
    pass_all = 0;
    nfail = 0;
    dato = 0;
    wait (!rst);
    for (int i = 0; i < 16; i++) begin
      dato = 4'(i);
      #1;
      expect_eq($sformatf("dato=%0d zero", i), int'(zero), int'(i == 0));
    end
    $display("16 combinaciones comprobadas; fallos: %0d", nfail);
    finish_tb();
  end
endmodule

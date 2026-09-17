module flags_ej6_tb (
    input logic clk, rst,
    output logic done, pass_all
);
  logic [3:0] a, b, sum;
  integer total, signed_total;
  logic overflow, carry, negativo, zero;
  `include "tb_helpers.svh"
  sumador_flags_4b dut (.a(a), .b(b), .sum(sum), .overflow(overflow), .carry(carry), .negativo(negativo), .zero(zero));
  initial begin
    done = 0;
    pass_all = 0;
    nfail = 0;
    a = 0; b = 0;
    wait (!rst);
    // Oráculo aritmético independiente de las ecuaciones del circuito.
    for (int i = 0; i < 16; i++) begin
      for (int j = 0; j < 16; j++) begin
        a = 4'(i); b = 4'(j);
        total = i + j;
        signed_total = (i < 8 ? i : i - 16) + (j < 8 ? j : j - 16);
        #1;
        expect_eq($sformatf("a=%0d b=%0d sum", i, j), int'(sum), total % 16);
        expect_eq($sformatf("a=%0d b=%0d overflow", i, j), int'(overflow), int'(signed_total < -8 || signed_total > 7));
        expect_eq($sformatf("a=%0d b=%0d carry", i, j), int'(carry), int'(total > 15));
        expect_eq($sformatf("a=%0d b=%0d negativo", i, j), int'(negativo), int'((total % 16) >= 8));
        expect_eq($sformatf("a=%0d b=%0d zero", i, j), int'(zero), int'((total % 16) == 0));
      end
    end
    $display("256 combinaciones comprobadas; fallos: %0d", nfail);
    finish_tb();
  end
endmodule

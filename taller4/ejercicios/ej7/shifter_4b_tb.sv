module shifter_4b_tb (
    input logic clk, rst,
    output logic done, pass_all
);
  logic [3:0] dato, resultado;
  logic aritmetico, negativo, zero;
  integer valor, esperado;
  `include "tb_helpers.svh"
  shifter_4b dut (.dato(dato), .aritmetico(aritmetico),
      .resultado(resultado), .negativo(negativo), .zero(zero));
  initial begin
    done = 0;
    pass_all = 0;
    nfail = 0;
    dato = 0;
    aritmetico = 0;
    wait (!rst);
    // Todos los datos y modos. Alternar el modo con el mismo dato también
    // comprueba que los flags se apaguen al pasar al modo lógico.
    for (int i = 0; i < 16; i++) begin
      for (int modo = 1; modo >= 0; modo--) begin
        dato = 4'(i);
        aritmetico = 1'(modo);
        valor = (modo == 1 && i >= 8) ? i - 16 : i;
        // Oráculo aritmético: división por 2 redondeada hacia menos infinito.
        // La división entera de SV trunca hacia cero, de ahí el ajuste negativo.
        esperado = valor < 0 ? (valor - 1) / 2 : valor / 2;
        #1;
        expect_eq($sformatf("dato=%0d aritmetico=%0d resultado", i, modo),
            int'(resultado), esperado < 0 ? esperado + 16 : esperado);
        expect_eq($sformatf("dato=%0d aritmetico=%0d negativo", i, modo),
            int'(negativo), int'(modo == 1 && esperado < 0));
        expect_eq($sformatf("dato=%0d aritmetico=%0d zero", i, modo),
            int'(zero), int'(modo == 1 && esperado == 0));
      end
    end
    $display("32 combinaciones comprobadas; fallos: %0d", nfail);
    finish_tb();
  end
endmodule

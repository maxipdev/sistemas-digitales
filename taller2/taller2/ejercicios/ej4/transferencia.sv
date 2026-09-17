module transferencia (
    input  logic       clk,
    input  logic       rst,
    input  logic [3:0] force_in,
    input  logic       force_en,
    input  logic [1:0] src,
    input  logic       we0,
    input  logic       we1,
    input  logic       we2,
    input  logic       we3,
    output logic [3:0] r0,
    output logic [3:0] r1,
    output logic [3:0] r2,
    output logic [3:0] r3
);
  // bus y cuatro registro_4b
  // force_en=1 → bus=force_in; si no, src elige r0/r1/r2/r3

  logic [3:0] bus; 

  assign bus = force_en ? force_in : 
    (src == 2'b00) ? r0 : 
    (src == 2'b01) ? r1 : 
    (src == 2'b10) ? r2 : r3;


  registro_4b reg0 (
    .clk(clk),
    .rst(rst),
    .we(we0),
    .din(bus),
    .q(r0)
  );

    registro_4b reg1 (
    .clk(clk),
    .rst(rst),
    .we(we1),
    .din(bus),
    .q(r1)
  );

    registro_4b reg2 (
    .clk(clk),
    .rst(rst),
    .we(we2),
    .din(bus),
    .q(r2)
  );

  registro_4b reg3 (
    .clk(clk),
    .rst(rst),
    .we(we3),
    .din(bus),
    .q(r3)
  );

endmodule

module contador_posicion (
    input logic clk, input logic rst,
    input logic subir, input logic bajar,
    output logic [1:0] posicion
);
  // COMPLETAR: contador saturado entre 0 (cerrado) y 3 (abierto).
  // saturado quiere decir que no se pasa del rango definido (ni para arriba, ni para abajo)

  // si es subir hay que incrementar 1 y si es bajar hay que disminuir en 1 
  // hay que hacer un suamdor y restador de 2 bits


  // Aca creo el flip flop que guarad en que posicion estoy
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      posicion <= 2'b00;
    end else if (subir & posicion < 2'b11) begin
      posicion <= posicion + 1'b01;
    end else if (bajar & posicion > 2'b00) begin
      posicion <= posicion - 1'b01;
    end // si es un else, queremos que las posicon sea la actual 
  end



endmodule

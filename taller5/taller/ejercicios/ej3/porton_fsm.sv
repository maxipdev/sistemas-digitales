module porton_fsm_smart (
    input logic clk, input logic rst, input logic button,
    input logic [1:0] posicion,
    output logic abrir, 
    output logic cerrar, 
    output logic pausa,
    output logic abierto, 
    output logic cerrado
);
  // COMPLETAR: un click inicia; durante el movimiento pausa; desde la pausa
  // otro click inicia el movimiento en la dirección opuesta.

typedef enum logic [2:0] {
    Cerrado,
    Abriendo,
    Pausa_abriendo,
    Abierto,
    Pausa_cerrando,
    Cerrando
} state;

state current_state, next_state;


// creo el registro
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= Cerrado;
    end else begin
        current_state <= next_state;
    end
end



// creo la funcion de transicion
always_comb begin
    next_state = current_state;

    case (current_state)
        // caso del cerrado
        Cerrado : if (button) next_state = Abriendo;

        // caso del abriendo
        Abriendo: begin
          if (button) next_state = Pausa_abriendo;
          else if (posicion == 2'b11) next_state = Abierto;
        end

        // caso de abierto
        Abierto: if (button) next_state = Cerrando;

        // caso del cerrando
        Cerrando : begin
          if (button) next_state = Pausa_cerrando;
          else if (posicion == 2'b00) next_state = Cerrado;
        end

        Pausa_abriendo: if (button) next_state = Cerrando;

        Pausa_cerrando: if (button) next_state = Abriendo;
        default: next_state = Cerrado;
    endcase
end


// Funcion de salida: 
always_comb begin
  abrir   = 1'b0;
  cerrar  = 1'b0;
  pausa   = 1'b0;
  abierto = 1'b0;
  cerrado = 1'b0;

case (current_state)
    Cerrado: begin
      cerrado = 1'b1;
    end

    // caso de abriendo
    Abriendo: begin
      abrir = 1'b1;
    end

    // caso de abierto
    Abierto: begin
      abierto = 1'b1;
    end

    // caso del cerrando
    Cerrando : begin
      cerrar = 1'b1;
    end

    Pausa_abriendo: begin
      pausa = 1'b1;
    end

    Pausa_cerrando: begin
      pausa = 1'b1;
    end

    default: begin
      cerrado = 1'b1;
    end
endcase
end
endmodule

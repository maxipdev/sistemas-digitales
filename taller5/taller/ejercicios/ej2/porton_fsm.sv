module porton_fsm_long (
    input logic clk, input logic rst, input logic button,
    input logic [1:0] posicion,
    output logic subir, 
    output logic bajar,
    output logic abierto, 
    output logic cerrado
);


typedef enum logic [1:0] {
    S0, S1, S2, S3
  } state;

  state current_state, next_state;


// creo el registro
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= S0;
    end else begin
        current_state <= next_state;
    end
end

// creo la funcion de transicion
always_comb begin
    next_state = current_state;

    case (current_state)
        // caso del cerrado
        S0 : if (button) next_state = S1;

        // caso del abriendo
        S1: if (posicion == 2'b11) next_state = S2;

        // caso de abierto
        S2: if (button) next_state = S3;

        // caso del cerrando
        S3 : if (posicion == 2'b00) next_state = S0;
        default: next_state = S0;
    endcase
end

// Funcion de salida: 
always_comb begin
case (current_state)
    S0: begin
    cerrado = 1'b1;
    subir = 1'b0;
    abierto = 1'b0;
    bajar = 1'b0;
    end

    S1: begin
    cerrado = 1'b0;
    subir = 1'b1;
    abierto = 1'b0;
    bajar = 1'b0;
    end

    S2: begin
    cerrado = 1'b0;
    subir = 1'b0;
    abierto = 1'b1;
    bajar = 1'b0;
    end

    S3 : begin
    cerrado = 1'b0;
    subir = 1'b0;
    abierto = 1'b0;
    bajar = 1'b1;
    end

    default: begin
    cerrado = 1'b1;
    subir = 1'b0;
    abierto = 1'b0;
    bajar = 1'b0;
    end
endcase
end

endmodule

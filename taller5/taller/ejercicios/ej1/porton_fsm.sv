module porton_fsm (
    input  logic clk,
    input  logic rst,
    input  logic button,
    output logic cerrado,
    output logic abriendo,
    output logic abierto,
    output logic cerrando
);
  

  

  typedef enum logic [1:0] {
    S0, S1, S2, S3
  } state;

  state current_state, next_state;

  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      current_state <= S0;
    else 
      current_state <= next_state;
  end

  // 
  always_comb begin
    next_state = current_state;

    case (current_state)
      S0: if (button) next_state = S1;

      S1: next_state = S2;

      S2: if (button) next_state = S3;

      S3 : next_state = S0;
      default: next_state = S0;
    endcase
  end

  // Funcion de salida: 
  always_comb begin
    case (current_state)
      S0: begin
        cerrado = 1'b1;
        abriendo = 1'b0;
        abierto = 1'b0;
        cerrando = 1'b0;
      end

      S1: begin
        cerrado = 1'b0;
        abriendo = 1'b1;
        abierto = 1'b0;
        cerrando = 1'b0;
      end

      S2: begin
        cerrado = 1'b0;
        abriendo = 1'b0;
        abierto = 1'b1;
        cerrando = 1'b0;
      end

      S3 : begin
        cerrado = 1'b0;
        abriendo = 1'b0;
        abierto = 1'b0;
        cerrando = 1'b1;
      end

      default: begin
        cerrado = 1'b1;
        abriendo = 1'b0;
        abierto = 1'b0;
        cerrando = 1'b0;
      end
    endcase
  end
endmodule

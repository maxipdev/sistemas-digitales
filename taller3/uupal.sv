module uupal (
    input  logic       clk,
    input  logic       rst,
    input  logic [3:0] force_in,
    input  logic       force_en,
    input  logic       we0,
    input  logic       we1,
    input  logic       we2,
    input  logic       we3,
    input  logic [1:0] src_a,
    input  logic [1:0] src_b,
    input  logic       load_op_a,
    input  logic       load_op_b,
    input  logic [1:0] op,
    output logic [3:0] r0,
    output logic [3:0] r1,
    output logic [3:0] r2,
    output logic [3:0] r3,
    output logic [3:0] operand_a,
    output logic [3:0] operand_b,
    output logic [3:0] and_value,
    output logic [3:0] or_value,
    output logic [3:0] result
);
  // Completar de manera estructural:
  // 1. mux src_a -> bus de lectura A; mux src_b -> bus de lectura B;
  // 2. registros operand_a y operand_b (load_op_a / load_op_b);
  // 3. AND y OR de 4 bits e instancias sumador_4b y restador_4b;
  // 4. mux op -> result;
  // 5. mux force_en: force_in vs result -> bus de escritura;
  // 6. cuatro registro_4b (r0..r3) con we0..we3.;

  logic [3:0] bus;
  logic [3:0] res_suma, res_resta;
  logic valor1, valor2;


  assign bus = force_en ? force_in : result;

  //  elegir el registro para cada src
  always_comb begin
    case (src_a)
      2'b00 : operand_a = r0;
      2'b01 : operand_a = r1;
      2'b10 : operand_a = r2;
      2'b11 : operand_a = r3;
    endcase;    
  end

  always_comb begin
    case (src_b)
      2'b00 : operand_b = r0;
      2'b01 : operand_b = r1;
      2'b10 : operand_b = r2;
      2'b11 : operand_b = r3;
    endcase;
  end


  // operaciones

  sumador_4b sum (
    .a(operand_a),
    .b(operand_b),
    .cin(1'b0),
    .sum(res_suma),
    .cout(valor1)
  );

  restador_4b restador (
    .a(operand_a),
    .b(operand_b),
    .bin(1'b0),
    .diff(res_resta),
    .bout(valor2)
  );

  assign and_value = operand_a & operand_b;
  assign or_value = operand_a | operand_b;

  // Registros 
  registro_4b Reg0 (
    .clk(clk),
    .rst(rst),
    .we(we0),
    .din(bus),
    .q(r0)
  );

  registro_4b Reg1 (
    .clk(clk),
    .rst(rst),
    .we(we1),
    .din(bus),
    .q(r1)
  );

  registro_4b Reg2 (
    .clk(clk),
    .rst(rst),
    .we(we2),
    .din(bus),
    .q(r2)
  );

  registro_4b Reg3 (
    .clk(clk),
    .rst(rst),
    .we(we3),
    .din(bus),
    .q(r3)
  );

  always_comb begin 

    case (op) 
      2'b00 : result = and_value;
      2'b01 : result = or_value;
      2'b10 : result = res_suma;
      2'b11 : result = res_resta;
    endcase;
  end 

endmodule

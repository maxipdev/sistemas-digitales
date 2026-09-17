module compuerta_and_4b (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [3:0] result
);
  assign result = a & b;
endmodule

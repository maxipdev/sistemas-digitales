module compuerta_or_4b (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [3:0] result
);
  assign result = a | b;
endmodule

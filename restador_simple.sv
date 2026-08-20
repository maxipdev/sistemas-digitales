module restador_simple (
    input  logic a,
    input  logic b,
    output logic diff,
    output logic bout
);
  
  assign diff = (a & (~b)) | (~a & b);
  assign bout = ~a & b;
  
endmodule

module restador_completo(
    input logic a, input logic b, input logic bin,
    output logic diff, output logic bout
);
  logic diff_ab, borrow_ab, borrow_bin;
  restador_simple r0 (
    .a(a), 
    .b(b),   
    .diff(diff_ab), 
    .bout(borrow_ab)
  );
  
  restador_simple r1 (
    .a(diff_ab), 
    .b(bin), 
    .diff(diff), 
    .bout(borrow_bin)
  );
  assign bout = borrow_ab | borrow_bin;
endmodule


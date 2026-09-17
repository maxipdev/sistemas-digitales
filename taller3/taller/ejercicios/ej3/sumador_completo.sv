module sumador_completo(
    input logic a, input logic b, input logic cin,
    output logic sum, output logic cout
);
  logic sum_ab, carry_ab, carry_cin;
  sumador_simple s0 (
    .a(a), 
    .b(b),   
    .sum(sum_ab), 
    .cout(carry_ab)
  );
  
  sumador_simple s1 (
    .a(sum_ab), 
    .b(cin), 
    .sum(sum), 
    .cout(carry_cin)
  );
  assign cout = carry_ab | carry_cin;
endmodule


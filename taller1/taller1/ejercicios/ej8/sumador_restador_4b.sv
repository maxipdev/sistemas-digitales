module sumador_restador_4b (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       ctrl,
    output logic [3:0] y,
    output logic       cout
);
  logic [3:0] sum, diff;
  logic       add_cout, bout;
  // instanciar sumador_4b y restador_4b; elegir con ctrl
endmodule

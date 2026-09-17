module shifter_4b (
    input logic [3:0] dato,
    input logic aritmetico,
    output logic [3:0] resultado,
    output logic negativo, zero
);
  // COMPLETAR: desplazar dato una posición a derecha según aritmetico.
  // Reutilizar negativo_4b y zero_4b sobre resultado.
  // En modo lógico, ambos flags deben valer 0.

  // el aritmetico si es 1, me dice si tengo qu ehacer un desplazamiento hacia la derecha teneindo en cuenta que es un bit CON SIGNO
  // si es cero -> entonces es un bit sin signo y se hace un desplzamiento logico -> aca solo agrega el cero
  // en el aritmetico, tengo que tener en cuenta si es negativo o no

  // tengo qu emirar si es negativo, entonces tengoq ue extenderlo con 1 para perservar el signo
  // sabemos que hay 4 bits, entocnes tengo que desplazarlo de a uno:
  assign resultado[3] = aritmetico ? dato[3] : 1'b0;
  assign resultado[2] = dato[3];
  assign resultado[1] = dato[2];
  assign resultado[0] = dato[1];

  //guardo lso resultados en un bus y luegho decido que se termina usando
  logic bus_negativo, bus_zero;

  negativo_4b negativo_4b (
    .dato    (resultado),
    .negativo(bus_negativo)
  );

  zero_4b zero_4b (
    .dato(resultado),
    .zero(bus_zero)
  );

  // ahora decido que dato sale del bus
  assign negativo = aritmetico ? bus_negativo : 1'b0;
  assign zero = aritmetico ? bus_zero : 1'b0;

  
endmodule

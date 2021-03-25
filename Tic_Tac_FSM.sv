`default_nettype none

module dFlipFlop
  (output logic q,
   input logic d, clock, reset);

  always_ff @(posedge clock)
    if (reset == 1)
      q <= 0;
    else
      q <= d;

endmodule: dFlipFlop

module myExplicitFSM
  (output logic [3:0] cMove,
   output logic       win,
   output logic [3:0] q,
   input  logic [3:0] hMove,
   input  logic       clock, reset);

  logic [3:0] d;
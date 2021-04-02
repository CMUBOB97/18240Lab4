`default_nettype none

module chipInterface
  (input logic [3:0] KEY,
   input logic [17:0] SW,
   output logic [6:0] HEX5,
   output logic [17:0] LEDR,
   output logic [7:0] LEDG);
  
  logic [3:0] cMove;
  
  assign LEDG = 8'b00000000;
  
  myAbstractFSM   dut (.cMove(cMove), .win(LEDR[0]),
                        .hMove({SW[14], SW[15], SW[16], SW[17]}), .clock(KEY[0]),
                        .reset(SW[10]));
  BCDtoSevenSegment comp (.bcd(cMove), .segment(HEX5));

endmodule: chipInterface
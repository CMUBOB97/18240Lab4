`default_nettype none

module chipInterface_big
  (input logic [7:0] KEY,
   input logic [17:0] SW,
   input logic CLOCK_50,
   output logic [6:0] HEX5, HEX6, HEX7, HEX8, HEX9,
   output logic [6:0] HEX3, HEX2, HEX1, HEX0,
   output logic [17:0] LEDR,
   output logic [7:0] LEDG);
  
  logic [3:0] cMove;
  logic [15:0] cMove_all, hMove_all;
  
  assign LEDG = 8'b00000000;
  
  myBigFSM   dut (.cMove(cMove), .win(LEDR[9]), .hMove_all(hMove_all),
                  .cMove_all(cMove_all), .enter_L(KEY[4]), .new_game_L(KEY[7]),
                  .hMove({SW[14], SW[15], SW[16], SW[17]}), .clock(CLOCK_50),
                  .reset(SW[10]));
                  
  BCDtoSevenSegment_sp comp (.bcd(cMove), .segment(HEX5));
  BCDtoSevenSegment_sp dut1 (.bcd(hMove_all[3:0]), .segment(HEX6));
  BCDtoSevenSegment_sp dut2 (.bcd(hMove_all[7:4]), .segment(HEX7));
  BCDtoSevenSegment_sp dut3 (.bcd(hMove_all[11:8]), .segment(HEX8));
  BCDtoSevenSegment_sp dut4 (.bcd(hMove_all[15:12]), .segment(HEX9));
  BCDtoSevenSegment_sp dut5 (.bcd(cMove_all[3:0]), .segment(HEX0));
  BCDtoSevenSegment_sp dut6 (.bcd(cMove_all[7:4]), .segment(HEX1));
  BCDtoSevenSegment_sp dut7 (.bcd(cMove_all[11:8]), .segment(HEX2));
  BCDtoSevenSegment_sp dut8 (.bcd(cMove_all[15:12]), .segment(HEX3));
  
  always_comb begin
    case (LEDR[9])
      1'b1: LEDR[8:0] = 9'b1_1111_1111;
      1'b0: LEDR[8:0] = 9'b0;
    endcase
  end

endmodule: chipInterface_big
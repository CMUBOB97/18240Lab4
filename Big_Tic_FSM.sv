`default_nettype none

module myBigFSM
  (output logic [3:0] cMove,
   output logic win,
   output logic [15:0] hMove_all, cMove_all,
   input logic [3:0] hMove,
   input logic enter_L, new_game_L,
   input logic clock, reset);
  
  // synchronize inputs
  logic [3:0] hMove_sync_1, hMove_sync_2;
  logic enter_sync_1, enter_sync_2;
  logic new_game_sync_1, new_game_sync_2;

  always_ff @(posedge clock) begin
    enter_sync_1 <= ~enter_L;
    new_game_sync_1 <= ~new_game_L;
    hMove_sync_1 <= hMove;
  end

  always_ff @(posedge clock) begin
    enter_sync_2 <= enter_sync_1;
    new_game_sync_2 <= new_game_sync_1;
    hMove_sync_2 <= hMove_sync_1;
  end

  // mark states
  enum logic [4:0] {Start, Inter1_hMove_6,
                    cMove_1, Inter2_hMove_2, Inter2_hMove_3,
                    Inter2_hMove_4, Inter2_hMove_7, Inter2_hMove_8,
                    Inter2_hMove_9, end_game1_hMove_2, end_game1_hMove_3,
                    end_game1_hMove_4, end_game1_hMove_7, end_game1_hMove_8,
                    cMove_3, Inter3_hMove_7, Inter3_hMove_2,
                    Inter3_hMove_4, Inter3_hMove_8, end_game2_hMove_7,
                    end_game2_hMove_2, end_game2_hMove_4, end_game2_hMove_8,
                    Inter_new_game} currState, nextState;

  always_comb begin
    unique case (currState)
      Start: begin
        if (hMove_sync_2 == 4'd6 && enter_sync_2)
          nextState = Inter1_hMove_6;
        else
          nextState = Start;
      end
      
      Inter1_hMove_6: begin
        if (enter_sync_2 == 0)
          nextState = cMove_1;
        else
          nextState = Inter1_hMove_6;
		end
      
      cMove_1: begin
        if (hMove_sync_2 == 4'd2 && enter_sync_2)
          nextState = Inter2_hMove_2;
        else if (hMove_sync_2 == 4'd3 && enter_sync_2)
          nextState = Inter2_hMove_3;
        else if (hMove_sync_2 == 4'd4 && enter_sync_2)
          nextState = Inter2_hMove_4;
        else if (hMove_sync_2 == 4'd7 && enter_sync_2)
          nextState = Inter2_hMove_7;
        else if (hMove_sync_2 == 4'd8 && enter_sync_2)
          nextState = Inter2_hMove_8;
        else if (hMove_sync_2 == 4'd9 && enter_sync_2)
          nextState = Inter2_hMove_9;
        else
          nextState = cMove_1;
      end

      Inter2_hMove_2: begin
        if (enter_sync_2 == 0)
          nextState = end_game1_hMove_2;
        else
          nextState = Inter2_hMove_2;
      end

      Inter2_hMove_3: begin
        if (enter_sync_2 == 0)
          nextState = end_game1_hMove_3;
        else
          nextState = Inter2_hMove_3;
      end

      Inter2_hMove_4: begin
        if (enter_sync_2 == 0)
          nextState = end_game1_hMove_4;
        else
          nextState = Inter2_hMove_4;
      end

      Inter2_hMove_7: begin
        if (enter_sync_2 == 0)
          nextState = end_game1_hMove_7;
        else
          nextState = Inter2_hMove_7;
      end

      Inter2_hMove_8: begin
        if (enter_sync_2 == 0)
          nextState = end_game1_hMove_8;
        else
          nextState = Inter2_hMove_8;
      end

      Inter2_hMove_9: begin
        if (enter_sync_2 == 0)
          nextState = cMove_3;
        else
          nextState = Inter2_hMove_9;
      end

      cMove_3: begin
        if (hMove_sync_2 == 4'd7 && enter_sync_2)
          nextState = Inter3_hMove_7;
        else if (hMove_sync_2 == 4'd2 && enter_sync_2)
          nextState = Inter3_hMove_2;
        else if (hMove_sync_2 == 4'd4 && enter_sync_2)
          nextState = Inter3_hMove_4;
        else if (hMove_sync_2 == 4'd8 && enter_sync_2)
          nextState = Inter3_hMove_8;
        else
          nextState = cMove_3;
      end

      Inter3_hMove_7: begin
        if (enter_sync_2 == 0)
          nextState = end_game2_hMove_7;
        else
          nextState = Inter3_hMove_7;
      end

      Inter3_hMove_2: begin
        if (enter_sync_2 == 0)
          nextState = end_game2_hMove_2;
        else
          nextState = Inter3_hMove_2;
      end

      Inter3_hMove_4: begin
        if (enter_sync_2 == 0)
          nextState = end_game2_hMove_4;
        else
          nextState = Inter3_hMove_4;
      end

      Inter3_hMove_8: begin
        if (enter_sync_2 == 0)
          nextState = end_game2_hMove_8;
        else
          nextState = Inter3_hMove_8;
      end

      end_game1_hMove_2: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game1_hMove_2;
      end

      end_game1_hMove_3: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game1_hMove_3;
      end
      
      end_game1_hMove_4: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game1_hMove_4;
      end

      end_game1_hMove_7: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game1_hMove_7;
      end

      end_game1_hMove_8: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game1_hMove_8;
      end

      end_game2_hMove_2: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game2_hMove_2;
      end

      end_game2_hMove_4: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game2_hMove_4;
      end

      end_game2_hMove_7: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game2_hMove_7;
      end

      end_game2_hMove_8: begin
        if (new_game_sync_2 == 1)
          nextState = Inter_new_game;
        else
          nextState = end_game2_hMove_8;
      end

      Inter_new_game: begin
        if (new_game_sync_2 == 0 && enter_sync_2 == 0)
          nextState = Start;
        else
          nextState = Inter_new_game;
      end
    endcase
  end

  // mark outputs
  always_comb begin
    unique case (currState)
      Start: begin
        cMove = 4'd5;
        hMove_all = 16'd0;
        cMove_all = 16'd5;
        win = 0;
      end

      Inter1_hMove_6: begin
        cMove = 4'd0;
        hMove_all = 16'd6;
        cMove_all = 16'd5;
        win = 0;
      end

      cMove_1: begin
        cMove = 4'd1;
        hMove_all = 16'd6;
        cMove_all = 16'h51;
        win = 0;
      end

      Inter2_hMove_2: begin
        cMove = 4'd0;
        hMove_all = 16'h62;
        cMove_all = 16'h51;
        win = 0;
      end

      Inter2_hMove_3: begin
        cMove = 4'd0;
        hMove_all = 16'h63;
        cMove_all = 16'h51;
        win = 0;
      end

      Inter2_hMove_4: begin
        cMove = 4'd0;
        hMove_all = 16'h64;
        cMove_all = 16'h51;
        win = 0;
      end

      Inter2_hMove_7: begin
        cMove = 4'd0;
        hMove_all = 16'h76;
        cMove_all = 16'h51;
        win = 0;
      end

      Inter2_hMove_8: begin
        cMove = 4'd0;
        hMove_all = 16'h86;
        cMove_all = 16'h51;
        win = 0;
      end

      Inter2_hMove_9: begin
        cMove = 4'd0;
        hMove_all = 16'h96;
        cMove_all = 16'h51;
        win = 0;
      end

      cMove_3: begin
        cMove = 4'd3;
        hMove_all = 16'h96;
        cMove_all = 16'h531;
        win = 0;
      end

      Inter3_hMove_2: begin
        cMove = 4'd0;
        hMove_all = 16'h962;
        cMove_all = 16'h531;
        win = 0;
      end

      Inter3_hMove_4: begin
        cMove = 4'd0;
        hMove_all = 16'h964;
        cMove_all = 16'h531;
        win = 0;
      end

      Inter3_hMove_7: begin
        cMove = 4'd0;
        hMove_all = 16'h976;
        cMove_all = 16'h531;
        win = 0;
      end

      Inter3_hMove_8: begin
        cMove = 4'd0;
        hMove_all = 16'h986;
        cMove_all = 16'h531;
        win = 0;
      end

      end_game1_hMove_2: begin
        cMove = 4'd9;
        hMove_all = 16'h62;
        cMove_all = 16'h951;
        win = 1;
      end

      end_game1_hMove_3: begin
        cMove = 4'd9;
        hMove_all = 16'h63;
        cMove_all = 16'h951;
        win = 1;
      end

      end_game1_hMove_4: begin
        cMove = 4'd9;
        hMove_all = 16'h64;
        cMove_all = 16'h951;
        win = 1;
      end

      end_game1_hMove_7: begin
        cMove = 4'd9;
        hMove_all = 16'h76;
        cMove_all = 16'h951;
        win = 1;
      end

      end_game1_hMove_8: begin
        cMove = 4'd9;
        hMove_all = 16'h86;
        cMove_all = 16'h951;
        win = 1;
      end

      end_game2_hMove_2: begin
        cMove = 4'd7;
        hMove_all = 16'h962;
        cMove_all = 16'h7531;
        win = 1;
      end

      end_game2_hMove_4: begin
        cMove = 4'd7;
        hMove_all = 16'h964;
        cMove_all = 16'h7531;
        win = 1;
      end

      end_game2_hMove_7: begin
        cMove = 4'd2;
        hMove_all = 16'h976;
        cMove_all = 16'h5321;
        win = 1;
      end

      end_game2_hMove_8: begin
        cMove = 4'd2;
        hMove_all = 16'h986;
        cMove_all = 16'h5321;
        win = 1;
      end

      Inter_new_game: begin
        cMove = 4'd0;
        hMove_all = 16'd0;
        cMove_all = 16'd0;
        win = 0;
      end
    endcase
  end

  always_ff @(posedge clock)
    if (reset)
      currState = Start;
    else
      currState <= nextState;
    
endmodule: myBigFSM

module BCDtoSevenSegment_sp
    (input logic [3:0] bcd,
     output logic [6:0] segment);

    always_comb
        case (bcd)
            4'b0001: segment = 7'b111_1001;
            4'b0010: segment = 7'b010_0100;
            4'b0011: segment = 7'b011_0000;
            4'b0100: segment = 7'b001_1001;
            4'b0101: segment = 7'b001_0010;
            4'b0110: segment = 7'b000_0010;
            4'b0111: segment = 7'b111_1000;
            4'b1000: segment = 7'b000_0000;
            4'b1001: segment = 7'b001_0000;
            default: segment = 7'b111_1111;
        endcase

endmodule: BCDtoSevenSegment_sp
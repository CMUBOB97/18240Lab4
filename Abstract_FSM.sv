`default_nettype none

module myAbstractFSM
  (output logic [3:0] cMove,
   output logic win,
   input logic [3:0] hMove,
   input logic clock, reset);

  enum logic [2:0] {S0_5, S1_1, S2_9, S3_3, S4_7, S5_2} currState, nextState;
  // Increase bitwidth if you need more than eight states
  // Don't specify state encoding values
  // Use sensible state names
  // Next state logic is defined here. You are basically
  // transcribing the "next-state" column of the state transition
  // table into a SystemVerilog case statement.
  always_comb begin
    case (currState)
      S0_5: begin
        // Assign a value to nextState based on input
        // This is an example, not a solution to part of the lab
        nextState = (hMove == 4'd6) ? S1_1 : S0_5;
      end
      S1_1: begin
        if (hMove == 4'd9)
          nextState = S3_3;
        else if (hMove == 4'd2 || hMove == 4'd3 || hMove == 4'd4
                 || hMove == 4'd7 || hMove == 4'd8)
          nextState = S2_9;
        else
          nextState = S1_1;
      end
      S2_9: nextState = S2_9;
      S3_3: begin
        if (hMove == 4'd2)
          nextState = S4_7;
        else if (hMove == 4'd4 || hMove == 4'd7 || hMove == 4'd8)
          nextState = S5_2;
        else
          nextState = S3_3;
      end
      S4_7: nextState = S4_7;
      S5_2: nextState = S5_2;
      default: nextState = S0_5;
    endcase
  end

  // Output logic defined here. You are basically transcribing
  // the output column of the state transition table into a
  // SystemVerilog case statement.
  // Remember, if this is a Moore machine, this logic should only
  // depend on the current state. Mealy also involves inputs.
  always_comb begin
    unique case (currState)
      S0_5: begin
        win = 1'b0;
        cMove = (nextState == S1_1) ? 4'd1 : 4'd5;
      end 
      S1_1: begin
        win = 1'b0;
        if (nextState == S2_9)
          cMove = 4'd9;
        else if (nextState == S3_3)
          cMove = 4'd3;
        else
          cMove = 4'd1;
      end
      S2_9: begin
        win = 1'b1;
        cMove = 4'd9;
      end
      S3_3: begin
        win = 1'b0;
        if (nextState == S4_7)
          cMove = 4'd7;
        else if (nextState == S5_2)
          cMove = 4'd2;
        else
          cMove = 4'd3;
      end
      S4_7: begin
        win = 1'b1;
        cMove = 4'd7;
      end
      S5_2: begin
        win = 1'b1;
        cMove = 4'd2;
      end
    endcase
  end

  // Synchronous state update described here as an always block.
  // In essence, these are your flip flops that will hold the state
  // This doesn't do anything interesting except to capture the new
  // state value on each clock edge. Also, synchronous reset.
  always_ff @(posedge clock)
    if (reset)
      currState <= S0_5; // or whatever the reset state is
    else
      currState <= nextState;
 
endmodule: myAbstractFSM
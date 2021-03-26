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

  dFlipFlop  ff0 (.d(d[0]), .q(q[0]), .*);
  dFlipFlop  ff1 (.d(d[1]), .q(q[1]), .*);
  dFlipFlop  ff2 (.d(d[2]), .q(q[2]), .*);
  dFlipFlop  ff3 (.d(d[3]), .q(q[3]), .*);

  assign d[0] = ~((~q[3] & ~q[2] & q[1] & q[0] & ~hMove[3] & hMove[2] & hMove[1] & hMove[0]) |
                (~q[3] & ~q[2] & q[1] & q[0] & ~hMove[3] & hMove[2] & ~hMove[1] & ~hMove[0]) |
                (~q[3] & ~q[2] & q[1] & q[0] & hMove[3] & ~hMove[2] & ~hMove[1] & ~hMove[0]) |
                (~q[3] & ~q[2] & q[1] & ~q[0]));
    
  assign d[1] = (~q[3] & ~q[2] & ~q[1] & q[0] & hMove[3] & ~hMove[2] & ~hMove[1] & hMove[0]) |
                (~q[3] & ~q[2] & q[1] & q[0]) |
                (~q[3] & q[2] & q[1] & q[0]) |
                (~q[3] & ~q[2] & q[1] & ~q[0]);
              
  assign d[2] = (~q[3] & q[2] & ~q[1] & q[0] & hMove[3]) |
                (~q[3] & q[2] & ~q[1] & q[0] & ~hMove[2]) |
                (~q[3] & q[2] & ~q[1] & q[0] & ~hMove[1]) |
                (~q[3] & q[2] & ~q[1] & q[0] & hMove[0]) |
                (~q[3] & ~q[2] & q[1] & q[0] & ~hMove[3] & ~hMove[2] & hMove[1] & ~hMove[0]) |
                (~q[3] & q[2] & q[1] & q[0]);
        
  assign d[3] = (~q[3] & ~q[2] & ~q[1] & q[0] & ~hMove[3] & ~hMove[2] & hMove[1]) |
                (~q[3] & ~q[2] & ~q[1] & q[0] & ~hMove[3] & hMove[2] & ~hMove[1] & ~hMove[0]) |
                (~q[3] & ~q[2] & ~q[1] & q[0] & hMove[3] & ~hMove[2] & ~hMove[1] & ~hMove[0]) |
                (~q[3] & ~q[2] & ~q[1] & q[0] & ~hMove[3] & hMove[2] & hMove[1] & hMove[0]) |
                (q[3] & ~q[2] & ~q[1] & q[0]);

  assign cMove = d;
  assign win = (~q[3] & ~q[2] & q[1] & ~q[0]) | 
               (~q[3] & q[2] & q[1] & q[0]) |
               (q[3] & ~q[2] & ~q[1] & q[0]);

endmodule: myExplicitFSM

module myFSM_test
  (input logic [3:0] cMove,
   input logic win,
   input logic [3:0] q,
   output logic [3:0] hMove,
   output logic clock, reset);

  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  initial begin
    $monitor($time,, "state=%b, cMove=%d, hMove=%d, win=%b",
             q, cMove, hMove, win);
    
    hMove <= 4'b0000;
    reset <= 1'b1;

    // reset
    @(posedge clock);
    reset <= 1'b0;

    hMove <= 4'b0110;
    @(posedge clock);
    hMove <= 4'b1001;
    @(posedge clock);
    hMove <= 4'b0100;

    #1 if (~win)
      $display("Oops, should be winning at cycle 3");

    @(posedge clock);
    #1 $finish;
  end 

endmodule: myFSM_test
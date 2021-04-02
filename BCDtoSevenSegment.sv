`default_nettype none

module BCDtoSevenSegment
    (input logic [3:0] bcd,
     output logic [6:0] segment);

    always_comb
        case (bcd)
            4'b0000: segment = 7'b100_0000;
            4'b0001: segment = 7'b111_1001;
            4'b0010: segment = 7'b010_0100;
            4'b0011: segment = 7'b011_0000;
            4'b0100: segment = 7'b001_1001;
            4'b0101: segment = 7'b001_0010;
            4'b0110: segment = 7'b000_0010;
            4'b0111: segment = 7'b111_1000;
            4'b1000: segment = 7'b000_0000;
            4'b1001: segment = 7'b001_0000;
            4'b1010: segment = 7'b000_1000;
            4'b1011: segment = 7'b000_0011;
            4'b1100: segment = 7'b100_0110;
            4'b1101: segment = 7'b010_0001;
            4'b1110: segment = 7'b000_0110;
            4'b1111: segment = 7'b000_1110;
        endcase

endmodule: BCDtoSevenSegment

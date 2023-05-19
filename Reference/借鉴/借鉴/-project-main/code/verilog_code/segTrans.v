`timescale 1ns / 1ps

module segTrans(seg_in, seg_trans);
    input [63:0] seg_in;
    output [31:0] seg_trans;

    wire[7:0] seg_in1, seg_in2, seg_in3, seg_in4, seg_in5, seg_in6, seg_in7, seg_in8;
    reg[3:0] seg1 = 0, seg2 = 0, seg3 = 0, seg4 = 0, seg5 = 0, seg6 = 0, seg7 = 0, seg8 = 0;
    assign seg_in1 = seg_in[7:0];
    assign seg_in2 = seg_in[15:8];
    assign seg_in3 = seg_in[23:16];
    assign seg_in4 = seg_in[31:24];
    assign seg_in5 = seg_in[39:32];
    assign seg_in6 = seg_in[47:40];
    assign seg_in7 = seg_in[55:48];
    assign seg_in8 = seg_in[63:56];

    assign seg_trans = {seg8, seg7, seg6, seg5, seg4, seg3, seg2, seg1};
    always @* begin
        case(seg_in1)
            8'b11000000 : seg1 <= 4'b0000;   //  0
            8'b11111001 : seg1 <= 4'b0001;   //  1
            8'b10100100 : seg1 <= 4'b0010;   //  2
            8'b10110000 : seg1 <= 4'b0011;   //  3
            8'b10011001 : seg1 <= 4'b0100;   //  4
            8'b10010010 : seg1 <= 4'b0101;   //  5
            8'b10000010 : seg1 <= 4'b0110;   //  6
            8'b11111000 : seg1 <= 4'b0111;   //  7
            8'b10000000 : seg1 <= 4'b1000;   //  8
            8'b10010000 : seg1 <= 4'b1001;   //  9
            8'b10001000 : seg1 <= 4'b1010;   //  A
            8'b10000011 : seg1 <= 4'b1011;   //  b
            8'b11000110 : seg1 <= 4'b1100;   //  C
            8'b10100001 : seg1 <= 4'b1101;   //  d
            8'b10000110 : seg1 <= 4'b1110;   //  E
            8'b10001110 : seg1 <= 4'b1111;   //  F  
            default : seg1 <= 4'b0000;   //  0
        endcase
    end

    always @* begin
        case(seg_in2)
            8'b11000000 : seg2 <= 4'b0000;   //  0
            8'b11111001 : seg2 <= 4'b0001;   //  1
            8'b10100100 : seg2 <= 4'b0010;   //  2
            8'b10110000 : seg2 <= 4'b0011;   //  3
            8'b10011001 : seg2 <= 4'b0100;   //  4
            8'b10010010 : seg2 <= 4'b0101;   //  5
            8'b10000010 : seg2 <= 4'b0110;   //  6
            8'b11111000 : seg2 <= 4'b0111;   //  7
            8'b10000000 : seg2 <= 4'b1000;   //  8
            8'b10010000 : seg2 <= 4'b1001;   //  9
            8'b10001000 : seg2 <= 4'b1010;   //  A
            8'b10000011 : seg2 <= 4'b1011;   //  b
            8'b11000110 : seg2 <= 4'b1100;   //  C
            8'b10100001 : seg2 <= 4'b1101;   //  d
            8'b10000110 : seg2 <= 4'b1110;   //  E
            8'b10001110 : seg2 <= 4'b1111;   //  F  
            default : seg2 <= 4'b0000;
        endcase
    end
    always @* begin
        case(seg_in3)
            8'b11000000 : seg3 <= 4'b0000;   //  0
            8'b11111001 : seg3 <= 4'b0001;   //  1
            8'b10100100 : seg3 <= 4'b0010;   //  2
            8'b10110000 : seg3 <= 4'b0011;   //  3
            8'b10011001 : seg3 <= 4'b0100;   //  4
            8'b10010010 : seg3 <= 4'b0101;   //  5
            8'b10000010 : seg3 <= 4'b0110;   //  6
            8'b11111000 : seg3 <= 4'b0111;   //  7
            8'b10000000 : seg3 <= 4'b1000;   //  8
            8'b10010000 : seg3 <= 4'b1001;   //  9
            8'b10001000 : seg3 <= 4'b1010;   //  A
            8'b10000011 : seg3 <= 4'b1011;   //  b
            8'b11000110 : seg3 <= 4'b1100;   //  C
            8'b10100001 : seg3 <= 4'b1101;   //  d
            8'b10000110 : seg3 <= 4'b1110;   //  E
            8'b10001110 : seg3 <= 4'b1111;   //  F  
            default : seg3 <= 4'b0000;
        endcase
    end
    always @* begin
        case(seg_in4)
            8'b11000000 : seg4 <= 4'b0000;   //  0
            8'b11111001 : seg4 <= 4'b0001;   //  1
            8'b10100100 : seg4 <= 4'b0010;   //  2
            8'b10110000 : seg4 <= 4'b0011;   //  3
            8'b10011001 : seg4 <= 4'b0100;   //  4
            8'b10010010 : seg4 <= 4'b0101;   //  5
            8'b10000010 : seg4 <= 4'b0110;   //  6
            8'b11111000 : seg4 <= 4'b0111;   //  7
            8'b10000000 : seg4 <= 4'b1000;   //  8
            8'b10010000 : seg4 <= 4'b1001;   //  9
            8'b10001000 : seg4 <= 4'b1010;   //  A
            8'b10000011 : seg4 <= 4'b1011;   //  b
            8'b11000110 : seg4 <= 4'b1100;   //  C
            8'b10100001 : seg4 <= 4'b1101;   //  d
            8'b10000110 : seg4 <= 4'b1110;   //  E
            8'b10001110 : seg4 <= 4'b1111;   //  F  
            default : seg4 <= 4'b0000;
        endcase
    end
    always @* begin
        case(seg_in5)
            8'b11000000 : seg5 <= 4'b0000;   //  0
            8'b11111001 : seg5 <= 4'b0001;   //  1
            8'b10100100 : seg5 <= 4'b0010;   //  2
            8'b10110000 : seg5 <= 4'b0011;   //  3
            8'b10011001 : seg5 <= 4'b0100;   //  4
            8'b10010010 : seg5 <= 4'b0101;   //  5
            8'b10000010 : seg5 <= 4'b0110;   //  6
            8'b11111000 : seg5 <= 4'b0111;   //  7
            8'b10000000 : seg5 <= 4'b1000;   //  8
            8'b10010000 : seg5 <= 4'b1001;   //  9
            8'b10001000 : seg5 <= 4'b1010;   //  A
            8'b10000011 : seg5 <= 4'b1011;   //  b
            8'b11000110 : seg5 <= 4'b1100;   //  C
            8'b10100001 : seg5 <= 4'b1101;   //  d
            8'b10000110 : seg5 <= 4'b1110;   //  E
            8'b10001110 : seg5 <= 4'b1111;   //  F  
            default : seg5 <= 4'b0000;
        endcase
    end
    always @* begin
        case(seg_in6)
            8'b11000000 : seg6 <= 4'b0000;   //  0
            8'b11111001 : seg6 <= 4'b0001;   //  1
            8'b10100100 : seg6 <= 4'b0010;   //  2
            8'b10110000 : seg6 <= 4'b0011;   //  3
            8'b10011001 : seg6 <= 4'b0100;   //  4
            8'b10010010 : seg6 <= 4'b0101;   //  5
            8'b10000010 : seg6 <= 4'b0110;   //  6
            8'b11111000 : seg6 <= 4'b0111;   //  7
            8'b10000000 : seg6 <= 4'b1000;   //  8
            8'b10010000 : seg6 <= 4'b1001;   //  9
            8'b10001000 : seg6 <= 4'b1010;   //  A
            8'b10000011 : seg6 <= 4'b1011;   //  b
            8'b11000110 : seg6 <= 4'b1100;   //  C
            8'b10100001 : seg6 <= 4'b1101;   //  d
            8'b10000110 : seg6 <= 4'b1110;   //  E
            8'b10001110 : seg6 <= 4'b1111;   //  F  
            default : seg6 <= 4'b0000;
        endcase
    end
    always @* begin
        case(seg_in7)
            8'b11000000 : seg7 <= 4'b0000;   //  0
            8'b11111001 : seg7 <= 4'b0001;   //  1
            8'b10100100 : seg7 <= 4'b0010;   //  2
            8'b10110000 : seg7 <= 4'b0011;   //  3
            8'b10011001 : seg7 <= 4'b0100;   //  4
            8'b10010010 : seg7 <= 4'b0101;   //  5
            8'b10000010 : seg7 <= 4'b0110;   //  6
            8'b11111000 : seg7 <= 4'b0111;   //  7
            8'b10000000 : seg7 <= 4'b1000;   //  8
            8'b10010000 : seg7 <= 4'b1001;   //  9
            8'b10001000 : seg7 <= 4'b1010;   //  A
            8'b10000011 : seg7 <= 4'b1011;   //  b
            8'b11000110 : seg7 <= 4'b1100;   //  C
            8'b10100001 : seg7 <= 4'b1101;   //  d
            8'b10000110 : seg7 <= 4'b1110;   //  E
            8'b10001110 : seg7 <= 4'b1111;   //  F  
            default : seg7 <= 4'b0000;
        endcase
    end
    always @* begin
        case(seg_in8)
            8'b11000000 : seg8 <= 4'b0000;   //  0
            8'b11111001 : seg8 <= 4'b0001;   //  1
            8'b10100100 : seg8 <= 4'b0010;   //  2
            8'b10110000 : seg8 <= 4'b0011;   //  3
            8'b10011001 : seg8 <= 4'b0100;   //  4
            8'b10010010 : seg8 <= 4'b0101;   //  5
            8'b10000010 : seg8 <= 4'b0110;   //  6
            8'b11111000 : seg8 <= 4'b0111;   //  7
            8'b10000000 : seg8 <= 4'b1000;   //  8
            8'b10010000 : seg8 <= 4'b1001;   //  9
            8'b10001000 : seg8 <= 4'b1010;   //  A
            8'b10000011 : seg8 <= 4'b1011;   //  b
            8'b11000110 : seg8 <= 4'b1100;   //  C
            8'b10100001 : seg8 <= 4'b1101;   //  d
            8'b10000110 : seg8 <= 4'b1110;   //  E
            8'b10001110 : seg8 <= 4'b1111;   //  F  
            default : seg8 <= 4'b0000;
        endcase
    end
endmodule


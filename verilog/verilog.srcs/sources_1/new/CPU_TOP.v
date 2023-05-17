`timescale 1ns/1ps


module CPU_TOP (
    reset,
    clk,
    switch2N4,
    led2N4,
    seg_location,
    seg_digit
    );

    input reset;
    input clk;
    





    // Ifetch
    wire [31:0] Instruction;
    wire Zero;
    wire [31:0] Read_data_1;
    wire Branch, nBranch, Jmp, Jal, Jr;

    // executs
    wire [31:0] Read_data_2;
    wire [31:0] Imme_extend;
    wire [31:0] PC_plus_4;










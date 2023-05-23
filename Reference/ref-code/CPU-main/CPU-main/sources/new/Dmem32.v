`timescale 1ns / 1ps

module dmemory32(clock,memWrite,address,writeData,readData );
    input clock, memWrite;  //memWrite ????controller???1'b1???????data-memory??��????
    input [31:0] address;   //address ????????��
    input [31:0] writeData; //writeData ????data-memory??��???????
    output[31:0] readData;  //writeData ????data-memory?��?????????
    wire clk;
    
RAM ram(
    .clka(clk),             //input wire clka
    .wea(memWrite),         //input wire [0:0] wea
    .addra(address[15:2]),        //input wire [31:0] addra
    .dina(writeData),       //input wire [31:0] dina
    .douta(readData)        //output wire [31:0] douta
);
/*The clock is from CPU-TOP, suppose its one edge has been used at the upstream module
 of data memory, such as Ifetch and Data-Memory DO NOT use the same edge as other module*/
    assign clk = ~clock;
endmodule
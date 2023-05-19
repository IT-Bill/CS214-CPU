`timescale 1ns / 1ps

module dmemory32(clock,memWrite,address,writeData,readData );
    input clock, memWrite;  //memWrite 来自controller，为1'b1时表示要对data-memory做写操作
    input [31:0] address;   //address 以字节为单位
    input [31:0] writeData; //writeData ：向data-memory中写入的数据
    output[31:0] readData;  //writeData ：从data-memory中读出的数据
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
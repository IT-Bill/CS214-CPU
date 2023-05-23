`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/22 17:09:34
// Design Name: 
// Module Name: dmem32Tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dmem32Tb(

    );
    reg clock = 1'b0;
    reg memWrite = 1'b0;
    reg [31:0] addr = 32'd32;
    reg [31:0] writeData = 32'ha000_0000;
    wire [31:0] readData;
    // dememory32 使用到64KB的RAM ip核，读写位宽为32bit。
    // clock, memWrite;  memWrite 来自controller，为1'b1时表示要对data-memory做写操作
    // [31:0] address;   address 以字节为单位
    // [31:0] writeData; writeData ：向data-memory中写入的数据
    // [31:0] readData;  writeData ：从data-memory中读出的数据

    dmemory32 uram(.clock(clock),.memWrite(memWrite),.address(addr),.writeData(writeData),.readData(readData));
    always #50 clock = ~clock;
    integer i=0;
    initial begin    //read word 8~12 , addr: 32~48 ,write word17,addr:17*4=68; The data is written to the 17th word in memory.
        // Verify that the Dmemory is reading data correctly
        #100 i=i+1; //Wait 100 clock cycles
        addr= 32'd32;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);

        #100 i=i+1;
        addr= 32'd36;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);
                
        #100 i=i+1;
        addr= 32'd40;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);
        #100 i=i+1;

        addr= 32'd44;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);
        
        #100 i=i+1;
        addr= 32'd48;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);

        // Verify that Dmemory can write data correctly.
        #120 i=i+1;
        addr= 32'd68;
        memWrite = 1'b1; //Set memWrite = 1 indicates that a write operation is to take place.
        writeData = 32'h1000_0000;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        //The "dmemory32" receives a clock pulse and reads the value of "memWrite" to determine whether a write operation is required at that time. 
        //Meanwhile, the module decodes the address "addr" and stores the written data "writeData" in the memory.
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);
        #100 i=i+1; 
        memWrite = 1'b0; //Set memWrite= 0 indicates that the write operation has finished.
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);   
 
        //Different data is written to the same address
        #120 i=i+1;
        addr= 32'd68;
        memWrite = 1'b1;
        writeData = 32'h1234_5678;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);
        #100 i=i+1; 
        memWrite = 1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData); 

        #120 i=i+1;
        addr= 32'd128;
        memWrite = 1'b1;
        writeData = 32'hABCD_EF01;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);
        #100 i=i+1; 
        memWrite = 1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",%d %d %d %d ",memWrite,addr,writeData,readData);  

      #100 $finish;      
    end
    
endmodule

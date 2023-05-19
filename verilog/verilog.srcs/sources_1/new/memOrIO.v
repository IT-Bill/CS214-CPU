`timescale 1ns / 1ps

module MemOrIO(
    mRead, mWrite, ioRead, ioWrite,addr_in,
    addr_out, m_rdata, io_rdata, r_wdata, r_rdata, write_data, LEDCtrl, SwitchCtrl
    );

    input mRead; // read memory, from control32
    input mWrite; // write memory, from control32
    input ioRead; // read IO, from control32
    input ioWrite; // write IO, from control32
    input[31:0] addr_in; // from alu_result in executs32
    
    input[31:0] m_rdata; // data read from memory
    input[15:0] io_rdata; // data read from io,16 bits
    input[31:0] r_rdata; // data read from idecode32(register file)

    output[31:0] r_wdata; // data to idecode32(register file)
    output[31:0] addr_out; // address to memory
    output reg[31:0] write_data; // data to memory or I/O（m_wdata, io_wdata）
    output LEDCtrl; // LED Chip Select
    output SwitchCtrl; // Switch Chip Select

    assign addr_out= addr_in;

    assign r_wdata=(ioRead==1'b1)?io_rdata:m_rdata;           //miss this one !!!

    // The data wirte to register file may be from memory or io. // While the data is from io, it should be the lower 16bit of r_wdata. assign r_wdata = ？？？
    // Chip select signal of Led and Switch are all active high;
    assign LEDCtrl= (ioWrite == 1'b1)?1'b1:1'b0; // led 模块的片选信号，高电平有效; 
    assign SwitchCtrl= (ioRead == 1'b1)?1'b1:1'b0; //switch 模块的片选信号，高电平有效;
    always @* begin
        if((mWrite==1)||(ioWrite==1))
            //wirte_data could go to either memory or IO. where is it from?
            write_data =  ((mWrite == 1'b1)?r_rdata:{16'b0000000000000000,r_rdata[15:0]});
        else
            write_data = 32'hZZZZZZZZ;
    end

endmodule


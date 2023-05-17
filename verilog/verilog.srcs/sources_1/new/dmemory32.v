module dmemory32(
    output [31:0] read_data,
    input [31:0] address,
    input [31:0] write_data,
    input [0:0] MemWrite,
    input [0:0] clock,

    // UART Programmer Pinouts
    // input upg_rst_i, // UPG reset (Active High)
    // input upg_clk_i, // UPG ram_clk_i (10MHz)
    // input upg_wen_i, // UPG write enable
    // input [13:0] upg_adr_i, // UPG write address
    // input [31:0] upg_dat_i, // UPG write data
    // input upg_done_i // 1 if programming is finished


);
    wire clk;
    // Part of dmemory32 module
    //Generating a clk signal, which is the inverted clock of the clock signal
    assign clk = !clock;
    //Create a instance of RAM(IP core), binding the ports
    RAM ram (
    .clka(clk), // input wire clka
    .wea(MemWrite), // input wire [0 : 0] wea
    .addra(address[15:2]), // input wire [13 : 0] addra
    .dina(write_data), // input wire [31 : 0] dina
    .douta(read_data) // output wire [31 : 0] douta
    );
endmodule
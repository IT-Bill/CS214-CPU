module keyboard(
  input            kbcs,
  input      [1:0] kbrps,
  input            clk,
  input            rst,
  input      [3:0] row,                 // 矩阵键盘 �?
  output reg [3:0] col,                 // 矩阵键盘 �?
  output reg [15:0] kbrdata,          // 键盘�?     

  input  [23:0] switch_i,          // 保留指令部分
  input  [1:0] low_addr
);
 
reg       key_pressed_flag;             // 键盘按下标志
reg [3:0] col_val, row_val;             // 列�?��?�行�??


reg [3:0] kbrdata_4bit;
reg [15:0] kbrdata_16bit;
always @(*) begin
    if (rst)
        kbrdata_16bit <= 16'b0;
    else if (key_pressed_flag)
        if (kbrps == 2'b00) 
            kbrdata_16bit <= {kbrdata_16bit[15:4], kbrdata_4bit};
        else if (kbrps == 2'b01)
            kbrdata_16bit <= {kbrdata_16bit[15:8], kbrdata_4bit, kbrdata_16bit[3:0]};
        else if (kbrps == 2'b10)
            kbrdata_16bit <= {kbrdata_16bit[15:12], kbrdata_4bit, kbrdata_16bit[7:0]};
        else if (kbrps == 2'b11)
            kbrdata_16bit <= {kbrdata_4bit, kbrdata_16bit[11:0]};
        else
            kbrdata_16bit <= kbrdata_4bit;
    else
        kbrdata_16bit <= kbrdata_16bit;
end

always@(negedge clk or posedge rst) begin
    if(rst) begin
        kbrdata <= 0;
    end
    else if(kbcs) begin
      if(low_addr==2'b00)
        kbrdata <= kbrdata_16bit;   // data output,lower 16 bits non-extended
      else if(low_addr==2'b10)
        kbrdata <={ 8'h00, switch_i[23:16] };//data output, upper 8 bits extended with zero
      else   
        kbrdata <= kbrdata;
    end
    else 
      kbrdata <= kbrdata;
 
end



//++++++++++++++++++++++++++++++++++++++
// 分频部分 �?�?
//++++++++++++++++++++++++++++++++++++++
reg [15:0] cnt;                         // 计数�?
 
always @ (negedge clk, posedge rst)
  if (rst)
    cnt <= 0;
  else
    cnt <= cnt + 1'b1;
 
wire key_clk = cnt[15];                // (2^20/50M = 21)ms 
//--------------------------------------
// 分频部分 结束
//--------------------------------------
 
 
//++++++++++++++++++++++++++++++++++++++
// 状�?�机部分 �?�?
//++++++++++++++++++++++++++++++++++++++
// 状�?�数较少，独热码编码
parameter NO_KEY_PRESSED = 6'b000_001;  // 没有按键按下  
parameter SCAN_COL0      = 6'b000_010;  // 扫描�?0�? 
parameter SCAN_COL1      = 6'b000_100;  // 扫描�?1�? 
parameter SCAN_COL2      = 6'b001_000;  // 扫描�?2�? 
parameter SCAN_COL3      = 6'b010_000;  // 扫描�?3�? 
parameter KEY_PRESSED    = 6'b100_000;  // 有按键按�?

reg [5:0] current_state, next_state;    // 现�?��?�次�?
 
always @ (negedge key_clk, posedge rst)
  if (rst)
    current_state <= NO_KEY_PRESSED;
  else
    current_state <= next_state;

// 根据条件转移状�??
always @ (*)
  case (current_state)    //若有按键按下，row != 4h'F,从col0�?始一列一列扫�?
            NO_KEY_PRESSED :                    // 没有按键按下
                if (row != 4'hF)
                next_state = SCAN_COL0;
                else
                next_state = NO_KEY_PRESSED;
            SCAN_COL0 :                         // 扫描�?0�? 
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL1;
            SCAN_COL1 :                         // 扫描�?1�? 
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL2;    
            SCAN_COL2 :                         // 扫描�?2�?
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = SCAN_COL3;
            SCAN_COL3 :                         // 扫描�?3�?
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = NO_KEY_PRESSED;
            KEY_PRESSED :                       // 有按键按�?
                if (row != 4'hF)
                next_state = KEY_PRESSED;
                else
                next_state = NO_KEY_PRESSED;                      
    endcase
     //next_state是最后扫描的结果（到next_state发现row != 4'hF才停�?
 
 
// 根据次�?�，给相应寄存器赋�??
always @ (negedge key_clk, posedge rst)
  if (rst)
  begin
    col              <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state)
      NO_KEY_PRESSED :                  // 没有按键按下
      begin
        col              <= 4'h0;
        key_pressed_flag <=    0;       // 清键盘按下标�?
      end
      SCAN_COL0 :                       // 扫描�?0�?
        col <= 4'b1110;
      SCAN_COL1 :                       // 扫描�?1�?
        col <= 4'b1101;
      SCAN_COL2 :                       // 扫描�?2�?
        col <= 4'b1011;
      SCAN_COL3 :                       // 扫描�?3�?
        col <= 4'b0111;
      KEY_PRESSED :                     // 有按键按�?
      begin
        col_val          <= col;        // 锁存列�??
        row_val          <= row;        // 锁存行�??
        key_pressed_flag <= 1;          // 置键盘按下标�?  
      end
    endcase
//--------------------------------------
// 状�?�机部分 结束
//--------------------------------------
 
 
//++++++++++++++++++++++++++++++++++++++
// 扫描行列值部�? �?�?
//++++++++++++++++++++++++++++++++++++++
always @ (negedge key_clk, posedge rst)
  if (rst)
    kbrdata_4bit <= 16'h0;
  else
    if (key_pressed_flag && kbcs)
        case ({col_val, row_val})
            8'b1110_1110 : kbrdata_4bit <= 4'h1;    //从右�?左，从下�?上扫描键�?
            8'b1110_1101 : kbrdata_4bit <= 4'h4;
            8'b1110_1011 : kbrdata_4bit <= 4'h7;
            8'b1110_0111 : kbrdata_4bit <= 4'hE;
            
            8'b1101_1110 : kbrdata_4bit <= 4'h2;
            8'b1101_1101 : kbrdata_4bit <= 4'h5;
            8'b1101_1011 : kbrdata_4bit <= 4'h8;
            8'b1101_0111 : kbrdata_4bit <= 4'h0;
            
            8'b1011_1110 : kbrdata_4bit <= 4'h3;
            8'b1011_1101 : kbrdata_4bit <= 4'h6;
            8'b1011_1011 : kbrdata_4bit <= 4'h9;
            8'b1011_0111 : kbrdata_4bit <= 4'hF;

            8'b0111_1110 : kbrdata_4bit <= 4'hA;
            8'b0111_1101 : kbrdata_4bit <= 4'hB;
            8'b0111_1011 : kbrdata_4bit <= 4'hC;
            8'b0111_0111 : kbrdata_4bit <= 4'hD;

            default: kbrdata_4bit <= kbrdata_4bit;        
    endcase
endmodule
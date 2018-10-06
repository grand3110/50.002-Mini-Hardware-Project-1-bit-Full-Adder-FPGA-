/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module state_m_2 (
    input clk,
    input rst,
    input sum,
    input carry,
    input start,
    input switch1,
    input switch2,
    input a_m,
    input b_m,
    input c_m,
    output reg [7:0] pass,
    output reg [7:0] fail,
    output reg [7:0] manual,
    output reg [7:0] count,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    output reg a,
    output reg b,
    output reg c
  );
  
  
  
  localparam IDLE_state = 4'd0;
  localparam ALLOFF_state = 4'd1;
  localparam AON_state = 4'd2;
  localparam BON_state = 4'd3;
  localparam ABON_state = 4'd4;
  localparam CON_state = 4'd5;
  localparam ACON_state = 4'd6;
  localparam BCON_state = 4'd7;
  localparam ABCON_state = 4'd8;
  localparam FAIL_state = 4'd9;
  localparam PASS_state = 4'd10;
  localparam MANUAL_state = 4'd11;
  
  reg [3:0] M_state_d, M_state_q = IDLE_state;
  wire [8-1:0] M_seg_seg;
  wire [4-1:0] M_seg_sel;
  reg [16-1:0] M_seg_values;
  multi_seven_seg_3 seg (
    .clk(clk),
    .rst(rst),
    .values(M_seg_values),
    .seg(M_seg_seg),
    .sel(M_seg_sel)
  );
  reg [25:0] M_counter_d, M_counter_q = 1'h0;
  reg [7:0] M_register_d, M_register_q = 1'h0;
  wire [1-1:0] M_myBlinker_blink;
  blinker_4 myBlinker (
    .clk(clk),
    .rst(rst),
    .blink(M_myBlinker_blink)
  );
  
  integer z;
  
  always @* begin
    M_state_d = M_state_q;
    M_register_d = M_register_q;
    M_counter_d = M_counter_q;
    
    a = 1'h0;
    b = 1'h0;
    c = 1'h0;
    z = {carry, sum};
    pass = 8'h00;
    fail = 8'h00;
    count = 8'h00;
    manual = 8'h00;
    M_counter_d = M_counter_q + 1'h1;
    M_seg_values = 16'h0000;
    io_seg = ~M_seg_seg;
    io_sel = ~M_seg_sel;
    
    case (M_state_q)
      IDLE_state: begin
        a = 1'h0;
        b = 1'h0;
        c = 1'h0;
        M_seg_values = 16'h1dce;
        fail = M_register_q;
        if (start == 1'h1) begin
          M_state_d = ALLOFF_state;
          M_counter_d = 1'h0;
          M_register_d = 1'h0;
        end
        if (switch1 == 1'h1) begin
          M_state_d = MANUAL_state;
          M_counter_d = 1'h0;
        end
      end
      PASS_state: begin
        a = 1'h0;
        b = 1'h0;
        c = 1'h0;
        M_seg_values = 16'hba55;
        fail = M_register_q;
        if (start == 1'h1) begin
          M_state_d = ALLOFF_state;
          M_counter_d = 1'h0;
          M_register_d = 1'h0;
        end
        if (switch1 == 1'h1) begin
          M_state_d = MANUAL_state;
          M_counter_d = 1'h0;
        end
      end
      FAIL_state: begin
        a = 1'h0;
        b = 1'h0;
        c = 1'h0;
        count = M_register_q;
        M_seg_values = 16'hfa1c;
        fail = M_register_q;
        if (start == 1'h1) begin
          M_state_d = ALLOFF_state;
          M_counter_d = 1'h0;
          M_register_d = 1'h0;
        end
        if (switch1 == 1'h1) begin
          M_state_d = MANUAL_state;
          M_counter_d = 1'h0;
        end
      end
      ALLOFF_state: begin
        a = 1'h0;
        b = 1'h0;
        c = 1'h0;
        count = 8'h01;
        fail = M_register_q;
        if (z == 2'h0) begin
          pass = 8'hff;
          M_register_d[0+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          M_state_d = AON_state;
          M_counter_d = 1'h0;
        end
      end
      AON_state: begin
        a = 1'h1;
        b = 1'h0;
        c = 1'h0;
        count = 8'h02;
        fail = M_register_q;
        if (z == 2'h1) begin
          pass = 8'hff;
          M_register_d[1+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          M_state_d = BON_state;
          M_counter_d = 1'h0;
        end
      end
      BON_state: begin
        a = 1'h0;
        b = 1'h1;
        c = 1'h0;
        count = 8'h04;
        fail = M_register_q;
        if (z == 2'h1) begin
          pass = 8'hff;
          M_register_d[2+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          M_state_d = ABON_state;
          M_counter_d = 1'h0;
        end
      end
      CON_state: begin
        a = 1'h0;
        b = 1'h0;
        c = 1'h1;
        count = 8'h10;
        fail = M_register_q;
        if (z == 2'h1) begin
          pass = 8'hff;
          M_register_d[4+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          M_state_d = ACON_state;
          M_counter_d = 1'h0;
        end
      end
      ABON_state: begin
        a = 1'h1;
        b = 1'h1;
        c = 1'h0;
        count = 8'h08;
        fail = M_register_q;
        if (z == 2'h2) begin
          pass = 8'hff;
          M_register_d[3+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          M_state_d = CON_state;
          M_counter_d = 1'h0;
        end
      end
      BCON_state: begin
        a = 1'h0;
        b = 1'h1;
        c = 1'h1;
        count = 8'h40;
        fail = M_register_q;
        if (z == 2'h2) begin
          pass = 8'hff;
          M_register_d[6+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          M_state_d = ABCON_state;
          M_counter_d = 1'h0;
        end
      end
      ACON_state: begin
        a = 1'h1;
        b = 1'h0;
        c = 1'h1;
        count = 8'h20;
        fail = M_register_q;
        if (z == 2'h2) begin
          pass = 8'hff;
          M_register_d[5+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          M_state_d = BCON_state;
          M_counter_d = 1'h0;
        end
      end
      ABCON_state: begin
        a = 1'h1;
        b = 1'h1;
        c = 1'h1;
        count = 8'h80;
        fail = M_register_q;
        if (z == 2'h3) begin
          pass = 8'hff;
          M_register_d[7+0-:1] = 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1) begin
          if (M_register_q == 8'hff) begin
            M_state_d = PASS_state;
          end else begin
            M_state_d = FAIL_state;
          end
          M_counter_d = 1'h0;
        end
      end
      MANUAL_state: begin
        if (switch2 == 1'h1) begin
          M_state_d = IDLE_state;
          M_counter_d = 1'h0;
          M_register_d = 1'h0;
        end
        a = a_m;
        b = b_m;
        c = c_m;
        manual = 8'hff;
        M_seg_values = 16'h0000;
        if (a_m) begin
          pass = 8'hff;
        end
        if (b_m) begin
          count = 8'hff;
        end
        if (c_m) begin
          fail = 8'hff;
        end
        if (a_m + b_m + c_m != z) begin
          manual = {4'h8{M_myBlinker_blink}};
          M_seg_values = 16'hfa1c;
        end else begin
          if (a_m + b_m + c_m == z) begin
            M_seg_values = 16'hba55;
          end
        end
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_counter_q <= 1'h0;
      M_register_q <= 1'h0;
      M_state_q <= 1'h0;
    end else begin
      M_counter_q <= M_counter_d;
      M_register_q <= M_register_d;
      M_state_q <= M_state_d;
    end
  end
  
endmodule

module Arbiter(clk, rst, Req_N, Req_E, Req_W, Req_S, Req_L, DCTS, Grant_N, Grant_E, Grant_W, Grant_S, Grant_L, Xbar_sel, RTS);
  input clk;
  input rst;
  input Req_N;
  input Req_E;
  input Req_W;
  input Req_S;
  input Req_L;
  input DCTS;
  output logic Grant_N;
  output logic Grant_E;
  output logic Grant_W;
  output logic Grant_S;
  output logic Grant_L;
  output logic [4:0] Xbar_sel;
  output logic RTS;
  reg [5:0] state;
  reg [5:0] state_in;
  reg [5:0] next_state;
  logic RTS_FF = 0;
  logic RTS_FF_in = 0;
  always @ (posedge clk) begin
    if (rst) begin
      state <= 6'b00001;
      state_in <= 6'b00001;
      next_state <= 6'b00001;
      RTS_FF <= 1;  //RTS_FF <= 0
    end
    else begin
      state <= state_in;
      RTS_FF <= RTS_FF_in;
    end
  end
  assign RTS = RTS_FF;
  always @ (RTS_FF, DCTS, state, next_state) begin
    if (RTS_FF && ( !DCTS )) begin
      state_in <= state;
    end
    else begin
      state_in <= next_state;
    end
  end
  always @ (state, RTS_FF, DCTS) begin
    if (state == 6'b00001) begin
      RTS_FF_in <= 0;
    end
    else begin
      if (RTS_FF && DCTS) begin
        RTS_FF_in <= 0;
      end
      else begin
        RTS_FF_in <= 1;
      end
    end
  end
  always @ (state, Req_N, Req_E, Req_W, Req_S, Req_L, DCTS, RTS_FF) begin
    Grant_N <= 0;
    Grant_E <= 0;
    Grant_W <= 0;
    Grant_S <= 0;
    Grant_L <= 0;
    Xbar_sel <= 5'b00000;
    if (state == 6'b00001) begin
      Xbar_sel <= 5'b00000;
      if (Req_L) begin
        next_state <= 6'b000010;
      end
      else       if (Req_N) begin
        next_state <= 6'b000100;
      end
      else       if (Req_E) begin
        next_state <= 6'b001000;
      end
      else       if (Req_W) begin
        next_state <= 6'b010000;
      end
      else       if (Req_S) begin
        next_state <= 6'b100000;
      end
      else begin
        next_state <= 6'b00001;
      end
    end
    else     if (state == 6'b000100) begin
      Grant_N <= DCTS & RTS_FF;
      Xbar_sel <= 5'b00001;
      if (Req_N) begin
        next_state <= 6'b000100;
      end
      else       if (Req_E) begin
        next_state <= 6'b001000;
      end
      else       if (Req_W) begin
        next_state <= 6'b010000;
      end
      else       if (Req_S) begin
        next_state <= 6'b100000;
      end
      else       if (Req_L) begin
        next_state <= 6'b000010;
      end
      else begin
        next_state <= 6'b00001;
      end
    end
    else     if (state == 6'b001000) begin
      Grant_E <= DCTS & RTS_FF;
      Xbar_sel <= 5'b00010;
      if (Req_E) begin
        next_state <= 6'b001000;
      end
      else       if (Req_W) begin
        next_state <= 6'b010000;
      end
      else       if (Req_S) begin
        next_state <= 6'b100000;
      end
      else       if (Req_L) begin
        next_state <= 6'b000010;
      end
      else       if (Req_N) begin
        next_state <= 6'b000100;
      end
      else begin
        next_state <= 6'b00001;
      end
    end
    else     if (state == 6'b010000) begin
      Grant_W <= DCTS & RTS_FF;
      Xbar_sel <= 5'b00100;
      if (Req_W) begin
        next_state <= 6'b010000;
      end
      else       if (Req_S) begin
        next_state <= 6'b100000;
      end
      else       if (Req_L) begin
        next_state <= 6'b000010;
      end
      else       if (Req_N) begin
        next_state <= 6'b000100;
      end
      else       if (Req_E) begin
        next_state <= 6'b001000;
      end
      else begin
        next_state <= 6'b00001;
      end
    end
    else     if (state == 6'b100000) begin
      Grant_S <= DCTS & RTS_FF;
      Xbar_sel <= 5'b01000;
      if (Req_S) begin
        next_state <= 6'b100000;
      end
      else       if (Req_L) begin
        next_state <= 6'b000010;
      end
      else       if (Req_N) begin
        next_state <= 6'b000100;
      end
      else       if (Req_E) begin
        next_state <= 6'b001000;
      end
      else       if (Req_W) begin
        next_state <= 6'b010000;
      end
      else begin
        next_state <= 6'b00001;
      end
    end
    else begin
      Grant_L <= DCTS & RTS_FF;
      Xbar_sel <= 5'b10000;
      if (Req_L) begin
        next_state <= 6'b000010;
      end
      else       if (Req_N) begin
        next_state <= 6'b000100;
      end
      else       if (Req_E) begin
        next_state <= 6'b001000;
      end
      else       if (Req_W) begin
        next_state <= 6'b010000;
      end
      else       if (Req_S) begin
        next_state <= 6'b100000;
      end
      else begin
        next_state <= 6'b00001;
      end
    end
  end
endmodule

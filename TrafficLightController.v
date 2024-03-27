/*
pierre backleh
1201296
*/
`timescale 1s / 1ns
//converting binary values to colors
`define Green 2'b00
`define Yellow 2'b01
`define Red 2'b10
`define RedYellow 2'b11
// These parameters represent the states
parameter S0=5'b00000, S1=5'b00001, S2=5'b00010, S3=5'b00011, S4=5'b00100, S5=5'b00101, S6=5'b00110, S7=5'b00111, S17=5'b10001;
parameter S8=5'b01000, S9=5'b01001, S10=5'b01010, S11=5'b01011, S12=5'b01100, S13=5'b01101, S14=5'b01110, S15=5'b01111,S16=5'b10000; 
//the n-parameter is used for the counter
parameter n=5;
//the main module
module Traffic_Light_Controller_FSM(HW1, HW2, FW1, FW2, clk, rst, go); 
	output reg [1:0]HW1,HW2,FW1,FW2;
	input clk, rst, go;
	reg [n-1:0]timer; 
	//6 bits for each state
	reg [5:0]state, next_state;
	//to initialize the values
	initial begin
		state <= S0;
		next_state <= S0;
		timer <= 0;
	end
	
	//first always block to control the moving between the states
	always @ (posedge clk or go or negedge rst)
        begin
            if (rst)
                begin
                    timer <= 0;
					state <= S0;
                end
            else if (go)
                begin
					//case statement to test each state 
                    case (state)
                        S0: begin 
							    //to check if the counter reaches 1 sec. then the state should change to S1
                                if (timer == 1)
                                begin
                                    state <= S1;
									//to reset the counter
                                    timer <= 0;
                                end
                                else
									//continue counting
                                    timer <= timer + 1;
                            end
                        S1: begin
                                if (timer == 2)
                                begin
                                    state <= S2;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
                        S2: begin
                                if (timer == 30)
                                begin
                                    state <= S3;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
                        S3: begin
                                if (timer == 2)
                                begin
                                    state <= S4;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S4: begin
                                if (timer == 10)
                                begin
                                    state <= S5;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end	
						S5: begin
                                if (timer == 2)
                                begin
                                    state <= S6;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S6: begin
                                if (timer == 1)
                                begin
                                    state <= S7;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S7: begin
                                if (timer == 2)
                                begin
                                    state <= S8;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S8: begin
                                if (timer == 15)
                                begin
                                    state <= S9;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S9: begin
                                if (timer == 2)
                                begin
                                    state <= S10;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S10: begin
                                if (timer == 5)
                                begin
                                    state <= S11;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S11: begin
                                if (timer == 2)
                                begin
                                    state <= S12;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S12: begin
                                if (timer == 10)
                                begin
                                    state <= S13;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S13: begin
                                if (timer == 2)
                                begin
                                    state <= S14;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S14: begin
                                if (timer == 1)
                                begin
                                    state <= S15;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S15: begin
                                if (timer == 2)
                                begin
                                    state <= S16;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S16: begin
                                if (timer == 15)
                                begin
                                    state <= S17;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S17: begin
                                if (timer == 3)
                                begin
                                    state <= S0;
									timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
                    endcase
                end
			end
	//second always block
		//the program should enter this always block when the state change from state to another state
	always @ (state)
		begin
			case (state)
				S0:begin
					//to give the correct signal for each traffic light on the road
					HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Red;
					FW2 <= `Red;
					
					 end
					
						
				S1:begin
					HW1 <= `RedYellow;
					HW2 <= `RedYellow;
					FW1 <= `Red;
					FW2 <= `Red;
					 end
										  
				S2:begin HW1 <= `Green;
					HW2 <= `Green;
					FW1 <= `Red;
					FW2 <= `Red;
					 end
							
				S3:begin HW1 <= `Green;
					HW2 <= `Yellow;
					FW1 <= `Red;
					FW2 <= `Red; 
					end
							
				S4:begin HW1 <= `Green;
					HW2 <= `Red;
					FW1 <= `Red;
					FW2 <= `Red;
					 end	 
							
				S5:begin HW1 <= `Yellow;
					HW2 <= `Red;
					FW1 <= `Red;
					FW2 <= `Red;
					 end	
					
				S6:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Red;
					FW2 <= `Red;
					; end	
						
				S7:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `RedYellow;
					FW2 <= `RedYellow;
					 end	
							
				S8:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Green;
					FW2 <= `Green;
					 end
							
				S9:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Green;
					FW2 <= `Yellow;
					 end
							
		        S10:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Green;
					FW2 <= `Red;
					 end
							
				S11:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Yellow;
					FW2 <= `RedYellow;
					 end
							
				 S12:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Red;
					FW2 <= `Green;
					end
							
				S13:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Red;
					FW2 <= `Yellow;
					end
						
				S14:begin HW1 <= `Red;
					HW2 <= `Red;
					FW1 <= `Red;
					FW2 <= `Red;
					end
						
				S15:begin HW1 <= `Red;
					HW2 <= `RedYellow;
					FW1 <= `Red;
					FW2 <= `Red;
					end
						
		    	S16:begin HW1 <= `Red;
					HW2 <= `Green;
					FW1 <= `Red;
					FW2 <= `Red;
					end
							
				S17:begin HW1 <= `Red;
					HW2 <= `Yellow;
					FW1 <= `Red;
					FW2 <= `Red;
			 end
		endcase	
	end
endmodule 

module testbench;
	//inputs	
  reg clk, rst, go;
  reg [4:0]state;
  reg [n-1:0]timer;
  //outputs
  wire [1:0] HW1, HW2, FW1, FW2;
  //The main module
  Traffic_Light_Controller_FSM tb_for_TLC(HW1,HW2,FW1,FW2,clk,rst,go);

  initial begin	
	state = 0; 
	timer = 0;
    clk = 0;
    go = 1;
    rst = 0;
    #100;
    rst = 1;
    #10;
    rst = 0;
    #20;
    go = 0;
    #100;
    go = 1;
	//To terminate the simulation
	#1000 $finish;
  end

  always #1 clk = ~clk;	   
	  
	always @ (posedge clk or go or negedge rst)
        begin
            if (rst)
                begin
                    timer <= 0;
					state <= S0;
                end
            else if (go)
                begin
                    case (state)
                        S0: begin
                                if (timer == 1)
                                begin
                                    state <= S1;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
                        S1: begin
                                if (timer == 2)
                                begin
                                    state <= S2;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
                        S2: begin
                                if (timer == 30)
                                begin
                                    state <= S3;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
                        S3: begin
                                if (timer == 2)
                                begin
                                    state <= S4;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S4: begin
                                if (timer == 10)
                                begin
                                    state <= S5;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end	
						S5: begin
                                if (timer == 2)
                                begin
                                    state <= S6;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S6: begin
                                if (timer == 1)
                                begin
                                    state <= S7;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S7: begin
                                if (timer == 2)
                                begin
                                    state <= S8;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S8: begin
                                if (timer == 15)
                                begin
                                    state <= S9;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S9: begin
                                if (timer == 2)
                                begin
                                    state <= S10;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S10: begin
                                if (timer == 5)
                                begin
                                    state <= S11;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S11: begin
                                if (timer == 2)
                                begin
                                    state <= S12;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S12: begin
                                if (timer == 10)
                                begin
                                    state <= S13;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S13: begin
                                if (timer == 2)
                                begin
                                    state <= S14;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S14: begin
                                if (timer == 1)
                                begin
                                    state <= S15;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S15: begin
                                if (timer == 2)
                                begin
                                    state <= S16;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S16: begin
                                if (timer == 15)
                                begin
                                    state <= S17;
                                    timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
						S17: begin
                                if (timer == 3)
                                begin
                                    state <= S0;
									timer <= 0;
                                end
                                else
                                    timer <= timer + 1;
                            end
                    endcase
                end
			end
	//analyzer
	always @ (state)
		begin
			case (state)
				S0:begin
					//to detect the error
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 0");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 0");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 0");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 0");
					
					 end
					
						
				S1:begin
					assert(HW1 == `RedYellow) else $error("unexpected highway signal 1 in state 1");
            		assert(HW2 == `RedYellow) else $error("unexpected highway signal 2 in state 1");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 1");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 1");
					 end
										  
				S2:begin
					assert(HW1 == `Green) else $error("unexpected highway signal 1 in state 2");
            		assert(HW2 == `Green) else $error("unexpected highway signal 2 in state 2");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 2");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 2");
					
					 end
							
				S3:begin
					 assert(HW1 == `Green) else $error("unexpected highway signal 1 in state 3");
            		assert(HW2 == `Yellow) else $error("unexpected highway signal 2 in state 3");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 3");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 3");
					end
							
				S4:begin
					assert(HW1 == `Green) else $error("unexpected highway signal 1 in state 4");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 4");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 4");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 4");
					 end	 
							
				S5:begin
					assert(HW1 == `Yellow) else $error("unexpected highway signal 1 in state 5");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 5");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 5");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 5");
					 end	
					
				S6:begin 
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 6");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 6");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 6");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 6");
					end	
						
				S7:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 7");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 7");
            		assert(FW1 == `RedYellow) else $error("unexpected farm signal 1 in state 7");
            		assert(FW2 == `RedYellow) else $error("unexpected farm signal 2 in state 7");
					 end	
							
				S8:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 8");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 8");
            		assert(FW1 == `Green) else $error("unexpected farm signal 1 in state 8");
            		assert(FW2 == `Green) else $error("unexpected farm signal 2 in state 8");
					 end
							
				S9:begin 
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 9");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 9");
            		assert(FW1 == `Green) else $error("unexpected farm signal 1 in state 9");
            		assert(FW2 == `Yellow) else $error("unexpected farm signal 2 in state 9");
					 end
							
		        S10:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 10");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 10");
            		assert(FW1 == `Green) else $error("unexpected farm signal 1 in state 10");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 10");
					 end
							
				S11:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 11");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 11");
            		assert(FW1 == `Yellow) else $error("unexpected farm signal 1 in state 11");
            		assert(FW2 == `RedYellow) else $error("unexpected farm signal 2 in state 11");
					 end
							
				 S12:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 12");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 12");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 12");
            		assert(FW2 == `Green) else $error("unexpected farm signal 2 in state 12");
					end
							
				S13:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 13");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 13");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 13");
            		assert(FW2 == `Yellow) else $error("unexpected farm signal 2 in state 13");
					end
						
				S14:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 14");
            		assert(HW2 == `Red) else $error("unexpected highway signal 2 in state 14");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 14");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 14");
					end
						
				S15:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 15");
            		assert(HW2 == `RedYellow) else $error("unexpected highway signal 2 in state 15");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 15");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 15");
					end
						
		    	S16:begin
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 16");
            		assert(HW2 == `Green) else $error("unexpected highway signal 2 in state 16");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 16");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 16");
					end
							
				S17:begin 
					assert(HW1 == `Red) else $error("unexpected highway signal 1 in state 17");
            		assert(HW2 == `Yellow) else $error("unexpected highway signal 2 in state 17");
            		assert(FW1 == `Red) else $error("unexpected farm signal 1 in state 17");
            		assert(FW2 == `Red) else $error("unexpected farm signal 2 in state 17");
			 end
		endcase	
	end

endmodule



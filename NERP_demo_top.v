`timescale 1ns / 1ps

module NERP_demo_top(
	input jump_btn,
	input down_btn,
	input enable_btn,
	input rst_btn,
	input jumprate1,
	input jumprate2,
	input jumprate3,
	input wire clk,         //master clock = 50MHz
	input wire clr,			//right-most pushbutton for reset
	output wire [6:0] seg,	//7-segment display LEDs
	output wire [3:0] an,	//7-segment display anode enable
	output wire dp,			//7-segment display decimal point
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [1:0] blue,	//blue vga output - 2 bits
	output wire hsync,		//horizontal sync out
	output wire vsync			//vertical sync out
	);

//enabling & debouncing for stabilizing input, since inputs can have unstable nature.
reg jump;
reg enable;
initial enable = 0;
reg enable_d;
initial enable_d = 0;
always @ (posedge bird_clk)
	if(enable_btn && !enable_d && state == 2)
	begin
		enable <= !enable;
	end
	else if (state != 2)
		enable <= 0;
		
always @ (posedge bird_clk)
begin
	enable_d <= enable_btn;
	jump <= jump_btn;
end

reg down;
reg enable;
    initial enable = 0;
reg enable_d;
initial enable_d = 0;
always @ (posedge bird_clk)
	if(enable_btn && !enable_d && state == 2)
	begin
		enable <= !enable;
	end
	else if (state != 2)
		enable <= 0;
		
always @ (posedge bird_clk)
begin
	enable_d <= enable_btn;
	down <= down_btn;
end

// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire dclk;

// disable the 7-segment decimal points
assign dp = 1;

//bird stuff
wire [10:0] bird_coord;
wire bird_clk;

//pipe stuff
wire [7:0] rand;
reg [7:0] pipe_array0;
initial pipe_array0 <= 100;
reg [7:0] pipe_array1;

//game state
reg [1:0] state; //00-lost 01-reset 02-start
initial state = 3;
always @ (posedge bird_clk)
begin
	if(state == 2) //784 - pipe_pis-345 = right position of pipe, +50 is for left side.
	begin
		if(284 > (784-pipe_pos-345) && 244 < (784-pipe_pos+50-345)) //hc
			if((480-bird_coord)-20 < pipe_array0+75 || (480-bird_coord)+20 > pipe_array0+215) //vc
				state <= 0; //if collision then state is set to lost
		else if(bird_coord == 0 || bird_coord > 400) //480 - bird_coord is for upper bound/lb.
			state <= 0;
		if(current_score > high_score)
			high_score <= current_score;
	end
	else if(state==3 && jump) //start cond
	   state <= 1;
	else if( !state && rst_btn) //reset cond
	begin
		state <= 1;
	end
	else if(jump && state==1) //start after reset
		state <= 2;
end

reg [17:0] pos; //18bit pos register is just managing accordingly.
initial pos = 0;
always @ (posedge dclk)
begin
    if (jumprate1 == 0 && jumprate2 == 0 && jumprate3 == 1)
    begin
		pos <= pos + 1;
	end
    if (jumprate1 == 0 && jumprate2 == 1 && jumprate3 == 1)
	begin
	   pos <= pos + 2;
	end
    if (jumprate1 == 1 && jumprate2 == 1 && jumprate3 == 1)
	begin
	   pos <= pos + 0;
	end
    if (jumprate1 == 0 && jumprate2 == 0 && jumprate3 == 0)
	begin
	   pos <= pos + 0;
	end
end

reg [9:0] pipe_pos;
initial pipe_pos = 0;
always @ (posedge pos[17]) //checks for condition at each posedge of pos17
begin
	if(!enable && state == 2 && pipe_pos < 345)
		pipe_pos <= pipe_pos+1; //increments pipe pos 
	else if(!enable && state == 2) //this is condition for resetting pipe pos
	begin
		pipe_pos <= 0;
		pipe_array0 <= pipe_array1; //pipe array 0 is updated to pipe array 1
		pipe_array1 <= rand; //pipe array 1 generation is randomised using xor logic function from pipe.v
		current_score <= current_score + 1; //this is to update the current score on led.
	end
	if(state == 1) //just reset everything once reset_btn used.
	begin
		pipe_pos <= 0;
		current_score <= 0;
		pipe_array0 <= 100;
	end
end

//scorekeeping
reg [3:0] current_score;
reg [3:0] high_score;
initial current_score = 0;
initial high_score = 0;


// generate 7-segment clock & display clock
clockdiv U1(
	.clk(clk),
	.clr(clr),
	.segclk(segclk),
	.dclk(dclk),
	.bird_clk(bird_clk)
	);

// 7-segment display controller
segdisplay U2(
	.score(current_score),
	.high_score(high_score),
	.segclk(segclk),
	.clr(clr),
	.seg(seg),
	.an(an)
	);

// VGA controller
vga640x480 U3(
	.bird_coord(bird_coord),
	.pipe_pos(pipe_pos),
	.pipe_array0(pipe_array0),
	.pipe_array1(pipe_array1),
	.current_score(current_score),
	.dclk(dclk),
	.clr(clr),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue),
	.jumprate1(jumprate1),
	.jumprate2(jumprate2),
	.jumprate3(jumprate3),
	.state(state)
	);
	
bird flappy(
	.clk(bird_clk),
	.enable(!enable),
	.jump(jump),
	.down(down),
	.state(state),
	.fall_accel(1),
	.y_coord(bird_coord)
);

RNG pipe_gen(
		.clk(clk),
		.out(rand)
	);
	

endmodule

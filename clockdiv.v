`timescale 1ns / 1ps

module clockdiv(
	input wire clk,		//master clock: 50MHz
	input wire clr,		//asynchronous reset
	output wire dclk,		//pixel clock: 25MHz
	output wire segclk,	//7-segment clock: 381.47Hz
	output wire bird_clk
	);

// 17-bit counter variable
reg [16:0] q;

// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge clk or posedge clr)
begin
	// reset condition
	if (clr == 1)
		q <= 0;
	// increment counter by one
	else
		q <= q + 1;
end

// 50Mhz ÷ 2^17 = 381.47Hz
assign segclk = q[16];

// 50Mhz ÷ 2^1 = 25MHz
assign dclk = q[1];

assign bird_clk = q[16];

endmodule

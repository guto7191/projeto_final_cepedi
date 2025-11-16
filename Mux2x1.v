module Mux2x1(
	input [7:0] in_0, 
	input [7:0] in_1,
	input sel,
	output reg [7:0] out
);

	always @(*) begin 
		out = (sel) ? in_1 : in_0;
	end


endmodule 
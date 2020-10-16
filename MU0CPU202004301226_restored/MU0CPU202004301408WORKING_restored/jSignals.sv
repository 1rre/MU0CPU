module jSignals(
	input logic [15:0] acc,
	output logic mi,
	output logic eq
);

assign mi = (acc[15] == 1); //if the 1st bit of the accumulator is 1 it is assumed to be negative.
assign eq = (acc[15:0]==0); //if all bits of the accumulator are 0 it is assumed to be 0.

endmodule
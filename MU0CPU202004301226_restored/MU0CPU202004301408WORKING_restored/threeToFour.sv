module threeToFour(
	input logic [11:0] in,
	output logic [15:0] out
);

	assign out[11:0] = in;
	assign out[12] = in[11];
	assign out[13] = in[11];
	assign out[14] = in[11];
	assign out[15] = in[11];

endmodule
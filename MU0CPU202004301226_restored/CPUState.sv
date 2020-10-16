module CPUState(
	input logic [2:0] s,
	input logic extra,
	output logic [2:0] ns,
	output logic fetch,
	output logic exec1,
	output logic exec2
);

assign ns[0] = ~s[0]; //ns = xx1 if s = xx0 & xx0 if s = xx1
assign ns[1] = ((s==1)&&(extra==1)); //ns = x1x if s = 001 and extra = 1
assign ns[2] = 0; //ns = 0xx always
assign fetch = (ns==0); //fetch = 1 if ns = 000
assign exec1 = (ns==1); //exec1 = 1 if ns = 001
assign exec2 = (ns==2); //exec2 = 1 if ns = 010

endmodule
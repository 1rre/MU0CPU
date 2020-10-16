module CPUState(
	input logic [2:0] s,
	input logic extra,
	input logic boot,
	output logic [2:0] ns,
	output logic fetch,
	output logic exec1,
	output logic exec2
);

assign ns[0] = ((~s[0])&&!exec2)&&boot; //ns = xx1 if s = xx0 & xx0 if s = xx1
assign ns[1] = ((s==1)&&(extra==1))&&boot; //ns = x1x if s = 001 and extra = 1
assign ns[2] = 0; //ns = 0xx always

assign fetch = (s==0); //fetch = 1 if ns = 000
assign exec1 = (s==1); //exec1 = 1 if ns = 001
assign exec2 = (s==2); //exec2 = 1 if ns = 010

endmodule
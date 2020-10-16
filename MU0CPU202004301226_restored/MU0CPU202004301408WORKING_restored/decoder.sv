module decoder(
	output logic ramWrEn,
	output logic pcEnable,
	output logic mux1,
	output logic pcSLoad,
	output logic addsub,
	output logic mux3,
	output logic accMode,
	output logic accEnable,
	output logic shiftin,
	output logic extra,
	output logic mux4,
	input logic eq,
	input logic mi,
	input logic [3:0] mux2r,
	input logic fetch,
	input logic exec1,
	input logic exec2,
	input logic [3:0] premux2r
);
wire logic LDA, STA, ADD, SUB, JMP, JMI, JEQ, STP, LDI, LSL, LSR;

assign LDA = (mux2r==0 && !exec2)||(exec2&&(premux2r==0)); //opcode 0000 (0)
assign STA = (mux2r==1); //opcode 0001 (1)
assign ADD = (mux2r==2 && !exec2)||(exec2&&(premux2r==2)); //opcode 0010 (2)
assign SUB = (mux2r==3 && !exec2)||(exec2&&(premux2r==3)); //opcode 0011 (3)
assign JMP = (mux2r==4); //opcode 0100 (4)
assign JMI = (mux2r==5); //opcode 0101 (5)
assign JEQ = (mux2r==6); //opcode 0110 (6)
assign STP = (mux2r==7); //opcode 0111 (7)
assign LDI = (mux2r==8); //opcode 1000 (8)
assign LSL = (mux2r==9 && !exec2)||(exec2&&(premux2r==9)); //opcode 1001 (9)
assign LSR = (mux2r==10); //opcode 1010 (F)
assign extra = (LDA||ADD||SUB); //LDA, ADD and SUB require an extra cycle
assign mux1 = (fetch && STA)|| (exec1&&((ADD||SUB||LDA)||(JMP||(JMI&&mi)||(JEQ&&eq)))); //Update the RAM address after the execution has completed
assign ramWrEn = (fetch && STA); //only STA writes to RAM
assign pcSLoad = (!STP&&(((JEQ && eq)||(JMI && mi)||JMP) && exec1)); //Load a new value into the program counter at the last cycle of a jump instruction
assign pcEnable = (!STP&&((!pcSLoad) && ((fetch && !(extra)) || (exec1&&extra)))); //increment the program counter if the program is not jumping and it is the last cycle of the instruction
assign addsub = !SUB; //0 for ADD or LSL, 1 for sub, don't care otherwise
assign shiftin = mi; //Use 1 if negative, 0 otherwise
assign mux3 = !LDI&&!LDA; //1 for writing literal (LDI only?)
assign accMode = !LSR; //Load for anything but LSR
assign accEnable = ((exec1&&!extra)||exec2) && (LDA||ADD||SUB||LDI||LSR||LSL); //enable the accumulator for load, add, sub, load immediate, LSL, LSR (things that update it)
assign mux4 = LSL;

endmodule
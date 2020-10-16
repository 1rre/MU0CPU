module decoder(
	output logic ramWrEn,
	output logic pcEnable,
	output logic mux1,
	output logic pcSLoad,
	output logic o1,
	output logic o2,
	output logic extra,
	input logic eq,
	input logic mi,
	input logic [3:0] mux2r,
	input logic fetch,
	input logic exec1,
	input logic exec2
);
wire logic LDA, STA, ADD, SUB, JMP, JMI, JEQ, STP, LDI, LSL, LSR;

assign LDA = (mux2r==0); //opcode 0000 (0)
assign STA = (mux2r==1); //opcode 0001 (1)
assign ADD = (mux2r==2); //opcode 0010 (2)
assign SUB = (mux2r==3); //opcode 0011 (3)
assign JMP = (mux2r==4); //opcode 0100 (4)
assign JMI = (mux2r==5); //opcode 0101 (5)
assign JEQ = (mux2r==6); //opcode 0110 (6)
assign STP = (mux2r==7); //opcode 0111 (7)
assign LDI = (mux2r==8); //opcode 1000 (8)
assign LSL = (mux2r==9); //opcode 1001 (9)
assign LSR = (mux2r==10); //opcode 1010 (10)
assign extra = (LDA||ADD||SUB); //LDA, ADD and SUB require an extra cycle
assign mux1 = 0; //Update the RAM address after the execution has completed
assign ramWrEn = (exec1 && STA); //only STA writes to RAM
assign pcSLoad = (!STP&&(((JEQ && eq)||(JMI && mi)||JMP) && fetch)); //Load a new value into the program counter at the last cycle of a jump instruction
assign pcEnable = (!STP&&((!pcSLoad) && ((fetch && !(extra)) || (exec1&&extra)))); //increment the program counter if the program is not jumping and it is the last cycle of the instruction

endmodule
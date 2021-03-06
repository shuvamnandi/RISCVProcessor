// Register File module
`include "define.v"

module regfile (
	input clk,
	input rst,
	input write_en,
	input [`ASIZE-1:0] raddr1, 
	input [`ASIZE-1:0] raddr2, 
	input [`ASIZE-1:0] waddr, 
	input [`DSIZE-1:0] wdata, 
	output [`DSIZE-1:0] rdata1,
	output [`DSIZE-1:0] rdata2
	);

	reg [`DSIZE-1:0] regdata [0:`NREG-1];
	
	integer i;
	initial begin
		for (i = 0; i < `NREG; i = i+1)
			regdata[i] = 0;
	end

	always@(posedge clk)
		begin
			if(rst)
				begin
					for (i=0; i<`NREG; i=i+1)
						regdata[i] <=0;
					regdata[1] <=1;//initialization regdata[1] is initialized with 3.
					regdata[2] <=1;//initialization regdata[2] is initialized with 1.
					regdata[3] <=4;//initialization regdata[3] is initialized with 4.
					regdata[4] <=3;//initialization regdata[4] is initialized with 3.
					regdata[5] <=2;//initialization regdata[5] is initialized with 2.
					regdata[6] <=1;//initialization regdata[6] is initialized with 1.
					regdata[7] <=6;//initialization regdata[7] is initialized with 6.
					regdata[8] <=4;//initialization regdata[8] is initialized with 4.
					regdata[9] <=2;//initialization regdata[9] is initialized with 2.					
				end
			else
				regdata[waddr] <= ((write_en == 1)) ? wdata : regdata[waddr];
		end
	assign rdata1 = ((write_en) && (waddr == raddr1)) ? wdata : regdata[raddr1];
	assign rdata2 = ((write_en) && (waddr == raddr2)) ? wdata : regdata[raddr2];

endmodule 
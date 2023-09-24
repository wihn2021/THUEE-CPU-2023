
module RegisterFile(
	input  rst                    , 
	input  clk                      ,
	input  RegWrite                 ,
	input  [5 -1:0]  Read_register1 , 
	input  [5 -1:0]  Read_register2 , 
	input  [5 -1:0]  Write_register ,
	input  [32 -1:0] Write_data     ,
	output [32 -1:0] Read_data1     , 
	output [32 -1:0] Read_data2
);

	// RF_data is an array of 32 32-bit registers
    // software SHOULD NOT change RF_data[0]!!!
	reg [31:0] RF_data[31:0];
	
	// read data from RF_data as Read_data1 and Read_data2
    // dealing with forwarding, without border check for better performance
	assign Read_data1 = (Read_register1 == 5'b0)? 32'b0: (RegWrite && Read_register1 == Write_register)? Write_data: RF_data[Read_register1];
	assign Read_data2 = (Read_register2 == 5'b0)? 32'b0: (RegWrite && Read_register2 == Write_register)? Write_data: RF_data[Read_register2];
	
	// write Wrtie_data to RF_data at clock posedge
	always @(posedge clk)
    /*
		if (rst)
        // don't expand below
        begin
            RF_data[0] <= 32'h00000000;
            RF_data[1] <= 32'h00000000;
            RF_data[2] <= 32'h00000000;
            RF_data[3] <= 32'h00000000;
            RF_data[4] <= 32'h00000000;
            RF_data[5] <= 32'h00000000;
            RF_data[6] <= 32'h00000000;
            RF_data[7] <= 32'h00000000;
            RF_data[8] <= 32'h00000000;
            RF_data[9] <= 32'h00000000;
            RF_data[10] <= 32'h00000000;
            RF_data[11] <= 32'h00000000;
            RF_data[12] <= 32'h00000000;
            RF_data[13] <= 32'h00000000;
            RF_data[14] <= 32'h00000000;
            RF_data[15] <= 32'h00000000;
            RF_data[16] <= 32'h00000000;
            RF_data[17] <= 32'h00000000;
            RF_data[18] <= 32'h00000000;
            RF_data[19] <= 32'h00000000;
            RF_data[20] <= 32'h00000000;
            RF_data[21] <= 32'h00000000;
            RF_data[22] <= 32'h00000000;
            RF_data[23] <= 32'h00000000;
            RF_data[24] <= 32'h00000000;
            RF_data[25] <= 32'h00000000;
            RF_data[26] <= 32'h00000000;
            RF_data[27] <= 32'h00000000;
            RF_data[28] <= 32'h00000000;
            RF_data[29] <= 32'h00000000;
            RF_data[30] <= 32'h00000000;
            RF_data[31] <= 32'h00000000;
        end
        */
        // don't expand above
		if (RegWrite)
			RF_data[Write_register] <= Write_data;

endmodule
			
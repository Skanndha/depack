module DePacketizer (
    input wire [47:0] flitoutde,  // Input is now 48 bits
    input wire clk,               // Main clock signal
    input wire reset,             // Reset signal
    output reg [15:0] data_out,   // Reconstructed output data
    output reg packet_end         // Packet end signal
);

reg flag;
reg [2:0]count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 16'b0;
            packet_end <= 1'b0;
	    flag <= 1'b1;
            count <= 0;
        end else begin
            data_out <= flitoutde[31:16];
	    count <= 0;
	    if((flitoutde[15:0] == 16'hFFFF) && flag) //fsm needed 
	    begin
            packet_end <= 1'b1;
	    count <= count+1; // works for equal interval of time 
	    flag <= 1'b0;
	    end 

            else 
	    packet_end <= 1'b0;
            
            if(count > 0)
	    flag <= 1'b1;
        end
    end
endmodule

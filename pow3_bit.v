module pow_bit(
input start, clk, //start is a handshake signal to start operation I tested this with push button and debouncer unit
input [4:0] base, //base
input [2:0] pow, //exponent
output [15:0] outcome, 
output finish
);
reg [15:0]temp;
reg [15:0]t_base;   //temporary registers and counter for exponential decrement
reg [2:0]count;

assign finish = (count == 3'b0); //finish is 1 when count is 0 this signals end of operation
assign outcome = temp;
always @(posedge clk) begin
	if(start)begin //start push button set to high to start operation
		count<=pow; //counter is loaded with exponent
		t_base[4:0]<=base; // t_base will hold base for multiplication
		temp<=16'd0; // temp is initiated
		t_base[15:5]<=11'd0; //rest of t_base set to 0 
		end
   else if (!finish) begin //while operation is not finished @ posedge clk do this
		count<=count-1; // decrement  counter
	   t_base<=t_base*base; // multiplication   
		temp<=t_base; // outcomes are saved in a temporary register
	end	
end	
endmodule

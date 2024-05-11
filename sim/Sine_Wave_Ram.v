module SineWave
#(parameter ADDR_WIDTH = 9, DATA_WIDTH = 16)
(
input                   clk,
input  [ADDR_WIDTH-1:0] r_addr,
output [DATA_WIDTH-1:0] r_data
);
reg [DATA_WIDTH-1 : 0] sine [0 : (2**ADDR_WIDTH)-1];
  
initial
        $readmemb("binary_signal.txt", sine); 

assign r_data = sine[r_addr];
endmodule

 ///////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////
 
module counter
#(parameter COUNT = 9)
(
input              clk, reset_n,
output [COUNT-1:0] count
);
reg  [COUNT-1:0] count_reg, count_next;
wire [COUNT-1:0] count_max = 'd469;
always@(posedge clk, negedge reset_n)
begin
  if(!reset_n)
    count_reg <= 0;
  else
    count_reg <= count_next;
end

always@(*)
begin
   if(count_next == count_max) 
      count_next = 0;
  else
    count_next = count_reg +1;  
end

assign count = count_reg;
endmodule


module FIR_Filter 
#(
    parameter DATA_IN_WIDTH  = 16,
    parameter DATA_OUT_WIDTH = 32,
    parameter TAP_WIDTH      = 16,
    parameter TAP_COUNT      = 50
)
(
    input wire                               clk,
    input wire                               reset_n,
    input wire   signed [DATA_IN_WIDTH-1:0]  data_in,
    output reg   signed [DATA_OUT_WIDTH-1:0] data_out
);

// Internal variables
integer i;

// Coefficient values
reg signed [TAP_WIDTH-1:0]  taps       [0:TAP_COUNT-1];

// Delay line
reg signed [DATA_IN_WIDTH-1:0] delay [0:TAP_COUNT-1];

// Initialize coefficients
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Reset taps to initial values
        for (i = 0; i < TAP_COUNT; i = i + 1)
            taps[i] <= 16'b0000000000100001; // Default tap value
    end
end

// Filter operation
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Reset delay and output
        for (i = 0; i < TAP_COUNT; i = i + 1)
            delay[i] <= 0;
        data_out <= 0;
    end else begin
        // Shift data into delay 
        for (i = TAP_COUNT-1; i > 0; i = i - 1)
            delay[i] <= delay[i-1];
        delay[0] <= data_in;

        // Compute filter output
        data_out <= 0;
        for (i = 0; i < TAP_COUNT; i = i + 1) begin
            data_out <= data_out + (delay[i] * taps[i]);
            data_out <= data_out + (delay[i] * taps[i]); // Parallel addition
        end
    end
end

endmodule

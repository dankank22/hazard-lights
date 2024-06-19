module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
input logic CLOCK_50; // 50MHz clock.
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY; // True when not pressed, False when pressed
input logic [9:0] SW;
// Generate clk off of CLOCK_50, whichClock picks rate.
logic reset;
logic [31:0] div_clk;
assign reset = ~KEY[0];
parameter whichClock = 25; // 0.75 Hz clock
clock_divider cdiv (.clock(CLOCK_50),
                    .reset(reset),
                    .divided_clocks(div_clk));
// Clock selection; allows for easy switching between simulation and board
// clocks
logic clkSelect;
// Uncomment ONE of the following two lines depending on intention
//assign clkSelect = CLOCK_50; // for simulation
assign clkSelect = div_clk[whichClock]; // for board
// Set up FSM inputs and outputs.

simple s (.clk(clkSelect), .reset, .sw1(SW[1]), .sw0(SW[0]), .out(LEDR[2:0]));
endmodule

module DE1_SoC_testbench();
logic clk, reset, sw0, sw1;
logic [2:0] out;
simple dut (clk, reset, sw1, sw0, out);
// Set up a simulated clock.
parameter CLOCK_PERIOD=100;
initial begin
clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
end
// Set up the inputs to the design. Each line is a clock cycle.
initial begin
@(posedge clk);
reset <= 1; @(posedge clk); // Always reset FSMs at start
reset <= 0;     sw1 <= 1 ; sw0 <= 0; repeat(5)@(posedge clk);
                sw1 <= 0 ; sw0 <= 0; repeat(1)@(posedge clk);
            	 sw1 <= 0 ; sw0 <= 1; repeat(5)@(posedge clk);
					 sw1 <= 0 ; sw0 <= 0; repeat(3)@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
$stop; // End the simulation.
end
endmodule

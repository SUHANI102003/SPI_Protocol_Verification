`timescale 1ns / 1ps

// Create Date: 02.08.2025 11:44:24
// Module Name: simple_tb
// Description: 


module simple_tb();

reg clk = 0;
reg rst = 0;
reg newd = 0;
reg [11:0] din = 0;
wire [11:0] dout;
wire done;

always #10 clk = ~clk;

spi_top dut (   .clk(clk),
                .newd(newd),
                .rst(rst),
                .din(din),
                .dout(dout),
                .done(done));
                
initial begin
    rst = 1'b1;
    repeat(5)@(posedge clk);
    rst = 1'b0;
    
    for (int i=0; i<10; i++) begin
        newd = 1;                   // apply newd for 1 cc
        din = $urandom;
        @(posedge dut.s1.sclk);
        newd = 0;
        @(posedge done);
    end
end


                
                
endmodule

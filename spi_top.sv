`timescale 1ns / 1ps

// Create Date: 02.08.2025 11:37:42
// Module Name: spi_top
// Description: 


module spi_top(
input clk, rst, newd,
input [11:0] din,
output [11:0] dout,
output done
    );
    
wire sclk, cs, mosi;

spi_master m1 (
                .clk(clk),
                .newd(newd),
                .rst(rst),
                .din(din),
                .sclk(sclk),
                .cs(cs),
                .mosi(mosi)
                );
                
spi_slave s1 (
                .sclk(sclk),
                .cs(cs),
                .mosi(mosi),
                .dout(dout),
                .done(done)                
                 );
endmodule

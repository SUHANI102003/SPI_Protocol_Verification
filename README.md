# SPI PROTOCOL VERIFICATION USING SYSTEM VERILOG

Created SPI master and slave RTL in SystemVerilog using 3-wires (MOSI, SCLK, CS).
Developed a class-based layered verification environment testbench to verify accurate serial data transfer.

## INTRODUCTION
### What is SPI?
SPI stands for Serial Peripheral Interface, originally developed by Motorola. It is a synchronous serial communication protocol, meaning data transfer is aligned with the edges of a clock. 
It uses four main signals — MOSI, MISO, SCLK, and Chip Select — to enable communication between a master, usually a microcontroller, and slave devices such as ADCs, DACs, sensors, EEPROMs, or displays. SPI supports full-duplex transfer, so data can be sent and received simultaneously. Because it is simple, fast, and flexible, it is very popular in embedded systems and digital communication applications.

### Why SPI?
SPI is used because it’s simple, fast, and efficient for short-distance communication. It supports full-duplex data transfer, meaning data can be sent and received at the same time. One unique benefit of SPI is the fact that data can be transferred without interruption. Any number of bits can be sent or received in a continuous stream. With I2C and UART, data is sent in packets, limited to a specific number of bits. Start and stop conditions define the beginning and end of each packet, so the data is interrupted during transmission. The trade-off is that it requires more pins, especially if multiple slaves are connected, but in cases where speed and simplicity are more important, SPI is usually preferred.

## DESIGN SPECIFICATION
### BLOCK DIAGRAM

<img width="500" height="300" alt="Screenshot 2025-08-20 133637" src="https://github.com/user-attachments/assets/06bdd3f8-9994-42c6-a162-0491f6015c6c" />

## SPI MASTER

### Signals 

| NAME |  TYPE |     DESCRIPTION         |
|------|-------|-------------------------|
| clk  | Input | The main system clock.   |
| rst  | Input | Active low reset signal. |
| newd | Input | control signals that goes high when new data is to be transmitted via SPI. |
| din  | Input | 12 bit data input.  |
| cs   | Output| Chip select signal for selecting slave. It is active low when transmitting data.|
| mosi  | Output | Master out Slave In - used to transmit data serially from master to slave. |
| sclk  | Output | Serial clock that synchronizes with slave. |

### Working
- The clock signal synchronizes the output of data bits from the master to the sampling of bits by the slave.
- One bit of data is transferred in each clock cycle, so the speed of data transfer is determined by the frequency of the clock signal.
- SPI communication is always initiated by the master since the master configures and generates the clock signal.
- The master can choose which slave it wants to talk to by setting the slave’s CS/SS line to a low voltage level.
- In the idle, non-transmitting state, the slave select line is kept at a high voltage level.
- Multiple CS/SS pins may be available on the master, which allows for multiple slaves to be wired in parallel.
- If only one CS/SS pin is present, multiple slaves can be wired to the master by daisy-chaining.

  ### Flowchart
  <img width="400" height="600" alt="Screenshot 2025-08-20 143329" src="https://github.com/user-attachments/assets/7029fb77-2687-479d-9dad-a1b686bf4662" />

  1.  If newd signal is HIGH, start sampling the data on din bus and start transmitting it to slave device.
  2.  cs = 1 (default value); no transmission
  3.  cs = 0 ; transmission start
  4.  sclk is usually 4 times slower than system clock. This may differ for different FPGA boards.
  5.  In our design, random count (divide by 20) is used for generating serial clock.

  ### Serial clock generation
  System clock = Fclk <br>
  SPI clock = Fsclk <br>
  Fsclk = Fclk / 20 (divide by 20) <br>
  => Tsclk = 20*Tclk  <br>
  Therefore, sclk is on for 10xTclk and off for 10xTclk


## SPI SLAVE
### Signals 

| NAME |  TYPE |     DESCRIPTION         |
|------|-------|-------------------------|
| cs   | Input| Chip select signal for selecting slave. It is active low when transmitting data.|
| mosi  | Input | Master out Slave In - used to receive data serially from master. |
| sclk  | Input | Serial clock that synchronizes with master. |
| dout  | Output | 12 bit data out. |
| done  | Output | Indicates that the data is received by slave |

https://edaplayground.com/x/q76n

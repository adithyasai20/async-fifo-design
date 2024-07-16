`timescale 1ns/1ps

module asyncfifo_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 16;

    // Inputs
    reg clk;
    reg reset;
    reg [DATA_WIDTH-1:0] data_in;
    reg write_enable;
    reg read_enable;

    // Outputs
    wire [DATA_WIDTH-1:0] data_out;
    wire empty;
    wire full;

    // Instantiate the asynchronous FIFO module
    asyncfifo #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH))
        dut (
            .clk(clk),
            .reset(reset),
            .data_in(data_in),
            .write_enable(write_enable),
            .read_enable(read_enable),
            .data_out(data_out),
            .empty(empty),
            .full(full)
        );

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        data_in = 0;
        write_enable = 0;
        read_enable = 0;

        // Wait for reset to deassert
        #10 reset = 0;

        // Write data into the FIFO
        #10 data_in = 8'hAA;
        write_enable = 1;
        #10 write_enable = 0;

        // Read data from the FIFO
        read_enable = 1;
        #10 read_enable = 0;

        // Add more test cases here...

        // End simulation
        #10 $finish;
    end

endmodule
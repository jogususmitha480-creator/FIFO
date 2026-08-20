`timescale 1ns/1ps

module fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter DEPTH = 8;

    reg clk;
    reg reset;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;

    wire [DATA_WIDTH-1:0] data_out;
    wire full;
    wire empty;

    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH)
    ) uut (
        .clk(clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);

        clk = 0;
        reset = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        #10;
        reset = 0;

        // Write data
        write_data(8'hA1);
        write_data(8'hB2);
        write_data(8'hC3);
        write_data(8'hD4);

        // Read data
        read_data();
        read_data();
        read_data();
        read_data();

        #20;

        $display("FIFO simulation completed successfully.");
        $finish;
    end

    task write_data(input [DATA_WIDTH-1:0] data);
        begin
            @(negedge clk);
            wr_en = 1;
            data_in = data;

            @(negedge clk);
            wr_en = 0;

            $display("WRITE: Data = %h", data);
        end
    endtask

    task read_data;
        begin
            @(negedge clk);
            rd_en = 1;

            @(negedge clk);
            rd_en = 0;

            $display("READ : Data = %h", data_out);
        end
    endtask

endmodule
module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8
)(
    input  wire                  clk,
    input  wire                  reset,
    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out,
    output wire                  full,
    output wire                  empty
);

    reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];
    reg [$clog2(DEPTH)-1:0] wr_ptr;
    reg [$clog2(DEPTH)-1:0] rd_ptr;
    reg [$clog2(DEPTH+1)-1:0] count;

    assign empty = (count == 0);
    assign full  = (count == DEPTH);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_ptr   <= 0;
            rd_ptr   <= 0;
            count    <= 0;
            data_out <= 0;
        end
        else begin

            // Write operation
            if (wr_en && !full) begin
                memory[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1'b1;
            end

            // Read operation
            if (rd_en && !empty) begin
                data_out <= memory[rd_ptr];
                rd_ptr <= rd_ptr + 1'b1;
            end

            // Update FIFO count
            case ({wr_en && !full, rd_en && !empty})
                2'b10: count <= count + 1'b1;
                2'b01: count <= count - 1'b1;
                default: count <= count;
            endcase
        end
    end

endmodule
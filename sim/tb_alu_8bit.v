`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Testbench Name : tb_alu_8bit
// Description    : Applies all 8 operation codes to alu_8bit and prints
//                  results for manual/automated verification.
//////////////////////////////////////////////////////////////////////////////

module tb_alu_8bit;

    reg clk;
    reg rst;
    reg [7:0] A, B;
    reg [2:0] sel;
    wire [7:0] Y;

    // Instantiate DUT (Device Under Test)
    alu_8bit uut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .sel(sel),
        .Y(Y)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $display("time\tsel\tA\tB\tY");
        $monitor("%0t\t%b\t%d\t%d\t%d", $time, sel, A, B, Y);

        // Reset
        rst = 1; A = 0; B = 0; sel = 0;
        @(posedge clk);
        rst = 0;

        // Test ADD
        A = 8'd15; B = 8'd10; sel = 3'b000; @(posedge clk); #1;

        // Test SUB
        A = 8'd20; B = 8'd8;  sel = 3'b001; @(posedge clk); #1;

        // Test AND
        A = 8'hF0; B = 8'h0F; sel = 3'b010; @(posedge clk); #1;

        // Test OR
        A = 8'hF0; B = 8'h0F; sel = 3'b011; @(posedge clk); #1;

        // Test XOR
        A = 8'hAA; B = 8'h55; sel = 3'b100; @(posedge clk); #1;

        // Test NOT
        A = 8'hAA; B = 8'h00; sel = 3'b101; @(posedge clk); #1;

        // Test Shift Left
        A = 8'h01; B = 8'h00; sel = 3'b110; @(posedge clk); #1;

        // Test Shift Right
        A = 8'h80; B = 8'h00; sel = 3'b111; @(posedge clk); #1;

        // Test reset mid-operation
        rst = 1; @(posedge clk); #1;

        $display("All test cases completed.");
        $finish;
    end

endmodule
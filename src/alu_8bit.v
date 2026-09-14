`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2026 11:58:35 AM
// Design Name: 
// Module Name: alu_8bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_8bit(
    input clk,
    input rst,
    input [7:0] A,
    input [7:0] B,
    input [2:0] sel,
    output reg [7:0] Y
);

reg [7:0] result;

// Combinational ALU logic
always @(*) begin
    case (sel)
        3'b000: result = A + B;
        3'b001: result = A - B;
        3'b010: result = A & B;
        3'b011: result = A | B;
        3'b100: result = A ^ B;
        3'b101: result = ~A;
        3'b110: result = A << 1;
        3'b111: result = A >> 1;
        default: result = 8'b0;
    endcase
end

// Register stage (Sequential)
always @(posedge clk) begin
    if (rst)
        Y <= 8'b0;
    else
        Y <= result;
end

endmodule

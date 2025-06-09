`timescale 1ns / 1ps


module alu (
  input  wire [7:0] a,          // Operand A
  input  wire [7:0] b,          // Operand B
  input  wire [3:0] opcode,     // 4-bit opcode from instruction
  output reg  [7:0] result,     // ALU result
  output wire zero              // Used by BEQ
);

  assign zero = (result == 8'b00000000);

  always @(*) begin
    case (opcode)
      4'b0000: result = a + b;                      // ADD
      4'b0001: result = a - b;                      // SUB
      4'b0010: result = a & b;                      // AND
      4'b0011: result = a | b;                      // OR
      4'b0100: result = a ^ b;                      // XOR
      4'b0101: result = (a < b) ? 8'b1 : 8'b0;      // SLT
      4'b1001: result = a + b;                      // ADDI (same as ADD)
      4'b1011: result = a - b;                      // BEQ (same as SUB, then check zero)
      4'b1100: result = a - b;                      // BNE (same as SUB, then check ~zero)
      default: result = 8'b00000000;                // NOP or unknown
    endcase
  end

endmodule

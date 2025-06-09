`timescale 1ns / 1ps

module alu (
  input  wire [7:0] a,             // Operand A
  input  wire [7:0] b,             // Operand B or Immediate
  input  wire [3:0] opcode,        // 4-bit opcode
  output reg  [7:0] result,        // ALU Result
  output wire       zero,          // Zero flag (for BEQ, BNE)
  output reg        branch_taken   // Control signal: 1 = take branch
);

  // Zero is high when result == 0 (used in BEQ/BNE)
  assign zero = (result == 8'b00000000);

  always @(*) begin
    branch_taken = 1'b0; // default is not to branch
    case (opcode)

      4'b0000: result = a + b;                     // ADD
      4'b0001: result = a - b;                     // SUB
      4'b0010: result = a & b;                     // AND
      4'b0011: result = a | b;                     // OR
      4'b0100: result = a ^ b;                     // XOR
      4'b0101: result = (a < b) ? 8'b1 : 8'b0;     // SLT
      4'b1001: result = a + b;                     // ADDI (same logic as ADD)

      4'b1011: begin                               // BEQ
        result = a - b;
        if (result == 0)
          branch_taken = 1;                        // Branch if a == b
      end

      4'b1100: begin                               // BNE
        result = a - b;
        if (result != 0)
          branch_taken = 1;                        // Branch if a != b
      end

      default: result = 8'b00000000;               // NOP or undefined
    endcase
  end

endmodule


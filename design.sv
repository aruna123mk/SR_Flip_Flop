

module SR_FLIP(
    input [1:0] sr,  // SR inputs
    input clk,        // Clock input
    input rst,        // Reset input
    output reg q,     // Output Q
    output qbar       // Output Q'
);
    // Reset and clocked logic for SR flip-flop
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 0;  // Reset Q to 0
        end else begin
            casex (sr)
                2'b00: q <= q;     // No change on Q
                2'b01: q <= 1'b0;   // Set Q to 0
                2'b10: q <= 1'b1;   // Set Q to 1
                2'b11: q <= 1'bx;   // Invalid state, set Q to 'X'
                default: q <= 1'bx; // Default case, set Q to 'X'
            endcase
        end
    end

    // Complement of Q
    assign qbar = ~q;

endmodule

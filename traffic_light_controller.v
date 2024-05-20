module traffic_light_controller(
    input clk,          // Clock input
    input reset,        // Reset input
    input mr3_spot,     // User spot at MR3
    output reg red_road1,   // Red light for road1
    output reg green_road1, // Green light for road1
    output reg yellow_road1, // Yellow light for road1
    output reg red_road2,   // Red light for road2
    output reg red_road3,   // Red light for road3
    output reg yellow_road2, // Yellow light for road2
    output reg yellow_road3  // Yellow light for road3
);

// Define state variables
reg [1:0] state;
parameter [1:0] S00 = 2'b00;
parameter [1:0] S01 = 2'b01;
parameter [1:0] S10 = 2'b10;
parameter [1:0] S11 = 2'b11;

// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S00; // Reset to initial state
    end else begin
        case(state)
            S00: begin
                // Default state, all red lights
                red_road1 <= 1'b1;
                green_road1 <= 1'b0;
                yellow_road1 <= 1'b0;
                red_road2 <= 1'b1;
                red_road3 <= 1'b1;
                yellow_road2 <= 1'b0;
                yellow_road3 <= 1'b0;
                
                // Transition conditions
                if (mr3_spot) begin
                    state <= S01; // Transition to S01 when user at MR3 spot
                end
            end
            S01: begin
                // Green light for road1, yellow for road1 and road2
                red_road1 <= 1'b0;
                green_road1 <= 1'b1;
                yellow_road1 <= 1'b0;
                red_road2 <= 1'b1;
                red_road3 <= 1'b1;
                yellow_road2 <= 1'b1;
                yellow_road3 <= 1'b0;
                
                // Transition conditions
                if (!mr3_spot) begin
                    state <= S00; // Transition back to S00 when user not at MR3 spot
                end
            end
            S10, S11: begin
                // All red lights
                red_road1 <= 1'b1;
                green_road1 <= 1'b0;
                yellow_road1 <= 1'b0;
                red_road2 <= 1'b1;
                red_road3 <= 1'b1;
                yellow_road2 <= 1'b0;
                yellow_road3 <= 1'b0;
                
                // Transition conditions
                if (mr3_spot) begin
                    state <= S01; // Transition to S01 when user at MR3 spot
                end
            end
        endcase
    end
end

endmodule

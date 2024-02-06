// Module: Count up on each button press and display on LEDs
module button_counter (

    // Inputs
    input               clk,
    input               rst_btn,
    input               count_btn,

    // Outputs
    output  reg [3:0]   led
);

    // Button debounce states
    localparam STATE_HIGH       = 2'd0;
    localparam STATE_LOW        = 2'd1;
    localparam STATE_WAIT       = 2'd2;
    localparam STATE_PRESSED    = 2'd3;

    // Max count for counter to debounce button
    localparam MAX_DEBOUNCE_COUNT = 22'd2399999;

    // Internal signals
    wire rst;

    // Internal storage elements
    reg [1:0]   state;
    reg [21:0]  debounce_count;

    // Invert active-low buttons
    assign rst = ~rst_btn;

    // State transition logic
    always @ (posedge clk or posedge rst) begin
        
        // On reset, return to high state
        if (rst == 1'b1) begin
            state <= STATE_HIGH;

        // State transitions
        end else begin
            case (state)
                
                // Wait for button to be pressed (go low)
                STATE_HIGH: begin
                    if (count_btn == 1'b0) begin
                        state <= STATE_LOW;
                    end
                end

                // Wait for button to be released (go high)
                STATE_LOW: begin
                    if (count_btn == 1'b1) begin
                        state <= STATE_WAIT;
                    end
                end

                // Wait for button signal to stop bouncing
                STATE_WAIT: begin
                    if (debounce_count == MAX_DEBOUNCE_COUNT) begin
                        state <= STATE_PRESSED;
                    end
                end

                // Spend one clock cycle in state pressed
                STATE_PRESSED: state <= STATE_HIGH;

                // Go to state high if in unknown state
                default: state <= STATE_HIGH;
            endcase
        end
    end

    // Handle debounce counter
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            debounce_count <= 22'b0; 
        end else begin
            if (state == STATE_WAIT) begin
                debounce_count <= debounce_count + 1;
            end else begin
                debounce_count <= 22'b0;
            end
        end
    end

    // Handle LED counter
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            led <= 4'd0;
        end else begin
            if (state == STATE_PRESSED) begin
                led <= led + 1;
            end
        end
    end

endmodule

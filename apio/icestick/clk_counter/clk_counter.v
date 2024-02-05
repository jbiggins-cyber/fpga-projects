// Module: Count up on each button press and display on LEDs
module button_counter (

    // Oscillator
    input               clk,

    // Inputs
    input               rst_btn,

    // Outputs
    output  reg [3:0]   led
);

    wire rst;

    // Reset is the inverse of the reset button
    assign rst = ~rst_btn;

    // Count up on clock rising edge or reset on button push
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            led <= 4'b0;
        end else begin
            led <= led + 1'b1;
        end
    end

endmodule

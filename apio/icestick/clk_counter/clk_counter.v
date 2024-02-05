// Module: Count up on each button press and display on LEDs
module button_counter (

    // Oscillator
    input               clk,    // 12MHz oscillator

    // Inputs
    input               rst_btn,

    // Outputs
    output  reg [3:0]   led
);

    wire            rst;
    reg      [23:0] osc_counter;   // Counts oscillator
    reg      [0:0] slow_clk;      // 1Hz clock

    // Reset is the inverse of the reset button
    assign rst = ~rst_btn;

    // Divide oscillator signal to get 1Hz clock
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            slow_clk <= 1'b0;
            osc_counter <= 24'b0;
        end else begin
            if (osc_counter >= 12000000) begin
                slow_clk <= slow_clk + 1'b1;
                osc_counter <= 24'b0;
            end else begin
                osc_counter <= osc_counter + 1'b1;
            end
        end
    end

    // Count up on clock rising edge or reset on button push
    always @ (posedge slow_clk or posedge rst) begin
        if (rst == 1'b1) begin
            led <= 4'b0;
        end else begin
            led <= led + 1'b1;
        end
    end

endmodule

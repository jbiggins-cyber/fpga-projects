// State machine that counts up when button is pressed
module fsm_moore (

    // Inputs
    input               clk,
    input               rst_btn,
    input               go_btn,

    // Outputs
    output reg [3:0]    led,
    output reg          done_sig
);

    // States
    localparam STATE_IDLE       = 2'd0;
    localparam STATE_COUNTING   = 2'd1;
    localparam STATE_DONE       = 2'd2;

    // Max counts for clock divider and counter
    localparam MAX_CLK_COUNT    = 24'd1500000;
    localparam MAX_LED_COUNT    = 4'hf;

    // Internal signals
    wire rst;
    wire go;

    // Internal storage elements
    reg         div_clk;
    reg [1:0]   state;
    reg [23:0]  clk_count;

    // Inverst active-low buttons
    assign rst = ~rst_btn;
    assign go = ~go_btn;

    // Clock divider
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            clk_count <= 24'b0;
        end else if (clk_count == MAX_CLK_COUNT) begin
            clk_count <= 24'b0;
            div_clk <= ~div_clk;
        end else begin
            clk_count <= clk_count + 1;
        end
    end

    // State transition logic
    always @ (posedge div_clk or posedge rst) begin

        // On reset, return to idle state
        if (rst == 1'b1) begin
            state <= STATE_IDLE;

        // Define the state transitions
        end else begin
            case (state)

                // Wait for go button to be pressed
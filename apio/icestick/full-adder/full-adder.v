// Module: full adder
module full_adder (

    // Inputs
    input [2:0]     pmod,

    // Outpus
    output [1:0]    led
);

    // Wire declarations
    wire A;     // Bit A
    wire B;     // Bit B
    wire Cin;   // Carry in bit

    // Continuous assignment: Making wires high on button press
    assign A = ~pmod[0];
    assign B = ~pmod[1];
    assign Cin = ~pmod[2];

    // Continuous assignment: Adder
    assign led[0] = (A ^ B) ^ Cin;
    assign led[1] = ((A ^ B) & Cin) | (A & B);

endmodule

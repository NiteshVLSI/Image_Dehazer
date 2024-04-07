module alpha_calc(
    input [7:0] dark_diff,
    input [7:0]denominator,
    output [6:0] alpha
);
    wire [7:0] pass [6:0]; // Declare pass as an array of 7-bit vectors
    genvar i;

    generate
        for (i = 0; i <= 6; i = i + 1) begin
            if (i == 0)
                sub_part_alpha a6(.in(dark_diff), .den(denominator), .d(alpha[6-i]), .out(pass[i]));
            else if (i < 6)
                sub_part_alpha a5(.in(pass[i-1]), .den(denominator), .d(alpha[6-i]), .out(pass[i]));
            else
                comp a7(.in(pass[i-1]), .den(denominator), .d(alpha[6-i]));
        end
    endgenerate
endmodule

module sub_part_alpha(
    input [7:0] in,
    input [7:0]den,
    output d,
    output [7:0] out
);
    wire [7:0] mux_a, mux_b, mux_out,in_shift;
    assign in_shift = in<<1;
    assign d = in_shift > den;
    assign mux_out = (d) ?( in_shift - den) : in_shift;
    assign out = mux_out << 1;
endmodule

module comp(
    input [7:0] in,
    input [7:0]den,
    output d
);
   // wire in_shift;
  //  assign in_shift=in<<1;
    assign d = (in>>1) > den;
endmodule

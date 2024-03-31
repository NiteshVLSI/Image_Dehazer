module global_tb;

    // Parameters
    parameter CLK_PERIOD = 400; // Clock period in ns

    // Signals
    reg clk,reset;
    reg [7:0] a_r, b_r, c_r, d_r, e_r, f_r, g_r, h_r, i_r;
    reg [7:0] a_g, b_g, c_g, d_g, e_g, f_g, g_g, h_g, i_g;
    reg [7:0] a_b, b_b, c_b, d_b, e_b, f_b, g_b, h_b, i_b;
    wire [7:0] arg3_4, agg3_4, agb3_4;

    // Instantiate the global module
    global uut (
        .clk(clk),
        .a_r(a_r), .b_r(b_r), .c_r(c_r), .d_r(d_r), .e_r(e_r),
        .f_r(f_r), .g_r(g_r), .h_r(h_r), .i_r(i_r),
        .a_g(a_g), .b_g(b_g), .c_g(c_g), .d_g(d_g), .e_g(e_g),
        .f_g(f_g), .g_g(g_g), .h_g(h_g), .i_g(i_g),
        .a_b(a_b), .b_b(b_b), .c_b(c_b), .d_b(d_b), .e_b(e_b),
        .f_b(f_b), .g_b(g_b), .h_b(h_b), .i_b(i_b),
        .arg3_4(arg3_4), .agg3_4(agg3_4), .agb3_4(agb3_4),.reset(reset)
    );

    // Clock generation
    always begin
        #CLK_PERIOD clk = ~clk;
    end


  initial begin
        // Initialize inputs
        reset =1;
        #5;
        reset=0;
        a_r = 8'hFF; b_r = 8'hFF; c_r = 8'hFF; d_r = 8'hFF; e_r = 8'hFF;
        f_r = 8'hFF; g_r = 8'hFF; h_r = 8'hFF; i_r = 8'hFF;
        a_g = 8'hFF; b_g = 8'hFF; c_g = 8'hFF; d_g = 8'hFF; e_g = 8'hFF;
        f_g = 8'hFF; g_g = 8'hFF; h_g = 8'hFF; i_g = 8'hFF;
        a_b = 8'hFF; b_b = 8'hFF; c_b = 8'hFF; d_b = 8'hFF; e_b = 8'hFF;
        f_b = 8'hFF; g_b = 8'hFF; h_b = 8'hFF; i_b = 8'hFF;

        // Wait for a few clock cycles
         #(10*CLK_PERIOD);
         $finish;
    end
    // Randomize inputs
    initial begin
        // Initialize inputs
        clk = 0;

        // Wait for a few clock cycles
        #(CLK_PERIOD+600);

        // Generate random values for variables
        repeat (5) begin
            a_r <= $random;
            b_r <= $random;
            c_r <= $random;
            d_r <= $random;
            e_r <= $random;
            f_r <= $random;
            g_r <= $random;
            h_r <= $random;
            i_r <= $random;

            a_g <= $random;
            b_g <= $random;
            c_g <= $random;
            d_g <= $random;
            e_g <= $random;
            f_g <= $random;
            g_g <= $random;
            h_g <= $random;
            i_g <= $random;

            a_b <= $random;
            b_b <= $random;
            c_b <= $random;
            d_b <= $random;
            e_b <= $random;
            f_b <= $random;
            g_b <= $random;
            h_b <= $random;
            i_b <= $random;

            #(2*CLK_PERIOD); // Advance one clock cycle
        end
        
    end
 
 

 
endmodule

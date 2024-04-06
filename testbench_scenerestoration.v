`timescale 1ns / 1ps

module scene_tb();
    
    parameter SIM_TIME    = 1000;
    // Inputs
    reg i_clk;
    reg i_rst;
    reg [7:0] on_by_t;
    reg [7:0] er;
    reg [7:0] eg;
    reg [7:0] eb;
    reg [7:0] Arlocal;
    reg [7:0] Aglocal;
    reg [7:0] Ablocal;

    // Outputs
    wire [7:0] o_r;
    wire [7:0] o_b;
    wire [7:0] o_g;

    // Instantiate the Unit Under Test (UUT)
    scene uut (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .on_by_t(on_by_t),
        .er(er),
        .eg(eg),
        .eb(eb),
        .Arlocal(Arlocal),
        .Aglocal(Aglocal),
        .Ablocal(Ablocal),
        .o_r(o_r),
        .o_b(o_b),
        .o_g(o_g)
    );

    // Clock generation
    always #5 i_clk = ~i_clk;

    initial begin
        // Initialize inputs
        i_clk = 0;
        i_rst = 0;
        on_by_t = 8'd20;
        eg = 8'h40;
        eb = 8'h20;
        Aglocal = 8'h08;
        Ablocal = 8'h04;
    end
        // Generate random values for er and Arlocal
        always@(posedge i_clk)
         begin
            #10; // Wait for some time

            // Generate random values
            er=$random;
            eg=$random;
            eb=$random;

            Arlocal=er-10;
            Aglocal=eg-20;
            Ablocal=eb-40;
            
        end

        // Finish the simulation
       initial
        begin
        #SIM_TIME;
       $stop;
    end

endmodule

module testbench();

logic a = 0;
logic b = 0;
logic c = 0;
logic [0:1] s = 2'b00;
logic out;

always #50  a = ~a;
always #30  b = ~b;
always #20  c = ~c;
always #80  s[0] = ~s[0];
always #120 s[1] = ~s[1];

mux_src1 test1 (a, b, c, s, out);
mux_x test2 (a, b, s[0]);
mux_y test3 (a, c, s[1]);

endmodule
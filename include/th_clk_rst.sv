  logic clk_upstream = 0;
  logic clk_downstream = 0;

  always #10 clk_upstream = ~clk_upstream;
  always #10 clk_downstream = ~clk_downstream;
  
    initial
    begin
      clk_upstream = 0;
      clk_downstream = 0;
      #100;
      $finish();
    end  

  assign upstream_if_0.ustream_if.clk = clk_upstream;
  assign downstream_if_0.dstream_if.clk = clk_downstream;
  


module b8b10dec(
  input clk,
  input reset_n,
  input en_n,
  input enable_reverse,
  input[9:0] rxdata,
  output logic rxdatak,
  output logic [7:0] dec_final_rxdata
);

  logic[9:0] clkd_rxdata;
  logic[8:0] decodeout;
  logic[9:0] rxdatarev;
  logic decdispin;
  logic decodedisp, decodeerr, disperr;
  
  initial begin
    decdispin <= 0;
    clkd_rxdata = 0;
  end
  
  generate
    for(genvar i=0; i<10; i++) begin
      assign rxdatarev[i] = enable_reverse ? clkd_rxdata[9-i] : clkd_rxdata[i];
    end
  endgenerate
  
  decode DUTD (rxdatarev, decdispin, decodeout, decodedisp, decodeerr, disperr) ;
  
  always @(posedge clk) begin
    if(!(clkd_rxdata == rxdata)) begin
      decdispin <= decodedisp;
      clkd_rxdata <= rxdata;
    end
  end
  
  assign dec_final_rxdata = decodeout[7:0];
  assign rxdatak = decodeout[8];
  
endmodule


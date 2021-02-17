
module b8b10enc(
  input clk,
  input reset_n,
  input en_n,
  input enable_reverse,
  input[7:0] txdata,
  input txdatak,
  output logic [9:0] enc_final_txdata
);
  logic disp ;
  logic disp2;
  logic[7:0] clkd_txdata;
  logic clkd_txdatak;
  logic dispout;
  logic[9:0] gated_encoded_txdata;
  logic[9:0] encoded_txdata;
  
  assign txdata2 = $isunknown(txdata) ? 0 : txdata;
  
  assign enc_final_txdata = !en_n ? encoded_txdata : 0;
  
  generate
   for(genvar i=0; i<10; i++) begin
     assign encoded_txdata[i] = enable_reverse ? gated_encoded_txdata[9-i] : gated_encoded_txdata[i];
   end
  endgenerate
  
  initial begin
      disp2 <= 0;
    disp = 0;
    clkd_txdata = 0;
    clkd_txdatak = 0;
  end
  
  encode enc_i({clkd_txdatak, clkd_txdata}, disp, gated_encoded_txdata, dispout);
  
  always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
      disp = 0; 
      clkd_txdata = 0;
    end
    else begin 
      if($isunknown(txdata) || $isunknown(txdatak)) begin 
        clkd_txdata <= 0;
        clkd_txdatak <= 0;
      end
      else begin
        if(!(clkd_txdata == txdata)) begin
          disp <= dispout;
          clkd_txdata <= txdata;
          clkd_txdatak <= txdatak;
        end
      end
    end
  end
  
endmodule


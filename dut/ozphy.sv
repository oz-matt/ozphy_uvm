module ozphy #(
    parameter N_LANES = 16, //number of pcie lanes
    parameter nts = 1024, //number of ts1s and ts2s required during polling phase of ltssm. Spec cites 1024
    parameter serdes_cycle = 40
  ) (
    dw_vip_pcie_txrx_if pcie_phy_if, 
    output[15:0] l_serial_tolink,
    input[15:0] l_serial_fromlink
  );

  reg[15:0][2:0] l_rxstatus;
  reg[15:0] l_phystatus;
  reg[15:0] l_rxelecidle;
  wire[15:0] l_txelecidle;
  wire[15:0] l_rxvalid;

  reg[15:0] l_txdetectrx;
  reg[15:0][2:0] l_powerdown;

  wire[7:0] l_rxdata[15:0];
  wire[7:0] l_txdata[15:0];
  wire[9:0] l_incoming_pipe_data_from_link[15:0];
  wire[9:0] l_encoded_txdata[15:0];
  wire[15:0] l_rxdatak;
  wire[15:0] l_txdatak;

  reg[5:0] tctr[0:15];
  reg[5:0] tctr2[0:15];


  LTSSM_State curr_ltssm_state[15:0];
  reg LinkClock;
  
  initial
  begin
    LinkClock = 0;
    #(serdes_cycle);  
    forever
      #(serdes_cycle/2) LinkClock = ~LinkClock;
  end
  
  
  always @(posedge pcie_phy_if.clk or negedge pcie_phy_if.reset_n) begin
    if(!pcie_phy_if.reset_n) l_txdetectrx <= 0;
    else l_txdetectrx                     <= pcie_phy_if.txdetectrx;
  end


  always @(posedge pcie_phy_if.clk or negedge pcie_phy_if.reset_n) begin
    if(!pcie_phy_if.reset_n) begin
      l_powerdown[0]  <= 2;
      l_powerdown[1]  <= 2;
      l_powerdown[2]  <= 2;
      l_powerdown[3]  <= 2;
      l_powerdown[4]  <= 2;
      l_powerdown[5]  <= 2;
      l_powerdown[6]  <= 2;
      l_powerdown[7]  <= 2;
      l_powerdown[8]  <= 2;
      l_powerdown[9]  <= 2;
      l_powerdown[10] <= 2;
      l_powerdown[11] <= 2;
      l_powerdown[12] <= 2;
      l_powerdown[13] <= 2;
      l_powerdown[14] <= 2;
      l_powerdown[15] <= 2;
    end
    else begin
      l_powerdown[0]  <= pcie_phy_if.powerdown0;
      l_powerdown[1]  <= pcie_phy_if.powerdown1;
      l_powerdown[2]  <= pcie_phy_if.powerdown2;
      l_powerdown[3]  <= pcie_phy_if.powerdown3;
      l_powerdown[4]  <= pcie_phy_if.powerdown4;
      l_powerdown[5]  <= pcie_phy_if.powerdown5;
      l_powerdown[6]  <= pcie_phy_if.powerdown6;
      l_powerdown[7]  <= pcie_phy_if.powerdown7;
      l_powerdown[8]  <= pcie_phy_if.powerdown8;
      l_powerdown[9]  <= pcie_phy_if.powerdown9;
      l_powerdown[10] <= pcie_phy_if.powerdown10;
      l_powerdown[11] <= pcie_phy_if.powerdown11;
      l_powerdown[12] <= pcie_phy_if.powerdown12;
      l_powerdown[13] <= pcie_phy_if.powerdown13;
      l_powerdown[14] <= pcie_phy_if.powerdown14;
      l_powerdown[15] <= pcie_phy_if.powerdown15;
    end
  end

  generate
    for(genvar k=0; k<16; k++) begin
  assign l_rxvalid[k] = !(l_rxelecidle[k]);
      b8b10enc b8b10enc_i(pcie_phy_if.clk, pcie_phy_if.reset_n[k], l_txelecidle[k], 1'b1, l_txdata[k], l_txdatak[k], l_encoded_txdata[k]);
      b8b10dec b8b10dec_i(pcie_phy_if.clk, pcie_phy_if.reset_n[k], l_rxelecidle[k], 1'b1, l_incoming_pipe_data_from_link[k], l_rxdatak[k], l_rxdata[k]);
    end  
  endgenerate
    
  generate
    for(genvar c=0; c<16; c=c+1) begin
      always @(posedge pcie_phy_if.clk or negedge pcie_phy_if.reset_n) begin
        if(!pcie_phy_if.reset_n) begin
          curr_ltssm_state[c] <= DETECT_QUIET;
          l_rxstatus[c]       <= 0;
          l_phystatus[c]      <= 0;
          l_rxelecidle[c]     <= 1'b1;
          tctr[c]   = 0;
        end
        else begin
          case (curr_ltssm_state[c])

            DETECT_QUIET: begin
              if (l_txdetectrx[c] == 1'b1) begin
                l_rxstatus[c]       <= 3;
                l_phystatus[c]      <= 1'b1;
                curr_ltssm_state[c] <= DETECT_ACTIVE;
              end
              else begin
                l_rxstatus[c]       <= 0;
                l_phystatus[c]      <= 0;
              end
            end

            DETECT_ACTIVE: begin
              if(tctr[c] > 7) begin
              if (l_powerdown[c] == 0) begin
                l_phystatus[c]      <= 1'b1;
                tctr[c]             <= 0;
                curr_ltssm_state[c] <= POLLING_ACTIVE;
              l_rxelecidle[c] <= 1'b0;
              end
              else begin
                l_rxstatus[c]       <= 0;
              end
              end
              else tctr[c]          <= tctr[c] + 1;
            end

            POLLING_ACTIVE: begin
              if(tctr2[c] > 7) begin
                tctr2[c]             <= 0;
                curr_ltssm_state[c] <= POLLING_ACTIVE_START_TS1;
                l_phystatus[c]      <= 1;
              end
              else tctr2[c]          <= tctr2[c] + 1;

              l_phystatus[c]  <= 0;
            end
            
            POLLING_ACTIVE_START_TS1: begin
              l_phystatus[c]  <= 0;
            end
            
          endcase
        end
      end
    end
  endgenerate

  initial begin
    l_phystatus = 0;
  end
  
   serdes phy_serdes(
       .SerialClock    (LinkClock),
       .parallel_in0   (l_encoded_txdata[0]),
       .parallel_in1   (l_encoded_txdata[1]),
       .parallel_in2   (l_encoded_txdata[2]),
       .parallel_in3   (l_encoded_txdata[3]),
       .parallel_in4   (l_encoded_txdata[4]),
       .parallel_in5   (l_encoded_txdata[5]),
       .parallel_in6   (l_encoded_txdata[6]),
       .parallel_in7   (l_encoded_txdata[7]),
       .parallel_in8   (l_encoded_txdata[8]),
       .parallel_in9   (l_encoded_txdata[9]),
       .parallel_in10  (l_encoded_txdata[10]),
       .parallel_in11  (l_encoded_txdata[11]),
       .parallel_in12  (l_encoded_txdata[12]),
       .parallel_in13  (l_encoded_txdata[13]),
       .parallel_in14  (l_encoded_txdata[14]),
       .parallel_in15  (l_encoded_txdata[15]),
       .serial_out0    (l_serial_tolink[0]),
       .serial_out1    (l_serial_tolink[1]),
       .serial_out2    (l_serial_tolink[2]),
       .serial_out3    (l_serial_tolink[3]),
       .serial_out4    (l_serial_tolink[4]),
       .serial_out5    (l_serial_tolink[5]),
       .serial_out6    (l_serial_tolink[6]),
       .serial_out7    (l_serial_tolink[7]),
       .serial_out8    (l_serial_tolink[8]),
       .serial_out9    (l_serial_tolink[9]),
       .serial_out10   (l_serial_tolink[10]),
       .serial_out11   (l_serial_tolink[11]),
       .serial_out12   (l_serial_tolink[12]),
       .serial_out13   (l_serial_tolink[13]),
       .serial_out14   (l_serial_tolink[14]),
       .serial_out15   (l_serial_tolink[15]),

        .parallel_out0  (l_incoming_pipe_data_from_link[0]),
	.parallel_out1  (l_incoming_pipe_data_from_link[1]),
	.parallel_out2  (l_incoming_pipe_data_from_link[2]),
	.parallel_out3  (l_incoming_pipe_data_from_link[3]),
	.parallel_out4  (l_incoming_pipe_data_from_link[4]),
	.parallel_out5  (l_incoming_pipe_data_from_link[5]),
	.parallel_out6  (l_incoming_pipe_data_from_link[6]),
	.parallel_out7  (l_incoming_pipe_data_from_link[7]),
	.parallel_out8  (l_incoming_pipe_data_from_link[8]),
	.parallel_out9  (l_incoming_pipe_data_from_link[9]),
	.parallel_out10 (l_incoming_pipe_data_from_link[10]),
	.parallel_out11 (l_incoming_pipe_data_from_link[11]),
	.parallel_out12 (l_incoming_pipe_data_from_link[12]),
	.parallel_out13 (l_incoming_pipe_data_from_link[13]),
	.parallel_out14 (l_incoming_pipe_data_from_link[14]),
	.parallel_out15 (l_incoming_pipe_data_from_link[15]),
       .serial_in0    (l_serial_fromlink[0]),
       .serial_in1    (l_serial_fromlink[1]),
       .serial_in2    (l_serial_fromlink[2]),
       .serial_in3    (l_serial_fromlink[3]),
       .serial_in4    (l_serial_fromlink[4]),
       .serial_in5    (l_serial_fromlink[5]),
       .serial_in6    (l_serial_fromlink[6]),
       .serial_in7    (l_serial_fromlink[7]),
       .serial_in8    (l_serial_fromlink[8]),
       .serial_in9    (l_serial_fromlink[9]),
       .serial_in10   (l_serial_fromlink[10]),
       .serial_in11   (l_serial_fromlink[11]),
       .serial_in12   (l_serial_fromlink[12]),
       .serial_in13   (l_serial_fromlink[13]),
       .serial_in14   (l_serial_fromlink[14]),
       .serial_in15   (l_serial_fromlink[15])
      );

  generate
    for(genvar j=0; j<16; j=j+1) begin
      initial begin
        curr_ltssm_state[j] = DETECT_QUIET;
        l_rxstatus[j]   <= 0;
        tctr[j]   <= 0;
        tctr2[j]   <= 0;
        l_powerdown[j]  <= 2;
        l_rxelecidle[j] <= 1'b1;
      end
    end
  endgenerate

 
  assign pcie_phy_if.pclk            = pcie_phy_if.clk;
  assign pcie_phy_if.rxclk           = pcie_phy_if.clk;
  assign pcie_phy_if.rxstatus0[2:0]  = l_rxstatus[0];
  assign pcie_phy_if.rxstatus1[2:0]  = l_rxstatus[1];
  assign pcie_phy_if.rxstatus2[2:0]  = l_rxstatus[2];
  assign pcie_phy_if.rxstatus3[2:0]  = l_rxstatus[3];
  assign pcie_phy_if.rxstatus4[2:0]  = l_rxstatus[4];
  assign pcie_phy_if.rxstatus5[2:0]  = l_rxstatus[5];
  assign pcie_phy_if.rxstatus6[2:0]  = l_rxstatus[6];
  assign pcie_phy_if.rxstatus7[2:0]  = l_rxstatus[7];
  assign pcie_phy_if.rxstatus8[2:0]  = l_rxstatus[8];
  assign pcie_phy_if.rxstatus9[2:0]  = l_rxstatus[9];
  assign pcie_phy_if.rxstatus10[2:0] = l_rxstatus[10];
  assign pcie_phy_if.rxstatus11[2:0] = l_rxstatus[11];
  assign pcie_phy_if.rxstatus12[2:0] = l_rxstatus[12];
  assign pcie_phy_if.rxstatus13[2:0] = l_rxstatus[13];
  assign pcie_phy_if.rxstatus14[2:0] = l_rxstatus[14];
  assign pcie_phy_if.rxstatus15[2:0] = l_rxstatus[15];
  assign l_txelecidle = pcie_phy_if.txelecidle;
  assign pcie_phy_if.rxelecidle      = l_rxelecidle;
  assign pcie_phy_if.rxvalid         = l_rxvalid;
  assign pcie_phy_if.lane0_txdata    = l_rxdata[0];
  assign pcie_phy_if.lane1_txdata    = l_rxdata[1];
  assign pcie_phy_if.lane2_txdata    = l_rxdata[2];
  assign pcie_phy_if.lane3_txdata    = l_rxdata[3];
  assign pcie_phy_if.lane4_txdata    = l_rxdata[4];
  assign pcie_phy_if.lane5_txdata    = l_rxdata[5];
  assign pcie_phy_if.lane6_txdata    = l_rxdata[6];
  assign pcie_phy_if.lane7_txdata    = l_rxdata[7];
  assign pcie_phy_if.lane8_txdata    = l_rxdata[8];
  assign pcie_phy_if.lane9_txdata    = l_rxdata[9];
  assign pcie_phy_if.lane10_txdata   = l_rxdata[10];
  assign pcie_phy_if.lane11_txdata   = l_rxdata[11];
  assign pcie_phy_if.lane12_txdata   = l_rxdata[12];
  assign pcie_phy_if.lane13_txdata   = l_rxdata[13];
  assign pcie_phy_if.lane14_txdata   = l_rxdata[14];
  assign pcie_phy_if.lane15_txdata   = l_rxdata[15];
  assign pcie_phy_if.lane0_txdatak   = l_rxdatak[0];
  assign pcie_phy_if.lane1_txdatak   = l_rxdatak[1];
  assign pcie_phy_if.lane2_txdatak   = l_rxdatak[2];
  assign pcie_phy_if.lane3_txdatak   = l_rxdatak[3];
  assign pcie_phy_if.lane4_txdatak   = l_rxdatak[4];
  assign pcie_phy_if.lane5_txdatak   = l_rxdatak[5];
  assign pcie_phy_if.lane6_txdatak   = l_rxdatak[6];
  assign pcie_phy_if.lane7_txdatak   = l_rxdatak[7];
  assign pcie_phy_if.lane8_txdatak   = l_rxdatak[8];
  assign pcie_phy_if.lane9_txdatak   = l_rxdatak[9];
  assign pcie_phy_if.lane10_txdatak  = l_rxdatak[10];
  assign pcie_phy_if.lane11_txdatak  = l_rxdatak[11];
  assign pcie_phy_if.lane12_txdatak  = l_rxdatak[12];
  assign pcie_phy_if.lane13_txdatak  = l_rxdatak[13];
  assign pcie_phy_if.lane14_txdatak  = l_rxdatak[14];
  assign pcie_phy_if.lane15_txdatak  = l_rxdatak[15];
  
  assign l_txdata[0] = pcie_phy_if.lane0_rxdata;
  assign l_txdata[1] = pcie_phy_if.lane1_rxdata;
  assign l_txdata[2] = pcie_phy_if.lane2_rxdata;
  assign l_txdata[3] = pcie_phy_if.lane3_rxdata;
  assign l_txdata[4] = pcie_phy_if.lane4_rxdata;
  assign l_txdata[5] = pcie_phy_if.lane5_rxdata;
  assign l_txdata[6] = pcie_phy_if.lane6_rxdata;
  assign l_txdata[7] = pcie_phy_if.lane7_rxdata;
  assign l_txdata[8] = pcie_phy_if.lane8_rxdata;
  assign l_txdata[9] = pcie_phy_if.lane9_rxdata;
  assign l_txdata[10] = pcie_phy_if.lane10_rxdata;
  assign l_txdata[11] = pcie_phy_if.lane11_rxdata;
  assign l_txdata[12] = pcie_phy_if.lane12_rxdata;
  assign l_txdata[13] = pcie_phy_if.lane13_rxdata;
  assign l_txdata[14] = pcie_phy_if.lane14_rxdata;
  assign l_txdata[15] = pcie_phy_if.lane15_rxdata;
  assign l_txdatak[0] = pcie_phy_if.lane0_rxdatak;
  assign l_txdatak[1] = pcie_phy_if.lane1_rxdatak;
  assign l_txdatak[2] = pcie_phy_if.lane2_rxdatak;
  assign l_txdatak[3] = pcie_phy_if.lane3_rxdatak;
  assign l_txdatak[4] = pcie_phy_if.lane4_rxdatak;
  assign l_txdatak[5] = pcie_phy_if.lane5_rxdatak;
  assign l_txdatak[6] = pcie_phy_if.lane6_rxdatak;
  assign l_txdatak[7] = pcie_phy_if.lane7_rxdatak;
  assign l_txdatak[8] = pcie_phy_if.lane8_rxdatak;
  assign l_txdatak[9] = pcie_phy_if.lane9_rxdatak;
  assign l_txdatak[10] = pcie_phy_if.lane10_rxdatak;
  assign l_txdatak[11] = pcie_phy_if.lane11_rxdatak;
  assign l_txdatak[12] = pcie_phy_if.lane12_rxdatak;
  assign l_txdatak[13] = pcie_phy_if.lane13_rxdatak;
  assign l_txdatak[14] = pcie_phy_if.lane14_rxdatak;
  assign l_txdatak[15] = pcie_phy_if.lane15_rxdatak;
  
  assign pcie_phy_if.phystatus       = l_phystatus;

endmodule : ozphy

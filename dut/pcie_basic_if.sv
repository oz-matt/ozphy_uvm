
`ifndef GUARD_PCIE_BASIC_IF
`define GUARD_PCIE_BASIC_IF


interface pcie_basic_if ();

	wire          clk;
	wire          clk5ghz;
	wire          clk8ghz;

	wire          rxclk;
	wire          rxclk5ghz;
	wire          rxclk8ghz;

	wire [31:0]   lane0_txdata;
	wire [3:0]    lane0_txdatak;
	wire [31:0]   lane0_rxdata;
	wire [3:0]    lane0_rxdatak;

	wire [31:0]   lane1_txdata;
	wire [3:0]    lane1_txdatak;
	wire [31:0]   lane1_rxdata;
	wire [3:0]    lane1_rxdatak;

	wire [31:0]   lane2_txdata;
	wire [3:0]    lane2_txdatak;
	wire [31:0]   lane2_rxdata;
	wire [3:0]    lane2_rxdatak;

	wire [31:0]   lane3_txdata;
	wire [3:0]    lane3_txdatak;
	wire [31:0]   lane3_rxdata;
	wire [3:0]    lane3_rxdatak;

	wire [31:0]   lane4_txdata;
	wire [3:0]    lane4_txdatak;
	wire [31:0]   lane4_rxdata;
	wire [3:0]    lane4_rxdatak;

	wire [31:0]   lane5_txdata;
	wire [3:0]    lane5_txdatak;
	wire [31:0]   lane5_rxdata;
	wire [3:0]    lane5_rxdatak;

	wire [31:0]   lane6_txdata;
	wire [3:0]    lane6_txdatak;
	wire [31:0]   lane6_rxdata;
	wire [3:0]    lane6_rxdatak;

	wire [31:0]   lane7_txdata;
	wire [3:0]    lane7_txdatak;
	wire [31:0]   lane7_rxdata;
	wire [3:0]    lane7_rxdatak;

	wire [31:0]   lane8_txdata;
	wire [3:0]    lane8_txdatak;
	wire [31:0]   lane8_rxdata;
	wire [3:0]    lane8_rxdatak;

	wire [31:0]   lane9_txdata;
	wire [3:0]    lane9_txdatak;
	wire [31:0]   lane9_rxdata;
	wire [3:0]    lane9_rxdatak;

	wire [31:0]   lane10_txdata;
	wire [3:0]    lane10_txdatak;
	wire [31:0]   lane10_rxdata;
	wire [3:0]    lane10_rxdatak;

	wire [31:0]   lane11_txdata;
	wire [3:0]    lane11_txdatak;
	wire [31:0]   lane11_rxdata;
	wire [3:0]    lane11_rxdatak;

	wire [31:0]   lane12_txdata;
	wire [3:0]    lane12_txdatak;
	wire [31:0]   lane12_rxdata;
	wire [3:0]    lane12_rxdatak;

	wire [31:0]   lane13_txdata;
	wire [3:0]    lane13_txdatak;
	wire [31:0]   lane13_rxdata;
	wire [3:0]    lane13_rxdatak;

	wire [31:0]   lane14_txdata;
	wire [3:0]    lane14_txdatak;
	wire [31:0]   lane14_rxdata;
	wire [3:0]    lane14_rxdatak;

	wire [31:0]   lane15_txdata;
	wire [3:0]    lane15_txdatak;
	wire [31:0]   lane15_rxdata;
	wire [3:0]    lane15_rxdatak;

	wire [15:0] txdatavalid;
	wire [15:0] txstartblock;
	wire [15:0] rxdatavalid;
	wire [15:0] rxstartblock;
	wire [1:0] lane0_txsyncheader;
	wire [1:0] lane1_txsyncheader;
	wire [1:0] lane2_txsyncheader;
	wire [1:0] lane3_txsyncheader;
	wire [1:0] lane4_txsyncheader;
	wire [1:0] lane5_txsyncheader;
	wire [1:0] lane6_txsyncheader;
	wire [1:0] lane7_txsyncheader;
	wire [1:0] lane8_txsyncheader;
	wire [1:0] lane9_txsyncheader;
	wire [1:0] lane10_txsyncheader;
	wire [1:0] lane11_txsyncheader;
	wire [1:0] lane12_txsyncheader;
	wire [1:0] lane13_txsyncheader;
	wire [1:0] lane14_txsyncheader;
	wire [1:0] lane15_txsyncheader;
	wire [1:0] lane0_rxsyncheader;
	wire [1:0] lane1_rxsyncheader;
	wire [1:0] lane2_rxsyncheader;
	wire [1:0] lane3_rxsyncheader;
	wire [1:0] lane4_rxsyncheader;
	wire [1:0] lane5_rxsyncheader;
	wire [1:0] lane6_rxsyncheader;
	wire [1:0] lane7_rxsyncheader;
	wire [1:0] lane8_rxsyncheader;
	wire [1:0] lane9_rxsyncheader;
	wire [1:0] lane10_rxsyncheader;
	wire [1:0] lane11_rxsyncheader;
	wire [1:0] lane12_rxsyncheader;
	wire [1:0] lane13_rxsyncheader;
	wire [1:0] lane14_rxsyncheader;
	wire [1:0] lane15_rxsyncheader;

	// PCIe PIPE command/status signals
	wire [15:0]   txdetectrx;
	wire [15:0]   txelecidle;
	wire [15:0]   txcompliance;
	wire [15:0]   rxpolarity;
	wire [15:0]   reset_n;
	wire [2:0]    powerdown0;
	wire [2:0]    powerdown1;
	wire [2:0]    powerdown2;
	wire [2:0]    powerdown3;
	wire [2:0]    powerdown4;
	wire [2:0]    powerdown5;
	wire [2:0]    powerdown6;
	wire [2:0]    powerdown7;
	wire [2:0]    powerdown8;
	wire [2:0]    powerdown9;
	wire [2:0]    powerdown10;
	wire [2:0]    powerdown11;
	wire [2:0]    powerdown12;
	wire [2:0]    powerdown13;
	wire [2:0]    powerdown14;
	wire [2:0]    powerdown15;
	wire [15:0]   rate;
	wire [15:0]   txdeemph;
	wire [2:0]    txmargin0;
	wire [2:0]    txmargin1;
	wire [2:0]    txmargin2;
	wire [2:0]    txmargin3;
	wire [2:0]    txmargin4;
	wire [2:0]    txmargin5;
	wire [2:0]    txmargin6;
	wire [2:0]    txmargin7;
	wire [2:0]    txmargin8;
	wire [2:0]    txmargin9;
	wire [2:0]    txmargin10;
	wire [2:0]    txmargin11;
	wire [2:0]    txmargin12;
	wire [2:0]    txmargin13;
	wire [2:0]    txmargin14;
	wire [2:0]    txmargin15;
	wire [15:0]   txswing;
	wire [15:0]   rxvalid;
	wire [15:0]   phystatus;
	wire [15:0]   rxelecidle;
	wire [2:0]    rxstatus0;
	wire [2:0]    rxstatus1;
	wire [2:0]    rxstatus2;
	wire [2:0]    rxstatus3;
	wire [2:0]    rxstatus4;
	wire [2:0]    rxstatus5;
	wire [2:0]    rxstatus6;
	wire [2:0]    rxstatus7;
	wire [2:0]    rxstatus8;
	wire [2:0]    rxstatus9;
	wire [2:0]    rxstatus10;
	wire [2:0]    rxstatus11;
	wire [2:0]    rxstatus12;
	wire [2:0]    rxstatus13;
	wire [2:0]    rxstatus14;
	wire [2:0]    rxstatus15;
	wire          pclk;

	wire [1:0] lane0_rate;
	wire [1:0] lane1_rate;
	wire [1:0] lane2_rate;
	wire [1:0] lane3_rate;
	wire [1:0] lane4_rate;
	wire [1:0] lane5_rate;
	wire [1:0] lane6_rate;
	wire [1:0] lane7_rate;
	wire [1:0] lane8_rate;
	wire [1:0] lane9_rate;
	wire [1:0] lane10_rate;
	wire [1:0] lane11_rate;
	wire [1:0] lane12_rate;
	wire [1:0] lane13_rate;
	wire [1:0] lane14_rate;
	wire [1:0] lane15_rate;
	wire [2:0] lane0_lfsrsel;
	wire [2:0] lane1_lfsrsel;
	wire [2:0] lane2_lfsrsel;
	wire [2:0] lane3_lfsrsel;
	wire [2:0] lane4_lfsrsel;
	wire [2:0] lane5_lfsrsel;
	wire [2:0] lane6_lfsrsel;
	wire [2:0] lane7_lfsrsel;
	wire [2:0] lane8_lfsrsel;
	wire [2:0] lane9_lfsrsel;
	wire [2:0] lane10_lfsrsel;
	wire [2:0] lane11_lfsrsel;
	wire [2:0] lane12_lfsrsel;
	wire [2:0] lane13_lfsrsel;
	wire [2:0] lane14_lfsrsel;
	wire [2:0] lane15_lfsrsel;
	wire maxpclk;
	wire [1:0] lane0_width;
	wire [1:0] lane1_width;
	wire [1:0] lane2_width;
	wire [1:0] lane3_width;
	wire [1:0] lane4_width;
	wire [1:0] lane5_width;
	wire [1:0] lane6_width;
	wire [1:0] lane7_width;
	wire [1:0] lane8_width;
	wire [1:0] lane9_width;
	wire [1:0] lane10_width;
	wire [1:0] lane11_width;
	wire [1:0] lane12_width;
	wire [1:0] lane13_width;
	wire [1:0] lane14_width;
	wire [1:0] lane15_width;
	wire [2:0] lane0_pclkrate;
	wire [2:0] lane1_pclkrate;
	wire [2:0] lane2_pclkrate;
	wire [2:0] lane3_pclkrate;
	wire [2:0] lane4_pclkrate;
	wire [2:0] lane5_pclkrate;
	wire [2:0] lane6_pclkrate;
	wire [2:0] lane7_pclkrate;
	wire [2:0] lane8_pclkrate;
	wire [2:0] lane9_pclkrate;
	wire [2:0] lane10_pclkrate;
	wire [2:0] lane11_pclkrate;
	wire [2:0] lane12_pclkrate;
	wire [2:0] lane13_pclkrate;
	wire [2:0] lane14_pclkrate;
	wire [2:0] lane15_pclkrate;
	wire [17:0] lane0_txdeemph;
	wire [17:0] lane1_txdeemph;
	wire [17:0] lane2_txdeemph;
	wire [17:0] lane3_txdeemph;
	wire [17:0] lane4_txdeemph;
	wire [17:0] lane5_txdeemph;
	wire [17:0] lane6_txdeemph;
	wire [17:0] lane7_txdeemph;
	wire [17:0] lane8_txdeemph;
	wire [17:0] lane9_txdeemph;
	wire [17:0] lane10_txdeemph;
	wire [17:0] lane11_txdeemph;
	wire [17:0] lane12_txdeemph;
	wire [17:0] lane13_txdeemph;
	wire [17:0] lane14_txdeemph;
	wire [17:0] lane15_txdeemph;
	wire [2:0] lane0_rxpresethint;
	wire [2:0] lane1_rxpresethint;
	wire [2:0] lane2_rxpresethint;
	wire [2:0] lane3_rxpresethint;
	wire [2:0] lane4_rxpresethint;
	wire [2:0] lane5_rxpresethint;
	wire [2:0] lane6_rxpresethint;
	wire [2:0] lane7_rxpresethint;
	wire [2:0] lane8_rxpresethint;
	wire [2:0] lane9_rxpresethint;
	wire [2:0] lane10_rxpresethint;
	wire [2:0] lane11_rxpresethint;
	wire [2:0] lane12_rxpresethint;
	wire [2:0] lane13_rxpresethint;
	wire [2:0] lane14_rxpresethint;
	wire [2:0] lane15_rxpresethint;
	wire [5:0] lane0_fs;
	wire [5:0] lane1_fs;
	wire [5:0] lane2_fs;
	wire [5:0] lane3_fs;
	wire [5:0] lane4_fs;
	wire [5:0] lane5_fs;
	wire [5:0] lane6_fs;
	wire [5:0] lane7_fs;
	wire [5:0] lane8_fs;
	wire [5:0] lane9_fs;
	wire [5:0] lane10_fs;
	wire [5:0] lane11_fs;
	wire [5:0] lane12_fs;
	wire [5:0] lane13_fs;
	wire [5:0] lane14_fs;
	wire [5:0] lane15_fs;
	wire [5:0] lane0_lf;
	wire [5:0] lane1_lf;
	wire [5:0] lane2_lf;
	wire [5:0] lane3_lf;
	wire [5:0] lane4_lf;
	wire [5:0] lane5_lf;
	wire [5:0] lane6_lf;
	wire [5:0] lane7_lf;
	wire [5:0] lane8_lf;
	wire [5:0] lane9_lf;
	wire [5:0] lane10_lf;
	wire [5:0] lane11_lf;
	wire [5:0] lane12_lf;
	wire [5:0] lane13_lf;
	wire [5:0] lane14_lf;
	wire [5:0] lane15_lf;
	wire [15:0] rxeqeval;
	wire [7:0] lane0_link_evaluation_feedback_figure_merit;
	wire [7:0] lane1_link_evaluation_feedback_figure_merit;
	wire [7:0] lane2_link_evaluation_feedback_figure_merit;
	wire [7:0] lane3_link_evaluation_feedback_figure_merit;
	wire [7:0] lane4_link_evaluation_feedback_figure_merit;
	wire [7:0] lane5_link_evaluation_feedback_figure_merit;
	wire [7:0] lane6_link_evaluation_feedback_figure_merit;
	wire [7:0] lane7_link_evaluation_feedback_figure_merit;
	wire [7:0] lane8_link_evaluation_feedback_figure_merit;
	wire [7:0] lane9_link_evaluation_feedback_figure_merit;
	wire [7:0] lane10_link_evaluation_feedback_figure_merit;
	wire [7:0] lane11_link_evaluation_feedback_figure_merit;
	wire [7:0] lane12_link_evaluation_feedback_figure_merit;
	wire [7:0] lane13_link_evaluation_feedback_figure_merit;
	wire [7:0] lane14_link_evaluation_feedback_figure_merit;
	wire [7:0] lane15_link_evaluation_feedback_figure_merit;
	wire [5:0] lane0_link_evaluation_feedback_direction_change;
	wire [5:0] lane1_link_evaluation_feedback_direction_change;
	wire [5:0] lane2_link_evaluation_feedback_direction_change;
	wire [5:0] lane3_link_evaluation_feedback_direction_change;
	wire [5:0] lane4_link_evaluation_feedback_direction_change;
	wire [5:0] lane5_link_evaluation_feedback_direction_change;
	wire [5:0] lane6_link_evaluation_feedback_direction_change;
	wire [5:0] lane7_link_evaluation_feedback_direction_change;
	wire [5:0] lane8_link_evaluation_feedback_direction_change;
	wire [5:0] lane9_link_evaluation_feedback_direction_change;
	wire [5:0] lane10_link_evaluation_feedback_direction_change;
	wire [5:0] lane11_link_evaluation_feedback_direction_change;
	wire [5:0] lane12_link_evaluation_feedback_direction_change;
	wire [5:0] lane13_link_evaluation_feedback_direction_change;
	wire [5:0] lane14_link_evaluation_feedback_direction_change;
	wire [5:0] lane15_link_evaluation_feedback_direction_change;
	wire [15:0] invalidrequest;
	wire [15:0] block_align_control;
	wire [15:0] rxstandby;
	wire [15:0] rxstandbystatus;
	wire [15:0] encode_decode_bypass;
	wire [15:0] rx_eq_in_progress;
	wire [5:0] lane0_local_fs;
	wire [5:0] lane1_local_fs;
	wire [5:0] lane2_local_fs;
	wire [5:0] lane3_local_fs;
	wire [5:0] lane4_local_fs;
	wire [5:0] lane5_local_fs;
	wire [5:0] lane6_local_fs;
	wire [5:0] lane7_local_fs;
	wire [5:0] lane8_local_fs;
	wire [5:0] lane9_local_fs;
	wire [5:0] lane10_local_fs;
	wire [5:0] lane11_local_fs;
	wire [5:0] lane12_local_fs;
	wire [5:0] lane13_local_fs;
	wire [5:0] lane14_local_fs;
	wire [5:0] lane15_local_fs;
	wire [5:0] lane0_local_lf;
	wire [5:0] lane1_local_lf;
	wire [5:0] lane2_local_lf;
	wire [5:0] lane3_local_lf;
	wire [5:0] lane4_local_lf;
	wire [5:0] lane5_local_lf;
	wire [5:0] lane6_local_lf;
	wire [5:0] lane7_local_lf;
	wire [5:0] lane8_local_lf;
	wire [5:0] lane9_local_lf;
	wire [5:0] lane10_local_lf;
	wire [5:0] lane11_local_lf;
	wire [5:0] lane12_local_lf;
	wire [5:0] lane13_local_lf;
	wire [5:0] lane14_local_lf;
	wire [5:0] lane15_local_lf;
	wire [15:0] get_local_preset_coefficients;
	wire [15:0] local_tx_coefficients_valid;
	wire [3:0] lane0_local_preset_index;
	wire [3:0] lane1_local_preset_index;
	wire [3:0] lane2_local_preset_index;
	wire [3:0] lane3_local_preset_index;
	wire [3:0] lane4_local_preset_index;
	wire [3:0] lane5_local_preset_index;
	wire [3:0] lane6_local_preset_index;
	wire [3:0] lane7_local_preset_index;
	wire [3:0] lane8_local_preset_index;
	wire [3:0] lane9_local_preset_index;
	wire [3:0] lane10_local_preset_index;
	wire [3:0] lane11_local_preset_index;
	wire [3:0] lane12_local_preset_index;
	wire [3:0] lane13_local_preset_index;
	wire [3:0] lane14_local_preset_index;
	wire [3:0] lane15_local_preset_index;
	wire [17:0] lane0_local_tx_preset_coefficients;
	wire [17:0] lane1_local_tx_preset_coefficients;
	wire [17:0] lane2_local_tx_preset_coefficients;
	wire [17:0] lane3_local_tx_preset_coefficients;
	wire [17:0] lane4_local_tx_preset_coefficients;
	wire [17:0] lane5_local_tx_preset_coefficients;
	wire [17:0] lane6_local_tx_preset_coefficients;
	wire [17:0] lane7_local_tx_preset_coefficients;
	wire [17:0] lane8_local_tx_preset_coefficients;
	wire [17:0] lane9_local_tx_preset_coefficients;
	wire [17:0] lane10_local_tx_preset_coefficients;
	wire [17:0] lane11_local_tx_preset_coefficients;
	wire [17:0] lane12_local_tx_preset_coefficients;
	wire [17:0] lane13_local_tx_preset_coefficients;
	wire [17:0] lane14_local_tx_preset_coefficients;
	wire [17:0] lane15_local_tx_preset_coefficients;
	wire        clkreq_n;
	wire        wake;
	
endinterface : pcie_basic_if

`endif

`ifndef _OZDEFS_
`define _OZDEFS_

  `define COM 8'hBC
  `define SKP 8'h1C
  `define PAD 8'hF7

  `define D2_0 8'h02
  `define D4_0 8'h04
  `define D8_0 8'h08

  `define TS1ID 8'h4A
  `define TS2ID 8'h45

typedef enum logic [7:0] {DETECT_QUIET, DETECT_ACTIVE, POLLING_ACTIVE, POLLING_ACTIVE_START_TS1, POLLING_CONFIG, CONFIG_LINKWIDTH_START, CONFIG_LINKWIDTH_ACCEPT, CONFIG_LANENUM_ACCEPT, CONFIG_COMPLETE, CONFIG_IDLE, L0} LTSSM_State;

typedef enum logic [7:0] {NONE, SKP, TS1, TS2} OsType;


`endif

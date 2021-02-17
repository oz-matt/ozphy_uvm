
module serdes(SerialClock,
			  parallel_in0,
			  parallel_in1,
			  parallel_in2,
			  parallel_in3,
			  parallel_in4,
			  parallel_in5,
			  parallel_in6,
			  parallel_in7,
			  parallel_in8,
			  parallel_in9,
			  parallel_in10,
			  parallel_in11,
			  parallel_in12,
			  parallel_in13,
			  parallel_in14,
			  parallel_in15,
			  parallel_out0,
			  parallel_out1,
			  parallel_out2,
			  parallel_out3,
			  parallel_out4,
			  parallel_out5,
			  parallel_out6,
			  parallel_out7,
			  parallel_out8,
			  parallel_out9,
			  parallel_out10,
			  parallel_out11,
			  parallel_out12,
			  parallel_out13,
			  parallel_out14,
			  parallel_out15,
			  serial_in0,
			  serial_in1,
			  serial_in2,
			  serial_in3,
			  serial_in4,
			  serial_in5,
			  serial_in6,
			  serial_in7,
			  serial_in8,
			  serial_in9,
			  serial_in10,
			  serial_in11,
			  serial_in12,
			  serial_in13,
			  serial_in14,
			  serial_in15,
			  serial_out0,
			  serial_out1,
			  serial_out2,
			  serial_out3,
			  serial_out4,
			  serial_out5,
			  serial_out6,
			  serial_out7,
			  serial_out8,
			  serial_out9,
			  serial_out10,
			  serial_out11,
			  serial_out12,
			  serial_out13,
			  serial_out14,
			  serial_out15);

   input        SerialClock;

   input  [9:0] parallel_in0;
   input  [9:0] parallel_in1;
   input  [9:0] parallel_in2;
   input  [9:0] parallel_in3;
   input  [9:0] parallel_in4;
   input  [9:0] parallel_in5;
   input  [9:0] parallel_in6;
   input  [9:0] parallel_in7;
   input  [9:0] parallel_in8;
   input  [9:0] parallel_in9;
   input  [9:0] parallel_in10;
   input  [9:0] parallel_in11;
   input  [9:0] parallel_in12;
   input  [9:0] parallel_in13;
   input  [9:0] parallel_in14;
   input  [9:0] parallel_in15;
   
   output [9:0] parallel_out0;
   output [9:0] parallel_out1;
   output [9:0] parallel_out2;
   output [9:0] parallel_out3;
   output [9:0] parallel_out4;
   output [9:0] parallel_out5;
   output [9:0] parallel_out6;
   output [9:0] parallel_out7;
   output [9:0] parallel_out8;
   output [9:0] parallel_out9;
   output [9:0] parallel_out10;
   output [9:0] parallel_out11;
   output [9:0] parallel_out12;
   output [9:0] parallel_out13;
   output [9:0] parallel_out14;
   output [9:0] parallel_out15;

   input        serial_in0;
   input        serial_in1;
   input        serial_in2;
   input        serial_in3;
   input        serial_in4;
   input        serial_in5;
   input        serial_in6;
   input        serial_in7;
   input        serial_in8;
   input        serial_in9;
   input        serial_in10;
   input        serial_in11;
   input        serial_in12;
   input        serial_in13;
   input        serial_in14;
   input        serial_in15;

   output       serial_out0;
   output       serial_out1;
   output       serial_out2;
   output       serial_out3;
   output       serial_out4;
   output       serial_out5;
   output       serial_out6;
   output       serial_out7;
   output       serial_out8;
   output       serial_out9;
   output       serial_out10;
   output       serial_out11;
   output       serial_out12;
   output       serial_out13;
   output       serial_out14;
   output       serial_out15;

   reg    [9:0] serial_sr0;
   reg    [9:0] serial_sr1;
   reg    [9:0] serial_sr2;
   reg    [9:0] serial_sr3;
   reg    [9:0] serial_sr4;
   reg    [9:0] serial_sr5;
   reg    [9:0] serial_sr6;
   reg    [9:0] serial_sr7;
   reg    [9:0] serial_sr8;
   reg    [9:0] serial_sr9;
   reg    [9:0] serial_sr10;
   reg    [9:0] serial_sr11;
   reg    [9:0] serial_sr12;
   reg    [9:0] serial_sr13;
   reg    [9:0] serial_sr14;
   reg    [9:0] serial_sr15;

   reg    [9:0] deserial_sr0;
   reg    [9:0] deserial_sr1;
   reg    [9:0] deserial_sr2;
   reg    [9:0] deserial_sr3;
   reg    [9:0] deserial_sr4;
   reg    [9:0] deserial_sr5;
   reg    [9:0] deserial_sr6;
   reg    [9:0] deserial_sr7;
   reg    [9:0] deserial_sr8;
   reg    [9:0] deserial_sr9;
   reg    [9:0] deserial_sr10;
   reg    [9:0] deserial_sr11;
   reg    [9:0] deserial_sr12;
   reg    [9:0] deserial_sr13;
   reg    [9:0] deserial_sr14;
   reg    [9:0] deserial_sr15;

   reg    [9:0] deserial_reg0;
   reg    [9:0] deserial_reg1;
   reg    [9:0] deserial_reg2;
   reg    [9:0] deserial_reg3;
   reg    [9:0] deserial_reg4;
   reg    [9:0] deserial_reg5;
   reg    [9:0] deserial_reg6;
   reg    [9:0] deserial_reg7;
   reg    [9:0] deserial_reg8;
   reg    [9:0] deserial_reg9;
   reg    [9:0] deserial_reg10;
   reg    [9:0] deserial_reg11;
   reg    [9:0] deserial_reg12;
   reg    [9:0] deserial_reg13;
   reg    [9:0] deserial_reg14;
   reg    [9:0] deserial_reg15;

   reg    [9:0] deserial_sync_reg0;
   reg    [9:0] deserial_sync_reg1;
   reg    [9:0] deserial_sync_reg2;
   reg    [9:0] deserial_sync_reg3;
   reg    [9:0] deserial_sync_reg4;
   reg    [9:0] deserial_sync_reg5;
   reg    [9:0] deserial_sync_reg6;
   reg    [9:0] deserial_sync_reg7;
   reg    [9:0] deserial_sync_reg8;
   reg    [9:0] deserial_sync_reg9;
   reg    [9:0] deserial_sync_reg10;
   reg    [9:0] deserial_sync_reg11;
   reg    [9:0] deserial_sync_reg12;
   reg    [9:0] deserial_sync_reg13;
   reg    [9:0] deserial_sync_reg14;
   reg    [9:0] deserial_sync_reg15;

   reg    [15:0]  in_sync;
   reg    [4:0] serial_count;
   reg    [4:0] deserial_count0;
   reg    [4:0] deserial_count1;
   reg    [4:0] deserial_count2;
   reg    [4:0] deserial_count3;
   reg    [4:0] deserial_count4;
   reg    [4:0] deserial_count5;
   reg    [4:0] deserial_count6;
   reg    [4:0] deserial_count7;
   reg    [4:0] deserial_count8;
   reg    [4:0] deserial_count9;
   reg    [4:0] deserial_count10;
   reg    [4:0] deserial_count11;
   reg    [4:0] deserial_count12;
   reg    [4:0] deserial_count13;
   reg    [4:0] deserial_count14;
   reg    [4:0] deserial_count15;
   reg    [3:0] sync_count;
   reg          sync_enable;
   reg    [4:0] leading_lane;
   reg   [15:0] in_sync_sample;
   reg   [15:0] parallel_enable;
   reg    [4:0] parallel_enable_count;

   initial begin
	   in_sync[15:0]       = 0;
	   serial_count        = 9;
       deserial_count0     = 0;
       deserial_count1     = 0;
       deserial_count2     = 0;
       deserial_count3     = 0;
       deserial_count4     = 0;
       deserial_count5     = 0;
       deserial_count6     = 0;
       deserial_count7     = 0;
       deserial_count8     = 0;
       deserial_count9     = 0;
       deserial_count10    = 0;
       deserial_count11    = 0;
       deserial_count12    = 0;
       deserial_count13    = 0;
       deserial_count14    = 0;
       deserial_count15    = 0;
       sync_count          = 0;
       sync_enable         = 0;
       leading_lane        = 31;
       deserial_reg0[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg1[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg2[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg3[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg4[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg5[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg6[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg7[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg8[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg9[9:0]          = 10'bzzzzzzzzzz;
       deserial_reg10[9:0]         = 10'bzzzzzzzzzz;
       deserial_reg11[9:0]         = 10'bzzzzzzzzzz;
       deserial_reg12[9:0]         = 10'bzzzzzzzzzz;
       deserial_reg13[9:0]         = 10'bzzzzzzzzzz;
       deserial_reg14[9:0]         = 10'bzzzzzzzzzz;
       deserial_reg15[9:0]         = 10'bzzzzzzzzzz;
       deserial_sync_reg0[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg1[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg2[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg3[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg4[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg5[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg6[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg7[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg8[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg9[9:0]     = 10'bzzzzzzzzzz;
       deserial_sync_reg10[9:0]    = 10'bzzzzzzzzzz;
       deserial_sync_reg11[9:0]    = 10'bzzzzzzzzzz;
       deserial_sync_reg12[9:0]    = 10'bzzzzzzzzzz;
       deserial_sync_reg13[9:0]    = 10'bzzzzzzzzzz;
       deserial_sync_reg14[9:0]    = 10'bzzzzzzzzzz;
       deserial_sync_reg15[9:0]    = 10'bzzzzzzzzzz;
       in_sync_sample[15:0]        = 0;
       parallel_enable[15:0]       = 0;
       parallel_enable_count[4:0]  = 0;
   end

   // serialize
   always @(posedge SerialClock) begin
	  if (serial_count == 0) begin
		 serial_count <= 9;
		 serial_sr0 <= parallel_in0;
		 serial_sr1 <= parallel_in1;
		 serial_sr2 <= parallel_in2;
		 serial_sr3 <= parallel_in3;
		 serial_sr4 <= parallel_in4;
		 serial_sr5 <= parallel_in5;
		 serial_sr6 <= parallel_in6;
		 serial_sr7 <= parallel_in7;
		 serial_sr8 <= parallel_in8;
		 serial_sr9 <= parallel_in9;
		 serial_sr10 <= parallel_in10;
		 serial_sr11 <= parallel_in11;
		 serial_sr12 <= parallel_in12;
		 serial_sr13 <= parallel_in13;
		 serial_sr14 <= parallel_in14;
		 serial_sr15 <= parallel_in15;
	  end
	  else begin
		 serial_count <= serial_count - 1;
		 serial_sr0 <= { serial_sr0[8:0], 1'b0};
		 serial_sr1 <= { serial_sr1[8:0], 1'b0};
		 serial_sr2 <= { serial_sr2[8:0], 1'b0};
		 serial_sr3 <= { serial_sr3[8:0], 1'b0};
		 serial_sr4 <= { serial_sr4[8:0], 1'b0};
		 serial_sr5 <= { serial_sr5[8:0], 1'b0};
		 serial_sr6 <= { serial_sr6[8:0], 1'b0};
		 serial_sr7 <= { serial_sr7[8:0], 1'b0};
		 serial_sr8 <= { serial_sr8[8:0], 1'b0};
		 serial_sr9 <= { serial_sr9[8:0], 1'b0};
		 serial_sr10 <= { serial_sr10[8:0], 1'b0};
		 serial_sr11 <= { serial_sr11[8:0], 1'b0};
		 serial_sr12 <= { serial_sr12[8:0], 1'b0};
		 serial_sr13 <= { serial_sr13[8:0], 1'b0};
		 serial_sr14 <= { serial_sr14[8:0], 1'b0};
		 serial_sr15 <= { serial_sr15[8:0], 1'b0};
	  end
   end
   assign serial_out0 = serial_sr0[9];
   assign serial_out1 = serial_sr1[9];
   assign serial_out2 = serial_sr2[9];
   assign serial_out3 = serial_sr3[9];
   assign serial_out4 = serial_sr4[9];
   assign serial_out5 = serial_sr5[9];
   assign serial_out6 = serial_sr6[9];
   assign serial_out7 = serial_sr7[9];
   assign serial_out8 = serial_sr8[9];
   assign serial_out9 = serial_sr9[9];
   assign serial_out10 = serial_sr10[9];
   assign serial_out11 = serial_sr11[9];
   assign serial_out12 = serial_sr12[9];
   assign serial_out13 = serial_sr13[9];
   assign serial_out14 = serial_sr14[9];
   assign serial_out15 = serial_sr15[9];


   // deserialize
   always @(posedge SerialClock) begin
	  deserial_sr0  = { deserial_sr0[8:0], serial_in0 };
	  deserial_sr1  = { deserial_sr1[8:0], serial_in1 };
	  deserial_sr2  = { deserial_sr2[8:0], serial_in2 };
	  deserial_sr3  = { deserial_sr3[8:0], serial_in3 };
	  deserial_sr4  = { deserial_sr4[8:0], serial_in4 };
	  deserial_sr5  = { deserial_sr5[8:0], serial_in5 };
	  deserial_sr6  = { deserial_sr6[8:0], serial_in6 };
	  deserial_sr7  = { deserial_sr7[8:0], serial_in7 };
	  deserial_sr8  = { deserial_sr8[8:0], serial_in8 };
	  deserial_sr9  = { deserial_sr9[8:0], serial_in9 };
	  deserial_sr10 = { deserial_sr10[8:0], serial_in10 };
	  deserial_sr11 = { deserial_sr11[8:0], serial_in11 };
	  deserial_sr12 = { deserial_sr12[8:0], serial_in12 };
	  deserial_sr13 = { deserial_sr13[8:0], serial_in13 };
	  deserial_sr14 = { deserial_sr14[8:0], serial_in14 };
	  deserial_sr15 = { deserial_sr15[8:0], serial_in15 };

	  // Maintain sync
      // Only the implementation of lane 0 is commented;  the other lanes
      // are handled identically.
      
      // Lane 0
      // The count tracks the number of bits in the serial input register, 
      // deserial_srN;  when it contains 10 bits (count == 9) the contents 
      // are saved off to deserial_regN.
      deserial_count0    = (deserial_count0 + 1) % 10;
	  if (in_sync[0]) begin
		  // if the deserializer is in sync, look for events that would cause
		  // it to lose sync
		  if (serial_in0 === 1'bz || serial_in0 === 1'bx) begin
			  $display("Lane 0 deserializer lost bit lock at time %0t.", $time);
			  in_sync[0]    = 1'b0;
		  end
	  end
	  else begin
		  // if the deserializer is not in sync, look for a COM character
		  if (deserial_sr0 == 10'b0011111010 || deserial_sr0 == 10'b1100000101) begin
			  $display("Lane 0 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[0]         = 1'b1;
              deserial_count0    = 9;
              // If leading_lane is unassigned, (31 is the default), it means 
              // this is the first lane to receive a COM.  In that case, the
              // synchronization point (the point at which the symbols are pushed 
              // out to the parallel interface) should be 3 cycles after this to
              // allow for 3 bits of skew.  Setting leading_lane will trigger
              // that.
              if (leading_lane == 31) begin
                  leading_lane     = 0;
              end
		  end
	  end

	  if (deserial_count0 == 9) begin
          // Save the lane status for later use in controlling when the parallel out is 
          // disabled.  (The parallel out has to be held valid to drive the last 
          // valid serial input symbol even after the input signal has gone to z
          // and in_sync consequently has been set to 0.)
          in_sync_sample[0]  = in_sync[0];
          if (in_sync[0]) begin
	          deserial_reg0    = deserial_sr0;
          end
          // If this is the first lane to detect a COM, this implementation assumes
          // that it will be the leading lane with respect to bit skew as well.
          // Each time a 10 bit symbol is collected on this lane, the logic starts a 
          // timer that will cause the symbols on all lanes to be transferred to the
          // parallel data output in 3 bit times.
          
          // Note that this logic will continue to trigger the transfer logic even
          // if this lane has lost bit lock;  since we're assuming the skew to be
          // static once a lane achieves bit lock, only the loss of bit lock 
          // across all lanes should cause the sync logic to reset.
          if (leading_lane == 0) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 1
      deserial_count1     = (deserial_count1 + 1) % 10;
	  if (in_sync[1]) begin
		  if (serial_in1 === 1'bz || serial_in1 === 1'bx) begin
			  $display("Lane 1 deserializer lost bit lock at time %0t.", $time);
			  in_sync[1]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr1 == 10'b0011111010 || deserial_sr1 == 10'b1100000101) begin
			  $display("Lane 1 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[1]         = 1'b1;
              deserial_count1    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 1;
              end
		  end
	  end

	  if (deserial_count1 == 9) begin
          in_sync_sample[1]  = in_sync[1];
          if (in_sync[1]) begin
	          deserial_reg1    = deserial_sr1;
          end
          if (leading_lane == 1) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 2
      deserial_count2     = (deserial_count2 + 1) % 10;
	  if (in_sync[2]) begin
		  if (serial_in2 === 1'bz || serial_in2 === 1'bx) begin
			  $display("Lane 2 deserializer lost bit lock at time %0t.", $time);
			  in_sync[2]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr2 == 10'b0011111010 || deserial_sr2 == 10'b1100000101) begin
			  $display("Lane 2 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[2]         = 1'b1;
              deserial_count2    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 2;
              end
		  end
	  end

	  if (deserial_count2 == 9) begin
          in_sync_sample[2]  = in_sync[2];
          if (in_sync[2]) begin
	          deserial_reg2    = deserial_sr2;
          end
          if (leading_lane == 2) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 3
      deserial_count3     = (deserial_count3 + 1) % 10;
	  if (in_sync[3]) begin
		  if (serial_in3 === 1'bz || serial_in3 === 1'bx) begin
			  $display("Lane 3 deserializer lost bit lock at time %0t.", $time);
			  in_sync[3]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr3 == 10'b0011111010 || deserial_sr3 == 10'b1100000101) begin
			  $display("Lane 3 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[3]         = 1'b1;
              deserial_count3    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 3;
              end
		  end
	  end

	  if (deserial_count3 == 9) begin
          in_sync_sample[3]  = in_sync[3];
          if (in_sync[3]) begin
	          deserial_reg3    = deserial_sr3;
          end
          if (leading_lane == 3) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 4
      deserial_count4     = (deserial_count4 + 1) % 10;
	  if (in_sync[4]) begin
		  if (serial_in4 === 1'bz || serial_in4 === 1'bx) begin
			  $display("Lane 4 deserializer lost bit lock at time %0t.", $time);
			  in_sync[4]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr4 == 10'b0011111010 || deserial_sr4 == 10'b1100000101) begin
			  $display("Lane 4 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[4]         = 1'b1;
              deserial_count4    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 4;
              end
		  end
	  end

	  if (deserial_count4 == 9) begin
          in_sync_sample[4]  = in_sync[4];
          if (in_sync[4]) begin
	          deserial_reg4    = deserial_sr4;
          end
          if (leading_lane == 4) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 5
      deserial_count5     = (deserial_count5 + 1) % 10;
	  if (in_sync[5]) begin
		  if (serial_in5 === 1'bz || serial_in5 === 1'bx) begin
			  $display("Lane 5 deserializer lost bit lock at time %0t.", $time);
			  in_sync[5]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr5 == 10'b0011111010 || deserial_sr5 == 10'b1100000101) begin
			  $display("Lane 5 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[5]         = 1'b1;
              deserial_count5    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 5;
              end
		  end
	  end

	  if (deserial_count5 == 9) begin
          in_sync_sample[5]  = in_sync[5];
          if (in_sync[5]) begin
	          deserial_reg5    = deserial_sr5;
          end
          if (leading_lane == 5) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 6
      deserial_count6     = (deserial_count6 + 1) % 10;
	  if (in_sync[6]) begin
		  if (serial_in6 === 1'bz || serial_in6 === 1'bx) begin
			  $display("Lane 6 deserializer lost bit lock at time %0t.", $time);
			  in_sync[6]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr6 == 10'b0011111010 || deserial_sr6 == 10'b1100000101) begin
			  $display("Lane 6 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[6]         = 1'b1;
              deserial_count6    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 6;
              end
		  end
	  end

	  if (deserial_count6 == 9) begin
          in_sync_sample[6]  = in_sync[6];
          if (in_sync[6]) begin
	          deserial_reg6    = deserial_sr6;
          end
          if (leading_lane == 6) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 7
      deserial_count7     = (deserial_count7 + 1) % 10;
	  if (in_sync[7]) begin
		  if (serial_in7 === 1'bz || serial_in7 === 1'bx) begin
			  $display("Lane 7 deserializer lost bit lock at time %0t.", $time);
			  in_sync[7]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr7 == 10'b0011111010 || deserial_sr7 == 10'b1100000101) begin
			  $display("Lane 7 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[7]         = 1'b1;
              deserial_count7    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 7;
              end
		  end
	  end

	  if (deserial_count7 == 9) begin
          in_sync_sample[7]  = in_sync[7];
          if (in_sync[7]) begin
	          deserial_reg7    = deserial_sr7;
          end
          if (leading_lane == 7) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 8
      deserial_count8     = (deserial_count8 + 1) % 10;
	  if (in_sync[8]) begin
		  if (serial_in8 === 1'bz || serial_in8 === 1'bx) begin
			  $display("Lane 8 deserializer lost bit lock at time %0t.", $time);
			  in_sync[8]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr8 == 10'b0011111010 || deserial_sr8 == 10'b1100000101) begin
			  $display("Lane 8 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[8]         = 1'b1;
              deserial_count8    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 8;
              end
		  end
	  end

	  if (deserial_count8 == 9) begin
          in_sync_sample[8]  = in_sync[8];
          if (in_sync[8]) begin
	          deserial_reg8    = deserial_sr8;
          end
          if (leading_lane == 8) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 9
      deserial_count9     = (deserial_count9 + 1) % 10;
	  if (in_sync[9]) begin
		  if (serial_in9 === 1'bz || serial_in9 === 1'bx) begin
			  $display("Lane 9 deserializer lost bit lock at time %0t.", $time);
			  in_sync[9]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr9 == 10'b0011111010 || deserial_sr9 == 10'b1100000101) begin
			  $display("Lane 9 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[9]         = 1'b1;
              deserial_count9    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 9;
              end
		  end
	  end

	  if (deserial_count9 == 9) begin
          in_sync_sample[9]  = in_sync[9];
          if (in_sync[9]) begin
	          deserial_reg9    = deserial_sr9;
          end
          if (leading_lane == 9) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 10
      deserial_count10     = (deserial_count10 + 1) % 10;
	  if (in_sync[10]) begin
		  if (serial_in10 === 1'bz || serial_in10 === 1'bx) begin
			  $display("Lane 10 deserializer lost bit lock at time %0t.", $time);
			  in_sync[10]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr10 == 10'b0011111010 || deserial_sr10 == 10'b1100000101) begin
			  $display("Lane 10 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[10]         = 1'b1;
              deserial_count10    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 10;
              end
		  end
	  end

	  if (deserial_count10 == 9) begin
          in_sync_sample[10]  = in_sync[10];
          if (in_sync[10]) begin
	          deserial_reg10    = deserial_sr10;
          end
          if (leading_lane == 10) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 11
      deserial_count11     = (deserial_count11 + 1) % 10;
	  if (in_sync[11]) begin
		  if (serial_in11 === 1'bz || serial_in11 === 1'bx) begin
			  $display("Lane 11 deserializer lost bit lock at time %0t.", $time);
			  in_sync[11]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr11 == 10'b0011111010 || deserial_sr11 == 10'b1100000101) begin
			  $display("Lane 11 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[11]         = 1'b1;
              deserial_count11    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 11;
              end
		  end
	  end

	  if (deserial_count11 == 9) begin
          in_sync_sample[11]  = in_sync[11];
          if (in_sync[11]) begin
	          deserial_reg11    = deserial_sr11;
          end
          if (leading_lane == 11) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 12
      deserial_count12     = (deserial_count12 + 1) % 10;
	  if (in_sync[12]) begin
		  if (serial_in12 === 1'bz || serial_in12 === 1'bx) begin
			  $display("Lane 12 deserializer lost bit lock at time %0t.", $time);
			  in_sync[12]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr12 == 10'b0011111010 || deserial_sr12 == 10'b1100000101) begin
			  $display("Lane 12 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[12]         = 1'b1;
              deserial_count12    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 12;
              end
		  end
	  end

	  if (deserial_count12 == 9) begin
          in_sync_sample[12]  = in_sync[12];
          if (in_sync[12]) begin
	          deserial_reg12    = deserial_sr12;
          end
          if (leading_lane == 12) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 13
      deserial_count13     = (deserial_count13 + 1) % 10;
	  if (in_sync[13]) begin
		  if (serial_in13 === 1'bz || serial_in13 === 1'bx) begin
			  $display("Lane 13 deserializer lost bit lock at time %0t.", $time);
			  in_sync[13]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr13 == 10'b0011111010 || deserial_sr13 == 10'b1100000101) begin
			  $display("Lane 13 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[13]         = 1'b1;
              deserial_count13    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 13;
              end
		  end
	  end

	  if (deserial_count13 == 9) begin
          in_sync_sample[13]  = in_sync[13];
          if (in_sync[13]) begin
	          deserial_reg13    = deserial_sr13;
          end
          if (leading_lane == 13) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 14
      deserial_count14     = (deserial_count14 + 1) % 10;
	  if (in_sync[14]) begin
		  if (serial_in14 === 1'bz || serial_in14 === 1'bx) begin
			  $display("Lane 14 deserializer lost bit lock at time %0t.", $time);
			  in_sync[14]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr14 == 10'b0011111010 || deserial_sr14 == 10'b1100000101) begin
			  $display("Lane 14 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[14]         = 1'b1;
              deserial_count14    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 14;
              end
		  end
	  end

	  if (deserial_count14 == 9) begin
          in_sync_sample[14]  = in_sync[14];
          if (in_sync[14]) begin
	          deserial_reg14    = deserial_sr14;
          end
          if (leading_lane == 14) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

      // Lane 15
      deserial_count15     = (deserial_count15 + 1) % 10;
	  if (in_sync[15]) begin
		  if (serial_in15 === 1'bz || serial_in15 === 1'bx) begin
			  $display("Lane 15 deserializer lost bit lock at time %0t.", $time);
			  in_sync[15]    = 1'b0;
		  end
	  end
	  else begin
		  if (deserial_sr15 == 10'b0011111010 || deserial_sr15 == 10'b1100000101) begin
			  $display("Lane 15 deserializer achieved bit lock at time %0t.", $time);
			  in_sync[15]         = 1'b1;
              deserial_count15    = 9;
              if (leading_lane == 31) begin
                  leading_lane     = 15;
              end
		  end
	  end

	  if (deserial_count15 == 9) begin
          in_sync_sample[15]  = in_sync[15];
          if (in_sync[15]) begin
	          deserial_reg15    = deserial_sr15;
          end
          if (leading_lane == 15) begin
              sync_enable    = 1;
              sync_count     = 0;
          end
	  end

       
      // If no lanes have bit lock, reset leading_lane 
      if (in_sync_sample == 0) begin
          leading_lane    = 31;
      end
       
      // The next two blocks ensure that all lanes drive the new symbols on the
      // parallel interface at the same time, even if there is up to three bit
      // times of skew between lane 0 and any other lane, and that the last 
      // valid symbol is driven on the parallel out for the full symbol time 
      // even if the serial input subsequently goes to electrical idle.
	  if (sync_enable == 1) begin
	      sync_count = sync_count + 1;
          if (sync_count == 4) begin
                  sync_enable           = 0;
                  parallel_enable_count = 11; 
	          deserial_sync_reg0    = deserial_reg0;
	          deserial_sync_reg1    = deserial_reg1;
	          deserial_sync_reg2    = deserial_reg2;
	          deserial_sync_reg3    = deserial_reg3;
	          deserial_sync_reg4    = deserial_reg4;
	          deserial_sync_reg5    = deserial_reg5;
	          deserial_sync_reg6    = deserial_reg6;
	          deserial_sync_reg7    = deserial_reg7;
	          deserial_sync_reg8    = deserial_reg8;
	          deserial_sync_reg9    = deserial_reg9;
	          deserial_sync_reg10   = deserial_reg10;
	          deserial_sync_reg11   = deserial_reg11;
	          deserial_sync_reg12   = deserial_reg12;
	          deserial_sync_reg13   = deserial_reg13;
	          deserial_sync_reg14   = deserial_reg14;
	          deserial_sync_reg15   = deserial_reg15;
          end
	  end

      if (parallel_enable_count > 0) begin
          parallel_enable_count = parallel_enable_count - 1;
          if (parallel_enable_count == 10) begin
              parallel_enable[0]    = in_sync_sample[0];
              parallel_enable[1]    = in_sync_sample[1];
              parallel_enable[2]    = in_sync_sample[2]; 
              parallel_enable[3]    = in_sync_sample[3]; 
              parallel_enable[4]    = in_sync_sample[4]; 
              parallel_enable[5]    = in_sync_sample[5]; 
              parallel_enable[6]    = in_sync_sample[6]; 
              parallel_enable[7]    = in_sync_sample[7]; 
              parallel_enable[8]    = in_sync_sample[8]; 
              parallel_enable[9]    = in_sync_sample[9]; 
              parallel_enable[10]   = in_sync_sample[10];
              parallel_enable[11]   = in_sync_sample[11];
              parallel_enable[12]   = in_sync_sample[12];
              parallel_enable[13]   = in_sync_sample[13];
              parallel_enable[14]   = in_sync_sample[14];
              parallel_enable[15]   = in_sync_sample[15];
          end
          else if (parallel_enable_count == 0) begin
              // The enable count will reach 0 when all serial input lanes have 
              // gone to electrical idle; disable the parallel output.
              parallel_enable       = 0;  
          end
      end
   end // always @ (posedge SerialClock)
   
   assign parallel_out0  = parallel_enable[0]  ? deserial_sync_reg0  : 10'bz;
   assign parallel_out1  = parallel_enable[1]  ? deserial_sync_reg1  : 10'bz;
   assign parallel_out2  = parallel_enable[2]  ? deserial_sync_reg2  : 10'bz;
   assign parallel_out3  = parallel_enable[3]  ? deserial_sync_reg3  : 10'bz;
   assign parallel_out4  = parallel_enable[4]  ? deserial_sync_reg4  : 10'bz;
   assign parallel_out5  = parallel_enable[5]  ? deserial_sync_reg5  : 10'bz;
   assign parallel_out6  = parallel_enable[6]  ? deserial_sync_reg6  : 10'bz;
   assign parallel_out7  = parallel_enable[7]  ? deserial_sync_reg7  : 10'bz;
   assign parallel_out8  = parallel_enable[8]  ? deserial_sync_reg8  : 10'bz;
   assign parallel_out9  = parallel_enable[9]  ? deserial_sync_reg9  : 10'bz;
   assign parallel_out10 = parallel_enable[10] ? deserial_sync_reg10 : 10'bz;
   assign parallel_out11 = parallel_enable[11] ? deserial_sync_reg11 : 10'bz;
   assign parallel_out12 = parallel_enable[12] ? deserial_sync_reg12 : 10'bz;
   assign parallel_out13 = parallel_enable[13] ? deserial_sync_reg13 : 10'bz;
   assign parallel_out14 = parallel_enable[14] ? deserial_sync_reg14 : 10'bz;
   assign parallel_out15 = parallel_enable[15] ? deserial_sync_reg15 : 10'bz;

endmodule



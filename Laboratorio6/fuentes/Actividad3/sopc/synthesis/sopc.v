// sopc.v

// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module sopc (
		input  wire       clock_clk,     // clock.clk
		input  wire [7:0] in_export,     //    in.export
		output wire [7:0] out_export,    //   out.export
		input  wire       reset_reset_n  // reset.reset_n
	);

	wire  [31:0] cpu_data_master_readdata;                             // mm_interconnect_0:cpu_data_master_readdata -> cpu:d_readdata
	wire         cpu_data_master_waitrequest;                          // mm_interconnect_0:cpu_data_master_waitrequest -> cpu:d_waitrequest
	wire         cpu_data_master_debugaccess;                          // cpu:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:cpu_data_master_debugaccess
	wire  [19:0] cpu_data_master_address;                              // cpu:d_address -> mm_interconnect_0:cpu_data_master_address
	wire   [3:0] cpu_data_master_byteenable;                           // cpu:d_byteenable -> mm_interconnect_0:cpu_data_master_byteenable
	wire         cpu_data_master_read;                                 // cpu:d_read -> mm_interconnect_0:cpu_data_master_read
	wire         cpu_data_master_readdatavalid;                        // mm_interconnect_0:cpu_data_master_readdatavalid -> cpu:d_readdatavalid
	wire         cpu_data_master_write;                                // cpu:d_write -> mm_interconnect_0:cpu_data_master_write
	wire  [31:0] cpu_data_master_writedata;                            // cpu:d_writedata -> mm_interconnect_0:cpu_data_master_writedata
	wire  [31:0] cpu_instruction_master_readdata;                      // mm_interconnect_0:cpu_instruction_master_readdata -> cpu:i_readdata
	wire         cpu_instruction_master_waitrequest;                   // mm_interconnect_0:cpu_instruction_master_waitrequest -> cpu:i_waitrequest
	wire  [19:0] cpu_instruction_master_address;                       // cpu:i_address -> mm_interconnect_0:cpu_instruction_master_address
	wire         cpu_instruction_master_read;                          // cpu:i_read -> mm_interconnect_0:cpu_instruction_master_read
	wire         cpu_instruction_master_readdatavalid;                 // mm_interconnect_0:cpu_instruction_master_readdatavalid -> cpu:i_readdatavalid
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_chipselect;  // mm_interconnect_0:jtag_avalon_jtag_slave_chipselect -> jtag:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_avalon_jtag_slave_readdata;    // jtag:av_readdata -> mm_interconnect_0:jtag_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_waitrequest; // jtag:av_waitrequest -> mm_interconnect_0:jtag_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_avalon_jtag_slave_address;     // mm_interconnect_0:jtag_avalon_jtag_slave_address -> jtag:av_address
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_read;        // mm_interconnect_0:jtag_avalon_jtag_slave_read -> jtag:av_read_n
	wire         mm_interconnect_0_jtag_avalon_jtag_slave_write;       // mm_interconnect_0:jtag_avalon_jtag_slave_write -> jtag:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_avalon_jtag_slave_writedata;   // mm_interconnect_0:jtag_avalon_jtag_slave_writedata -> jtag:av_writedata
	wire  [31:0] mm_interconnect_0_id_control_slave_readdata;          // id:readdata -> mm_interconnect_0:id_control_slave_readdata
	wire   [0:0] mm_interconnect_0_id_control_slave_address;           // mm_interconnect_0:id_control_slave_address -> id:address
	wire  [31:0] mm_interconnect_0_cpu_debug_mem_slave_readdata;       // cpu:debug_mem_slave_readdata -> mm_interconnect_0:cpu_debug_mem_slave_readdata
	wire         mm_interconnect_0_cpu_debug_mem_slave_waitrequest;    // cpu:debug_mem_slave_waitrequest -> mm_interconnect_0:cpu_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_cpu_debug_mem_slave_debugaccess;    // mm_interconnect_0:cpu_debug_mem_slave_debugaccess -> cpu:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_cpu_debug_mem_slave_address;        // mm_interconnect_0:cpu_debug_mem_slave_address -> cpu:debug_mem_slave_address
	wire         mm_interconnect_0_cpu_debug_mem_slave_read;           // mm_interconnect_0:cpu_debug_mem_slave_read -> cpu:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_cpu_debug_mem_slave_byteenable;     // mm_interconnect_0:cpu_debug_mem_slave_byteenable -> cpu:debug_mem_slave_byteenable
	wire         mm_interconnect_0_cpu_debug_mem_slave_write;          // mm_interconnect_0:cpu_debug_mem_slave_write -> cpu:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_cpu_debug_mem_slave_writedata;      // mm_interconnect_0:cpu_debug_mem_slave_writedata -> cpu:debug_mem_slave_writedata
	wire         mm_interconnect_0_memory_s1_chipselect;               // mm_interconnect_0:memory_s1_chipselect -> memory:chipselect
	wire  [31:0] mm_interconnect_0_memory_s1_readdata;                 // memory:readdata -> mm_interconnect_0:memory_s1_readdata
	wire  [15:0] mm_interconnect_0_memory_s1_address;                  // mm_interconnect_0:memory_s1_address -> memory:address
	wire   [3:0] mm_interconnect_0_memory_s1_byteenable;               // mm_interconnect_0:memory_s1_byteenable -> memory:byteenable
	wire         mm_interconnect_0_memory_s1_write;                    // mm_interconnect_0:memory_s1_write -> memory:write
	wire  [31:0] mm_interconnect_0_memory_s1_writedata;                // mm_interconnect_0:memory_s1_writedata -> memory:writedata
	wire         mm_interconnect_0_memory_s1_clken;                    // mm_interconnect_0:memory_s1_clken -> memory:clken
	wire  [31:0] mm_interconnect_0_pio_in_s1_readdata;                 // pio_in:readdata -> mm_interconnect_0:pio_in_s1_readdata
	wire   [1:0] mm_interconnect_0_pio_in_s1_address;                  // mm_interconnect_0:pio_in_s1_address -> pio_in:address
	wire         mm_interconnect_0_pio_out_s1_chipselect;              // mm_interconnect_0:pio_out_s1_chipselect -> pio_out:chipselect
	wire  [31:0] mm_interconnect_0_pio_out_s1_readdata;                // pio_out:readdata -> mm_interconnect_0:pio_out_s1_readdata
	wire   [1:0] mm_interconnect_0_pio_out_s1_address;                 // mm_interconnect_0:pio_out_s1_address -> pio_out:address
	wire         mm_interconnect_0_pio_out_s1_write;                   // mm_interconnect_0:pio_out_s1_write -> pio_out:write_n
	wire  [31:0] mm_interconnect_0_pio_out_s1_writedata;               // mm_interconnect_0:pio_out_s1_writedata -> pio_out:writedata
	wire         irq_mapper_receiver0_irq;                             // jtag:av_irq -> irq_mapper:receiver0_irq
	wire  [31:0] cpu_irq_irq;                                          // irq_mapper:sender_irq -> cpu:irq
	wire         rst_controller_reset_out_reset;                       // rst_controller:reset_out -> [cpu:reset_n, id:reset_n, irq_mapper:reset, jtag:rst_n, memory:reset, mm_interconnect_0:cpu_reset_reset_bridge_in_reset_reset, pio_in:reset_n, pio_out:reset_n, rst_translator:in_reset]
	wire         rst_controller_reset_out_reset_req;                   // rst_controller:reset_req -> [cpu:reset_req, memory:reset_req, rst_translator:reset_req_in]
	wire         cpu_debug_reset_request_reset;                        // cpu:debug_reset_request -> rst_controller:reset_in1

	sopc_cpu cpu (
		.clk                                 (clock_clk),                                         //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                   //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                //                          .reset_req
		.d_address                           (cpu_data_master_address),                           //               data_master.address
		.d_byteenable                        (cpu_data_master_byteenable),                        //                          .byteenable
		.d_read                              (cpu_data_master_read),                              //                          .read
		.d_readdata                          (cpu_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (cpu_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (cpu_data_master_write),                             //                          .write
		.d_writedata                         (cpu_data_master_writedata),                         //                          .writedata
		.d_readdatavalid                     (cpu_data_master_readdatavalid),                     //                          .readdatavalid
		.debug_mem_slave_debugaccess_to_roms (cpu_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (cpu_instruction_master_address),                    //        instruction_master.address
		.i_read                              (cpu_instruction_master_read),                       //                          .read
		.i_readdata                          (cpu_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (cpu_instruction_master_waitrequest),                //                          .waitrequest
		.i_readdatavalid                     (cpu_instruction_master_readdatavalid),              //                          .readdatavalid
		.irq                                 (cpu_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (cpu_debug_reset_request_reset),                     //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_cpu_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_cpu_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_cpu_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_cpu_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_cpu_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_cpu_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_cpu_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_cpu_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                   // custom_instruction_master.readra
	);

	sopc_id id (
		.clock    (clock_clk),                                   //           clk.clk
		.reset_n  (~rst_controller_reset_out_reset),             //         reset.reset_n
		.readdata (mm_interconnect_0_id_control_slave_readdata), // control_slave.readdata
		.address  (mm_interconnect_0_id_control_slave_address)   //              .address
	);

	sopc_jtag jtag (
		.clk            (clock_clk),                                            //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                      //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver0_irq)                              //               irq.irq
	);

	sopc_memory memory (
		.clk        (clock_clk),                              //   clk1.clk
		.address    (mm_interconnect_0_memory_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_memory_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_memory_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_memory_s1_write),      //       .write
		.readdata   (mm_interconnect_0_memory_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_memory_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_memory_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),         // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),     //       .reset_req
		.freeze     (1'b0)                                    // (terminated)
	);

	sopc_pio_in pio_in (
		.clk      (clock_clk),                            //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),      //               reset.reset_n
		.address  (mm_interconnect_0_pio_in_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_pio_in_s1_readdata), //                    .readdata
		.in_port  (in_export)                             // external_connection.export
	);

	sopc_pio_out pio_out (
		.clk        (clock_clk),                               //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),         //               reset.reset_n
		.address    (mm_interconnect_0_pio_out_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_pio_out_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_pio_out_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_pio_out_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_pio_out_s1_readdata),   //                    .readdata
		.out_port   (out_export)                               // external_connection.export
	);

	sopc_mm_interconnect_0 mm_interconnect_0 (
		.clock_clk_clk                         (clock_clk),                                            //                       clock_clk.clk
		.cpu_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                       // cpu_reset_reset_bridge_in_reset.reset
		.cpu_data_master_address               (cpu_data_master_address),                              //                 cpu_data_master.address
		.cpu_data_master_waitrequest           (cpu_data_master_waitrequest),                          //                                .waitrequest
		.cpu_data_master_byteenable            (cpu_data_master_byteenable),                           //                                .byteenable
		.cpu_data_master_read                  (cpu_data_master_read),                                 //                                .read
		.cpu_data_master_readdata              (cpu_data_master_readdata),                             //                                .readdata
		.cpu_data_master_readdatavalid         (cpu_data_master_readdatavalid),                        //                                .readdatavalid
		.cpu_data_master_write                 (cpu_data_master_write),                                //                                .write
		.cpu_data_master_writedata             (cpu_data_master_writedata),                            //                                .writedata
		.cpu_data_master_debugaccess           (cpu_data_master_debugaccess),                          //                                .debugaccess
		.cpu_instruction_master_address        (cpu_instruction_master_address),                       //          cpu_instruction_master.address
		.cpu_instruction_master_waitrequest    (cpu_instruction_master_waitrequest),                   //                                .waitrequest
		.cpu_instruction_master_read           (cpu_instruction_master_read),                          //                                .read
		.cpu_instruction_master_readdata       (cpu_instruction_master_readdata),                      //                                .readdata
		.cpu_instruction_master_readdatavalid  (cpu_instruction_master_readdatavalid),                 //                                .readdatavalid
		.cpu_debug_mem_slave_address           (mm_interconnect_0_cpu_debug_mem_slave_address),        //             cpu_debug_mem_slave.address
		.cpu_debug_mem_slave_write             (mm_interconnect_0_cpu_debug_mem_slave_write),          //                                .write
		.cpu_debug_mem_slave_read              (mm_interconnect_0_cpu_debug_mem_slave_read),           //                                .read
		.cpu_debug_mem_slave_readdata          (mm_interconnect_0_cpu_debug_mem_slave_readdata),       //                                .readdata
		.cpu_debug_mem_slave_writedata         (mm_interconnect_0_cpu_debug_mem_slave_writedata),      //                                .writedata
		.cpu_debug_mem_slave_byteenable        (mm_interconnect_0_cpu_debug_mem_slave_byteenable),     //                                .byteenable
		.cpu_debug_mem_slave_waitrequest       (mm_interconnect_0_cpu_debug_mem_slave_waitrequest),    //                                .waitrequest
		.cpu_debug_mem_slave_debugaccess       (mm_interconnect_0_cpu_debug_mem_slave_debugaccess),    //                                .debugaccess
		.id_control_slave_address              (mm_interconnect_0_id_control_slave_address),           //                id_control_slave.address
		.id_control_slave_readdata             (mm_interconnect_0_id_control_slave_readdata),          //                                .readdata
		.jtag_avalon_jtag_slave_address        (mm_interconnect_0_jtag_avalon_jtag_slave_address),     //          jtag_avalon_jtag_slave.address
		.jtag_avalon_jtag_slave_write          (mm_interconnect_0_jtag_avalon_jtag_slave_write),       //                                .write
		.jtag_avalon_jtag_slave_read           (mm_interconnect_0_jtag_avalon_jtag_slave_read),        //                                .read
		.jtag_avalon_jtag_slave_readdata       (mm_interconnect_0_jtag_avalon_jtag_slave_readdata),    //                                .readdata
		.jtag_avalon_jtag_slave_writedata      (mm_interconnect_0_jtag_avalon_jtag_slave_writedata),   //                                .writedata
		.jtag_avalon_jtag_slave_waitrequest    (mm_interconnect_0_jtag_avalon_jtag_slave_waitrequest), //                                .waitrequest
		.jtag_avalon_jtag_slave_chipselect     (mm_interconnect_0_jtag_avalon_jtag_slave_chipselect),  //                                .chipselect
		.memory_s1_address                     (mm_interconnect_0_memory_s1_address),                  //                       memory_s1.address
		.memory_s1_write                       (mm_interconnect_0_memory_s1_write),                    //                                .write
		.memory_s1_readdata                    (mm_interconnect_0_memory_s1_readdata),                 //                                .readdata
		.memory_s1_writedata                   (mm_interconnect_0_memory_s1_writedata),                //                                .writedata
		.memory_s1_byteenable                  (mm_interconnect_0_memory_s1_byteenable),               //                                .byteenable
		.memory_s1_chipselect                  (mm_interconnect_0_memory_s1_chipselect),               //                                .chipselect
		.memory_s1_clken                       (mm_interconnect_0_memory_s1_clken),                    //                                .clken
		.pio_in_s1_address                     (mm_interconnect_0_pio_in_s1_address),                  //                       pio_in_s1.address
		.pio_in_s1_readdata                    (mm_interconnect_0_pio_in_s1_readdata),                 //                                .readdata
		.pio_out_s1_address                    (mm_interconnect_0_pio_out_s1_address),                 //                      pio_out_s1.address
		.pio_out_s1_write                      (mm_interconnect_0_pio_out_s1_write),                   //                                .write
		.pio_out_s1_readdata                   (mm_interconnect_0_pio_out_s1_readdata),                //                                .readdata
		.pio_out_s1_writedata                  (mm_interconnect_0_pio_out_s1_writedata),               //                                .writedata
		.pio_out_s1_chipselect                 (mm_interconnect_0_pio_out_s1_chipselect)               //                                .chipselect
	);

	sopc_irq_mapper irq_mapper (
		.clk           (clock_clk),                      //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.sender_irq    (cpu_irq_irq)                     //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (2),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.reset_in1      (cpu_debug_reset_request_reset),      // reset_in1.reset
		.clk            (clock_clk),                          //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
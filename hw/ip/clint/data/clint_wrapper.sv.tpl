module clint_wrapper (
    input  logic         clk_i,       // Clock
    input  logic         rst_ni,      // Asynchronous reset active low
    input  logic         testmode_i,

    // Req
    input  logic [47:0]  addr_i,
    input  logic         write_i,
    input  logic [31:0]  wdata_i,
    input  logic [3:0]   wstrb_i,
    input  logic         valid_i,

    // Rsp
    output logic [31:0]  rdata_o,
    output logic         error_o,
    output logic         ready_o,

    input  logic         rtc_i,       // Real-time clock in (usually 32.768 kHz)
    output logic [${cores-1}:0] timer_irq_o, // Timer interrupts
    output logic [${cores-1}:0] ipi_o        // software interrupt (a.k.a inter-process-interrupt)
);

    typedef struct packed {
        logic [47:0] addr;
        logic        write;
        logic [31:0] wdata;
        logic [3:0]  wstrb;
        logic        valid;
    } req_t;

    // Rsp
    typedef struct packed {
        logic [31:0] rdata;
        logic        error;
        logic        ready;
    } rsp_t;

    req_t reg_req;
    rsp_t reg_rsp;

    always_comb begin
        reg_req.addr  = addr_i;
        reg_req.write = write_i;
        reg_req.wdata = wdata_i;
        reg_req.wstrb = wstrb_i;
        reg_req.valid = valid_i;
    end

    always_comb begin
        rdata_o = reg_rsp.rdata;
        error_o = reg_rsp.error;
        ready_o = reg_rsp.ready;
    end

    clint #(
        .reg_req_t(req_t),
        .reg_rsp_t(rsp_t)
    ) i_clint (
        .clk_i      (clk_i),
        .rst_ni     (rst_ni),
        .testmode_i (testmode_i),
        .reg_req_i  (reg_req),
        .reg_rsp_o  (reg_rsp),
        .rtc_i      (rtc_i),
        .timer_irq_o(timer_irq_o),
        .ipi_o      (ipi_o)
    );

endmodule
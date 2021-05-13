
create_clock -period 20 [get_ports CLOCK2_50]
create_clock -period 20 [get_ports CLOCK3_50]
create_clock -period 20 [get_ports CLOCK4_50]
create_clock -period 20 [get_ports CLOCK_50]

derive_pll_clocks
derive_clock_uncertainty


# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]



########################################################################
# ADC  constration

###########
#Clock output from FPGA 
 #ADC-A – PLL_OUT_ADC0  
create_generated_clock -source [get_pins {U1|pll_100|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] \
                      -name clk_pll_out_adc0_virt [get_ports {ADC_CLK_A}] -phase -180
							 
set_input_delay -max -clock clk_pll_out_adc0_virt 8.726 [get_ports ADC_DA*]
set_input_delay -min -clock clk_pll_out_adc0_virt 4.701 [get_ports ADC_DA*]

#shift-window
set_multicycle_path -from [get_clocks {clk_pll_out_adc0_virt}] \
                    -to [get_clocks {U1|pll_100|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] \
						  -setup 2

#ADC-B – PLL_OUT_ADC1
create_generated_clock -source [get_pins {U1|pll_100|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] \
                      -name clk_pll_out_adc1_virt [get_ports {ADC_CLK_B}] -phase -180
							 
set_input_delay -max -clock clk_pll_out_adc1_virt 8.620 [get_ports ADC_DB*]
set_input_delay -min -clock clk_pll_out_adc1_virt 4.580 [get_ports ADC_DB*]

#shift-window
set_multicycle_path -from [get_clocks {clk_pll_out_adc1_virt}] \
                    -to [get_clocks {U1|pll_100|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] \
						  -setup 2

########################################################################
# DAC  constration

###########
#Clock output from FPGA 


#DAC-A – PLL_OUT_DAC0
create_generated_clock -source [get_pins {U1|pll_100|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] \
                      -name clk_pll_out_dac0_virt [get_ports {DAC_CLK_A}] -invert

#DAC-A – DAC_WRT_A
create_generated_clock -source [get_pins {U1|pll_100|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] \
                      -name clk_dac_wrt_a_virt [get_ports {DAC_WRT_A}] -invert
							 
set_output_delay -max -clock clk_dac_wrt_a_virt 1.944 [get_ports DAC_DA*]
set_output_delay -min -clock clk_dac_wrt_a_virt -1.593 [get_ports DAC_DA*]

#DAC-B – PLL_OUT_DAC1
create_generated_clock -source [get_pins {U1|pll_100|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] \
                      -name clk_pll_out_dac1_virt [get_ports {DAC_CLK_B}] -invert

#DAC-B – DAC_WRT_B
create_generated_clock -source [get_pins {U1|pll_100|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] \
                      -name clk_dac_wrt_b_virt [get_ports {DAC_WRT_B}] -invert

set_output_delay -max -clock clk_dac_wrt_b_virt 1.880 [get_ports DAC_DB*]
set_output_delay -min -clock clk_dac_wrt_b_virt -1.643 [get_ports DAC_DB*]




						  

#**************************************************************
# Set False Path
#**************************************************************
# Asynchronous I/O
#set_false_path -from [get_ports KEY*] -to *
#set_false_path -from [get_ports SW*] -to *
#set_false_path -from * -to [get_ports LED* ]


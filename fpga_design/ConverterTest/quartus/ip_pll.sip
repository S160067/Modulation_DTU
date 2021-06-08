set_global_assignment -entity "ip_pll" -library "lib_ip_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "ip_pll" -library "lib_ip_pll" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "ip_pll" -library "lib_ip_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_ip_pll" -name SPD_FILE [file join $::quartus(sip_path) "ip_pll.spd"]

set_global_assignment -library "lib_ip_pll" -name MISC_FILE [file join $::quartus(sip_path) "ip_pll_sim/ip_pll.vho"]

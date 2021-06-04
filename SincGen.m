function cnt = SincGen(pulse_width,data_width)
    s=(pi)/(floor((pulse_width)/2))    
    disp("case phase_i is") 
    cnt = 0;
    
    for x = -pi:s:(pi)
       y=sinc(x);    
       y=round(y*(2^data_width)); %convert to FPGA readable version, equilevant to a data_width bit shift
       y = dec2hex(y,4);   %convert to hex for VHDL readability
       test =['when b"',dec2bin(cnt,5),'" => cos_temp <=x"',y,'";'];
       disp(test)
       
       cnt = cnt+1;
    end 
    disp('when others => c_out <=x"FFFF";');
    disp('end case;')
end
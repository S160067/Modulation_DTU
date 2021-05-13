function cnt = CosGen(pulse_width,data_width)
    s=(pi)/(floor((pulse_width)/2))    
    disp("case phase_i is") 
    cnt = 0;
    
    for x = 0:s:(2*pi)
       y=cos(x);    
       y=round(y*(2^data_width)); %convert to FPGA readable version, equilevant to a data_width bit shift
       y = dec2hex(y,ceil(data_width/4));   %convert to hex for VHDL readability
       test =['when x"',dec2hex(cnt,bitshift(pulse_width,-3)),'" => cos_out <=x"',y,'";'];
       disp(test)
       
       cnt = cnt+1;
    end 
    disp('when others => c_out <=x"FFFF";');
end
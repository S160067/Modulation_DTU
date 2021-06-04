function cnt = SinGen(pulse_width,data_width)
    s=(pi)/(floor((pulse_width)/2))    
    disp("case phase_i is") 
    cnt = 0;
    
    for x = 0:s:(2*pi)
       y=sin(x);    
       y=round(y*(2^data_width)); %convert to FPGA readable version, equilevant to a data_width bit shift
       y = dec2hex(y,2);   %convert to hex for VHDL readability
       output_string =['when b"',dec2bin(cnt,5),'" => sin_temp <=x"',y,'";'];
       disp(output_string)
       
       cnt = cnt+1;
    end 
    disp('when others => sin_temp <=x"FFFF";'); %if others, print unrealistic value we can easily spot
    disp('end case;')
end
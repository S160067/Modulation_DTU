function cnt = SinGen(pulse_width,data_width)
    s=(pi)/(floor((pulse_width)/2))    
    disp("case phase_i is") 
    cnt = 0;
    
    for x = 0:s:(2*pi)
       y=sin(x);    
       y=round(y*(2^data_width)); %convert to FPGA readable version, equilevant to a data_width bit shift
       y = dec2hex(y,ceil(data_width/8));   %convert to hex for VHDL readability
       output_string =['when x"',dec2hex(cnt,bitshift(pulse_width,-3)),'" => sin_out <=x"',y,'";'];
       disp(output_string)
       
       cnt = cnt+1;
    end 
    disp('when others => sin_out <=x"FFFF";'); %if others, print unrealistic value we can easily spot
end
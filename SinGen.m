function cnt = SinGen(pulse_width,data_width)
    s=(pi)/(floor((pulse_width)/2));    
    disp("case phase_i is") 
    cnt = 0;
    bitlength=length(dec2bin(pulse_width-1));
    for x = 0:s:(2*pi)
       y=sin(x)*8192+8191;
       y=uint32(y);
       y=dec2bin(y,data_width);
       output_string =['when b"',dec2bin(cnt,bitlength),'" => sin_temp <="',y,'";'];
       disp(output_string)
       cnt = cnt+1;
    end 
    disp('when others => sin_temp <=x"1111111111111";'); 
end
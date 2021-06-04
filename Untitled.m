pulse_width = 17;
data_width = 14;
s=(pi)/(floor((pulse_width)/2))    
disp("case phase is") 
cnt = 0;
for x = 0:s:(2*pi)
    y=cos(x);    
    y=round(y*(2^data_width)); %convert to FPGA readable version, equilevant to a data_width bit shift
    y = dec2hex(y,ceil(data_width/4));   %convert to hex for VHDL readability
    %fprintf('when "%d" => sin_out <= x"%d"; \n',cnt, y);
    disp(cnt)
    disp(y)
    cnt = cnt+1;
end 

%{
  This is a function intended to fetch data from a file n bits at a time
it is intended as a simulation only tool and serves as a
software/simulation version of the FIFO between modulation block and encoding.
input is a filename and pointer for the current starting, output is an array
of bits. Output length is static but exact dimensions have not been decided
yet
  
%}

function [bitstream] = filereader(filename, ptr)  

%todo

return bitstream
end


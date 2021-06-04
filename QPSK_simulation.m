% QPSK TX
clc, clear all, close all
T = 250e-6; %sampling period
K = 2^10; %length of input sequence
m=8; %oversampling factor
Ts=T/m; %oversampling period
const = [1+1j 1-1j -1+1j -1-1j]'; %symbols in QPSK
Pav = mean(abs(const).^2); %mean power of the modulation
SNR = -2:1:10; %defining SNR of interest
sigmasq = Pav./10.^(SNR./10); %converting SNR to variance
Kp=8;       %Length(/T) of time pulse
alpha=0.25;
c=1;
% Pulse in frequency domain:
Np=Kp*m;
% Boundaries for pieces of function
% Remember that frequency resolution is 1/KT
N1=floor((1-alpha)/(2*T)/(1/(Kp*T))); % End of constant piece
N2=floor((1+alpha)/(2*T)/(1/(Kp*T))); % End of roll-off piece
N3=Np/2-1;                            % End of zero piece
GT=sqrt(c*T)*[ones(1,N1+1) cos((2*pi*[N1+1:N2]/(Kp*T)*T-pi)/4/alpha+pi/4) zeros(1,N3-N2)];
GT=[GT 0 fliplr(GT(2:end))]; 
gT=fftshift(real(ifft(GT)/Ts)); %pulse in time domain
% Completely symmetric pulse:
gT=[gT(1)/2 gT(2:end) gT(1)/2];
gT = gT/max(gT); %normalization
gR=fliplr(gT)/(sum(gT.^2));
a= randi(4, 1, K); % generation of random bit sequence
a= a-3;
for k = 1:K %mapping
    if a(k) == -2
        a(k) = -1j;
    end

    if a(k) == 0
        a(k) = 1j;
    end
end
f=conv(gT,upsample(real(a),m)); %FIR pulse shaping filter
f = f(33:end-32); %removing convolution residual
g=conv(gT,upsample(imag(a),m));
g = g(33:end-32);
omegac=pi/4/Ts;
t=0:Ts:(length(f)-1)*Ts; %time scale
v=f.*(cos(omegac*t)*sqrt(2))+g.*(sin(omegac*t)*sqrt(2)); %to be sent to DAC
errate = [];

for i= sigmasq %iterate over different variances of the noise
    vnoi = v + sqrt(i)*randn(1, length(v)); %adding noise
    frnoi = vnoi.*(cos(omegac*t)*sqrt(2));
    grnoi = vnoi.*(sin(omegac*t)*sqrt(2));
    frmnoi= conv(frnoi, gR); %deshaping
    frmnoi = frmnoi(33:8:end-32);
    grmnoi= conv(grnoi, gR); 
    grmnoi = 1j*grmnoi(33:8:end-32);
    arnoi = frmnoi+grmnoi;
    for k = 1:length(arnoi) % demapping
        if ((angle(arnoi(k)) >= -pi/4) & (angle(arnoi(k)) <= pi/4))
            arnoi(k) = 1; 
        elseif ((angle(arnoi(k)) > pi/4) & (angle(arnoi(k)) < 3*pi/4))
            arnoi(k) = 1j;
        elseif ((angle(arnoi(k)) < -pi/4) & (angle(arnoi(k)) > -3*pi/4))
            arnoi(k) = -1j;
        elseif ((angle(arnoi(k)) >= 3*pi/4) | (angle(arnoi(k)) <= -3*pi/4))
            arnoi(k) = -1;
        end 
    end
    res = arnoi ~= a; %comparing obtained sequence with original sequence
    errate = [errate sum(res, 'all')/numel(res)];
end
semilogy(SNR, errate) %SNR to BER graph
hold on, grid on
xlabel('SNR (dB)')
ylabel('Bit error rate (Log scale)')
title('SNR to BER curve')


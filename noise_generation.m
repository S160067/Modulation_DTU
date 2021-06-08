clc, clear all;
N = 17;
maxn = 2^13;
t = linspace(0,0.1, N);
normn = randn(1, 17); % normal random noise
normn = normn / max(normn);
normn = round(maxn.*normn);
chirpn = chirp(t, 20, t(end), 1000);
chirpn = chirpn/max(chirpn);
chirpn = round(chirpn .* maxn);
for k=1:N
        if normn(k) >= maxn
            normn(k) = maxn-1;
        end
        fprintf('s_pulse(%d) <= to_signed(%d, s_noise(0)''length);\n', k-1, normn(k));
end
    fprintf('\n'); 





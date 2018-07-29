% frequency() is a function to calculate parameters for frequency analysis 
% such as power spectrum

function [Welch,FFT] = frequency(N_samples,volts,sample_rate)

% Parameters for Plotting FFT
FFT.n = 2^nextpow2(N_samples);
FFT.trans = fft(volts,FFT.n);
FFT.f = sample_rate*(0:(FFT.n/2))/FFT.n;
FFT.P = abs(FFT.trans/FFT.n);

% Parameters for Plotting Pwelchs PSD
Nfft = 2^(floor(log(N_samples)/log(2)));
[Welch.PSD,Welch.f] = pwelch(volts,gausswin(Nfft),Nfft/2,Nfft,sample_rate);
[~,loc] = max(Welch.PSD);
Welch.f_est = Welch.f(loc);
end
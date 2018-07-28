clc;clear;close all

% Load Signal. The signal should be a text file with two columns
% The file should be located in the MATLAB working directory
% Column 1 is the sample (time, etc), Column 2 is the measurement (V, etc)
signal = load('Em25ms10kSs.txt');

% Sampling parameters of the signal
[Nsamples,samples,voltages,rate] = sampling(signal);

% frequency components of the signal
[welch,FastFT] = frequency(Nsamples,voltages,rate);

% plot the original signal
figure(1)
subplot(3,1,1)
grid on
plot (samples,voltages)
title('Original Signal Waveform')
xlabel('Time (seconds)'); ylabel('Voltage (mV)')

% plot the Power of the frequencies from n-point fft function 
figure(1)
subplot(3,1,2)
plot(FastFT.f,FastFT.P(1:FastFT.n/2+1))
title('FFT of signal')
xlabel('Frequency (Hz)'); ylabel('|P(f)|')

% plot the PSD using pwelch (should be comparable to previous fft plot)
figure(1)
subplot(3,1,3)
plot(welch.f,welch.PSD)
title(['estimated frequency: ',num2str(welch.f_est),' hz'])
xlabel('Frequency (Hz)'); ylabel('PSD')
hold off
    
% design the filters (low-pass, high-pass, band-pass, band-stop)
Filter = design_filters(rate);

% loop to plot filter related things
response(1,1:4) = {[]};
for k = 1:4
    % filter the original signal with each filter
    filtered_signal = filter(Filter{k},voltages);
    delay = mean(grpdelay(Filter{k}));
    samplesAdj = samples(1:end-delay);
    voltagesAdj = voltages(1:end-delay);
    filtered_signalAdj = filtered_signal;
    filtered_signalAdj(1:delay) = [];
    
    % plot each filtered signal overlayed on the original signal
    % NOTE THAT THIS IS ADJUSTED FOR PHASE DELAY. 
    % DEPENDING ON SIGNAL, MAY THROW A WARNING 
    % ADJUST THE FILTER PASSBAND/STOPBAND VALUES
    figure(2)
    subplot(2,2,k)
    plot(samplesAdj,voltagesAdj)
    hold on, plot(samplesAdj,filtered_signalAdj,'-r','linewidth',1.5), hold off
    xlim([0,0.15])
    xlabel('Time (s)')
    ylabel('Amplitude (mV)')
    legend('Original Signal','Filtered Data')
    
    % Magnitude Frequency response of each filter in figures 3 - 6
    response{k}=fvtool(Filter{k});
end



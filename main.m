clc;clear;close all

% Load Signal. The signal should be a text file with two columns
% The file should be located in the MATLAB working directory
% Column 1 is the sample (time, etc), Column 2 is the measurement (V, etc)
signal = load('Em25ms10kSs.txt');

% Sampling parameters of the signal
[Nsamples,samples,voltages,rate] = sampling(signal);

% frequency components of the signal
[PSD,freq,estimated_f,FastFT] = frequency(Nsamples,voltages,rate);

% plot the original signal
figure(1)
subplot(3,1,1)
grid on
plot (samples,voltages)
title('Original Signal Waveform')
xlabel('Time (seconds)'); ylabel('Voltage (mV)')
title('Voltage vs time')

% plot the Power of the frequencies from fft function
figure(1)
subplot(3,1,2)
plot(FastFT.f,FastFT.P(1:FastFT.n/2+1))
title('FFT of signal')
xlabel('Frequency (Hz)'); ylabel('|P(f)|')

% plot the PSD using pwelch
figure(1)
subplot(3,1,3)
plot(freq,PSD)
title(['estimated frequency: ',num2str(estimated_f),' hz'])
xlabel('Frequency (Hz)'); ylabel('PSD')
hold off
    
%design the filters (low-pass, high-pass, band-pass, band-stop)
%
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

% downsample and plot
signal2sample = signal;
dSample_factor(1,1:4)={[]};
for i = 1:4
    dSample_factor{i} = downsample(signal2sample,2);
    signal2sample = dSample_factor{i};
    
    %arrays of samples and voltages
    [Ntime,~] = size(signal2sample);
    TIME = signal2sample(:,1);
    VOLT = signal2sample(:,2);
    
    %get sample rate (frequency)
    MAX_SAMPS = max(TIME);
    SAMPY_RATE = Ntime/MAX_SAMPS;
    
    figure(7)
    subplot(2,2,i)
    grid on
    plot(TIME,VOLT)
    title(['Downsampled Waveform. Sample Rate = ',...
        num2str(round(SAMPY_RATE)),' hZ'])
    xlabel('Time (seconds)'); ylabel('Voltage (mV)')
    xlim([0,0.25])
end
hold off
clear i; clear signal2sample;

% SAMPLING(my_signal) is a function to calculate sampling parameters
function [num_samples,sample_array,voltage_array,sample_rate] ...
    = sampling(my_signal)

%Number of Samples
[num_samples,~] = size(my_signal);

%arrays of samples and voltages
sample_array = my_signal(:,1);
voltage_array = my_signal(:,2)*1000;

%get sample rate (frequency)
max_sample = max(sample_array);
sample_rate = num_samples/max_sample;
end

% frequency(N_samples,volts,sample_rate) is a function to calculate
% parameters for plotting frequency spectrum graphs
function [Pxx,f,signalf_estimate,FFT] = ...
    frequency(N_samples,volts,sample_rate)

% Parameters for Plotting FFT
FFT.n = 2^nextpow2(N_samples);
FFT.trans = fft(volts,FFT.n);
FFT.f = sample_rate*(0:(FFT.n/2))/FFT.n;
FFT.P = abs(FFT.trans/FFT.n);

% Parameters for Plotting Pwelchs PSD
Nfft = 2^(floor(log(N_samples)/log(2)));
[Pxx,f] = pwelch(volts,gausswin(Nfft),Nfft/2,Nfft,sample_rate);
[~,loc] = max(Pxx);
signalf_estimate = f(loc);
end

% design_filters(samp_rate) creates four minimum order FIR filters based
% on the sampling rate of the original signal
function [filt] = design_filters(samp_rate)

%low-pass IIR min-order filter
filt{1} = designfilt('lowpassfir', ...
    'PassbandFrequency',650,'StopbandFrequency',700,...
    'StopbandAttenuation',80,'PassbandRipple',1,...
    'DesignMethod','equiripple','SampleRate',samp_rate);

filt{2} = designfilt('highpassfir',...
    'PassbandFrequency',85,'StopbandFrequency',70,...
    'StopbandAttenuation',80,'PassbandRipple',1,...
    'DesignMethod','equiripple','SampleRate',samp_rate);

filt{3} = designfilt('bandpassfir', ...
    'StopbandFrequency1',70,'PassbandFrequency1',85,...
    'PassbandFrequency2',650,'StopbandFrequency2',700,...
    'StopbandAttenuation1',80,'PassbandRipple',1,...
    'StopbandAttenuation2',80,'DesignMethod','equiripple',...
    'SampleRate',samp_rate);

filt{4} = designfilt('bandstopfir', ...
    'StopbandFrequency1',250,'PassbandFrequency1',230,...
    'PassbandFrequency2',350,'StopbandFrequency2',330,...
    'StopbandAttenuation',80,'PassbandRipple1',1,...
    'PassbandRipple2',1,'DesignMethod','equiripple',...
    'SampleRate',samp_rate);
end
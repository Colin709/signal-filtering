clc;clear;close all

% Load Signal. The signal should be a text file with two columns
% The file should be located in the MATLAB working directory
% Column 1 is the sample (time, etc), Column 2 is the measurement (V, etc)
signal = load('Em25ms10kSs.txt');

% Sampling parameters of the signal
[Nsamples,samples,voltages,FS_orig] = sampling(signal);

% frequency components of the signal
[welch,FastFT] = frequency(Nsamples,voltages,FS_orig);

% display command window text to distract the impatient user
disp('This may take a minute- chill the heck out!')

% plot the original signal
figure
subplot(3,1,1)
grid on
plot (samples,voltages)
title('Original Signal Waveform')
xlabel('Time (seconds)'); ylabel('Voltage (mV)')

% plot the Power of the frequencies from n-point fft function 
subplot(3,1,2)
plot(FastFT.f,FastFT.P(1:FastFT.n/2+1))
title('FFT of signal')
xlabel('Frequency (Hz)'); ylabel('|P(f)|')

% plot the PSD using pwelch (should be comparable to previous fft plot)
subplot(3,1,3)
plot(welch.f,welch.PSD)
title(['estimated frequency: ',num2str(welch.f_est),' hz'])
xlabel('Frequency (Hz)'); ylabel('PSD')
pause(1)

% design the filters (low-pass, high-pass, band-pass, band-stop)
Filt = Filter.design_filters(FS_orig);
[~,Nfilters] = size(Filt);

% plot the filter responses
[filteredSignal,filteredSignal_adjusted] = ...
     Filter.plot_filters(Nfilters,Filt,voltages,samples);

% downsampled signals plotted in function, and returned to main so I can
%   play with the signals. 
% downsample the signal by consecutive integers and plot
downsampled = downSample.DownSample_ones(signal,Nfilters);
% downsample the signal by multiples of 2 and plot
% introduces aliasing faster than consecutive integers
downsampled_aliasing = downSample.DownSample_twos(signal,Nfilters);



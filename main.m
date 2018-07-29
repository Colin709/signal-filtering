clc;clear;close all
tic
% Load Signal. The signal should be a text file with two columns
% The file should be located in the MATLAB working directory
% Column 1 is the sample (time, etc), Column 2 is the measurement (V, etc)
% The Signal class will create an instance of the signal object with
%   sampling and frequency properties
input_signal = load('Em25ms10kSs.txt');
signal = Signal(input_signal);

% display command window text to distract the impatient user
disp('This may take a minute- chill the heck out!')

% plot the original signal
figure
subplot(3,1,1)
grid on
plot(signal.samples,signal.values)
title('Original Signal Waveform')
xlabel('Time (seconds)'); ylabel('Voltage (mV)')

% plot the Power of the frequencies from n-point fft function 
subplot(3,1,2)
plot(signal.FFT.f,signal.FFT.P(1:signal.FFT.n/2+1))
title('FFT of signal')
xlabel('Frequency (Hz)'); ylabel('|P(f)|')

% plot the PSD using pwelch (should be comparable to previous fft plot)
subplot(3,1,3)
plot(signal.Welch.f,signal.Welch.PSD)
title(['estimated frequency: ',num2str(signal.Welch.f_est),' hz'])
xlabel('Frequency (Hz)'); ylabel('PSD')
pause(1)

% design the filters (low-pass, high-pass, band-pass, band-stop)
Filt = Filter.design_filters(signal.FS);
[~,Nfilters] = size(Filt);

% plot the filter responses
[filteredSignal,filteredSignal_adjusted] = ...
     Filter.plot_filters(Nfilters,Filt,signal.values,signal.samples);

% downsampled signals plotted in function, and returned to main so I can
%   play with the signals. 
% downsample the signal by consecutive integers and plot
downsampled = downSample.DownSample_ones(input_signal,Nfilters);
% downsample the signal by multiples of 2 and plot
% introduces aliasing faster than consecutive integers
downsampled_aliasing = downSample.DownSample_twos(input_signal,Nfilters);
toc

% plot the downsampled signals

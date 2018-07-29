%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal_Filtering: main
%
% author: Colin King - July 29, 2018
%
% This MATLAB script is used to load and plot a signal, plot the PSD using
%   FFT and Welch's Method and downsample the signal using two different
%   methods to check for aliasing.
% Required files include the three created class files:
%   Signal.m, Filters.m, downSample.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all
tic
% Set the envelope 1 if you want peak envelope detection on downsamples,
%   set to 0 otherwise
% Peak is used to determine the number of samples between peak detection
p_envelope = 0;
Peak = 100;
NdownSamples = 4;

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
plot(signal.samples,signal.values*1000)
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

% downsample by 4 factors
ds_Signal(1,1:NdownSamples) = {[]};
for j = 1:NdownSamples
    ds_Signal{j} = downSample(input_signal,j+1);
    
    % plot the downsampled signals in a 2x2 figure
    subplot(2,2,j)
    grid on
    plot(ds_Signal{j}.samples,ds_Signal{j}.values*1000)
    title(['Downsampled Sample Rate = ',...
        num2str(round(ds_Signal{j}.FS)),' hZ'])
    xlabel('Time (seconds)'); ylabel('Voltage (mV)')
    xlim([0,max(ds_Signal{j}.samples)])
    ylim([min(ds_Signal{j}.values*1000)*1.05, ...
        max(ds_Signal{j}.values*1000)*1.05])
    if p_envelope == true
        [up,lo] = envelope((ds_Signal{j}.values*1000),...
            round(ds_Signal{j}.Nsamples/Peak),'peak');
        hold on
        plot(ds_Signal{j}.samples,up,ds_Signal{j}.samples,lo,...
            'linewidth',1.5)
        legend('voltages','up','lo')
        hold off
        clear up lo
    end
end

%design the filters (low-pass, high-pass, band-pass, band-stop)
myFilters = Filters(signal.FS);
[Nfilters,~] = size(properties(myFilters));
filt{1} = myFilters.LPF;
filt{2} = myFilters.HPF;
filt{3} = myFilters.BPF;
filt{4} = myFilters.BSF;

% apply the filters to the signal
filtered_signal(1,1:Nfilters) = {[]};
for k = 1:Nfilters
    filtered_signal{k} = filter(filt{k},signal.values);
end

% adjust the overlay to compensate for phase delay
Adjustment = adjust(filt,signal,filtered_signal);
% plot the filter stuff
figure
for k = 1:Nfilters
    subplot(2,2,k); plot(Adjustment.samples{k},Adjustment.values{k}*1000);
    hold on
    plot(Adjustment.samples{k},Adjustment.filtered_signal{k}*1000,...
        '-r','linewidth',1.5),hold off
    xlim([0,0.15])
    xlabel('Time (s)'); ylabel('Voltage (mV)')
    legend('Original Signal','Filtered Data')
end

% Magnitude Frequency response of each filter in 4 figures
response(1,1:Nfilters) = {[]};
for p = 1:Nfilters
    response{p}=fvtool(filt{p});
end
toc

function [adjusted] = adjust(Filt,signal_,filtered_signal_)
for z = 1:4
    delay = mean(grpdelay(Filt{z}));
    adjusted.samples{z} = signal_.samples(1:end-delay);
    adjusted.values{z} = signal_.values(1:end-delay);
    adjusted.filtered_signal{z} = filtered_signal_{z};
    adjusted.filtered_signal{z}(1:delay) = [];
end
end

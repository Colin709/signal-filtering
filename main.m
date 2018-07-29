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

NdownSamples = 4;
% create an instance of downsampled signal without aliasing
aliasing = false;
correct_downSampling = downSample(input_signal,NdownSamples,aliasing);

% create an instance of downsampled signal with aliasing
aliasing = true;
aliased_downSampling = downSample(input_signal,NdownSamples,aliasing);

% design the filters (low-pass, high-pass, band-pass, band-stop)
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
    subplot(2,2,k); plot(Adjustment.samples{k},Adjustment.values{k});
    hold on,plot(Adjustment.samples{k},Adjustment.filtered_signal{k},...
        '-r','linewidth',1.5),hold off
    xlim([0,0.15])
    xlabel('Time (s)'); ylabel('Amplitude (mV)')
    legend('Original Signal','Filtered Data')
end

response(1,1:Nfilters) = {[]};
for p = 1:Nfilters
    % Magnitude Frequency response of each filter in 4 figures
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

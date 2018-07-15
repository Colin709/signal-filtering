%%%%%%%%%Filter Design%%%%%%%%%%%%%%%%%%%
% MATLAB Code for filter design
% DSP Assignment
% Memorial University of Newfoundland
% Colin King - 200842029 - cbk618
% July 13, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;

%user input
[input_signal,filter_bounds,filter_response,fc,sigma,ripple] = userinput();

%process the signal file and assign values to the Signal Class
mySignal = signal_class(input_signal);

%design the filter
myFilter = ...
    filter_class(filter_bounds,filter_response,fc,mySignal.sampling_f,sigma,ripple);

% plot the voltages and time
subplot(2,1,1)
grid on
plot (mySignal.time,mySignal.voltage)
title('Original Signal Waveform')
xlabel('Time (seconds)'); ylabel('Voltage (mV)')
title('Voltage vs time')

% plot the frequency spectrum
subplot(2,1,2)
plot(mySignal.sampled_f,mySignal.PSD)
title(['estimated frequency: ',num2str(mySignal.estimated_f),' hz'])
xlabel('Frequency (Hz)'); ylabel('PSD')

%Use fvtool to show frequency response
response = fvtool(myFilter.designed_filter,'FS',mySignal.sampling_f);

%apply filter and plot
filtered_signal = filter(myFilter.designed_filter,mySignal.voltage);
plot(mySignal.time,mySignal.voltage,mySignal.time,filtered_signal)
xlim([0 1])
xlabel('Time (s)')
ylabel('Amplitude (mV)')
legend('Original Signal','Filtered Data')






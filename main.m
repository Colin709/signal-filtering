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


function [got_signal,IIR_FIR,get_filter,cutoff_frequency,the_order,the_ripple] ...
    = userinput()
%function to take user input for signal file and filter type
%consider breaking this into separate functions for input and load

%prompt user to load a signal file (has to be in working directory)
prompt = ['Which signal file would you like to load? \nOptions: ' ...
    '\n-press enter for previous config ' ...
    '\n-type "dir" to view available files ' ...
    '\nNOTES: ' ...
    '\n-signal files should be in MATLAB working path ' ...
    '\n-type the file name without the directory or .txt\n\n '];
get_signal = input(prompt,'s');
if strcmp(get_signal,'dir')
    while 1
        clc; dir **/*.txt
        get_signal = input(prompt,'s');
        if ~strcmp(get_signal,'dir')
            break
        end
    end
end
if strcmp(get_signal,'')
    load('LastSetup.mat','got_signal','IIR_FIR','get_filter', ...
        'cutoff_frequency','the_order','the_ripple')
    return
end
got_signal = load([get_signal,'.txt']);

%prompt user to specify FIR or IIR Filter
prompt = '\nWould you like to use a FIR or IIR filter?: ';
IIR_FIR = input(prompt,'s');
if ~strcmp(IIR_FIR,'FIR') && ~strcmp(IIR_FIR,'IIR')
    error('Error: ya gotta specify FIR or IIR')
end

%prompt user for filter type
prompt = '\nWhich filter would you like to use?(LPF,HPF,BPF,BSF): ';
get_filter = input(prompt,'s');

%prompt user for cutoff frequency/frequencies
if strcmp(get_filter,'LPF') || strcmp(get_filter,'HPF')
    prompt = '\nWhat is the cutoff frequency?: ';
    cutoff_frequency = input(prompt);
elseif strcmp(get_filter,'BPF') || strcmp(get_filter,'BSF')
    prompt = '\nWhat is the lower cutoff frequency?: ';
    cutoff_frequency(1) = input(prompt);
    prompt = '\nWhat is the upper cutoff frequency?: ';
    cutoff_frequency(2) = input(prompt);
else
    error('Error: not a valid filter')
end

%prompt user to specify order
prompt = '\nWhat is the order of the filter?: ';
the_order = input(prompt);

%specify a ripple only if IIR
if strcmp(IIR_FIR,'IIR')
    prompt = '\nWhat is the ripple of the filter?: ';
    the_ripple = input(prompt,'s');
else 
    the_ripple = [];
end 

%save local variables for future use
save('LastSetup.mat','got_signal','IIR_FIR','get_filter', ...
    'cutoff_frequency','the_order','the_ripple')
end




%%%%%%%%%Filter Design%%%%%%%%%%%%%%%%%%%
% MATLAB Code for filter design
% DSP Assignment
% Memorial University of Newfoundland
% Colin King - 200842029 - cbk618
% July 13, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear; clc;

%user input
[theSignal,filter_response,filter_type,fc,order] = userinput();

%process the signal file
[time,voltage,rowsize,colsize] = process_signal(theSignal);

%calculate sampling rate
[fsamp,nyquist] = samplerate(time,rowsize);

%design filter the filter
theFilter = design_filter(filter_response,filter_type,fc,fsamp,order);

% plot the voltages and time
subplot(2,1,1)
grid on
plot (time,voltage)
title('Guitar String Waveform')
xlabel('Time (seconds)'); ylabel('Voltage (mV)')
title('Voltage vs time')

% calculate and plot the frequency spectrum
[PowerSD,fhz,estimated_freq] = spectral_analysis(fsamp,voltage);
subplot(2,1,2)
plot(fhz,PowerSD)
title(['estimated freq: ',num2str(estimated_freq),' hz'])
xlabel('Frequency (Hz)'); ylabel('PSD')

%Use fvtool to show frequency response 
response = fvtool(theFilter,'FS',fsamp);

%apply filter and plot
filtered_signal = filter(theFilter,voltage);
plot(time,voltage,time,filtered_signal)
xlim([0 1])
xlabel('Time (s)')
ylabel('Amplitude (mV)')
legend('Original Signal','Filtered Data')

%function to take user input for signal file and filter type
%consider breaking this into separate functions for input and load
function [got_signal, filter_bounds, get_filter, cutoff_frequency, IIR_order] = userinput()
%prompt user to load a signal file (has to be in working directory)
prompt = ['Which signal file would you like to load? \nOptions: ' ...
    '\n-press enter for previous config ' ...
    '\n-type "dir" to view available files ' ...
    '\nNOTES: ' ...
    '\n-signal files should be in "signals" subdirectory ' ...
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
   load('LastSetup.mat','got_signal','filter_bounds','get_filter','cutoff_frequency', 'IIR_order')
   return 
end 
got_signal = load(['signals/',get_signal,'.txt']);

%prompt user to specify FIR or IIR Filter
prompt = '\nWould you like to use a FIR or IIR filter?: ';
filter_bounds = input(prompt,'s');
if ~strcmp(filter_bounds,'FIR') && ~strcmp(filter_bounds,'IIR')
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
IIR_order = input(prompt);

%save local variables for future use
save('LastSetup.mat','got_signal','filter_bounds','get_filter','cutoff_frequency', 'IIR_order')
end 

%function to process signal file, make adjustments to time and voltage
function [adjustedTime,adjustedVoltage,rows,cols] = process_signal(chosen_file)
% Access the time and voltage in columns 1 and 2
time_ = chosen_file(: , 1);
voltage_ = chosen_file(: , 2);

% Retrieve number of rows and columns 
[rows,cols] = size(chosen_file);

% Adjust time to start at 0 and v to be in mV
adjustedTime = time_ - time_(1);
adjustedVoltage = voltage_*1000;
end

%function to get sample rate (as frequency)
function [sample_frequency,nyquist_frequency] = samplerate(sampleTime,sampleRows)
Nsamps = sampleRows;
Tsamp = max(sampleTime)/Nsamps;
sample_frequency = 1/Tsamp;
nyquist_frequency = sample_frequency/2;
%t = (0:Nsamps-1)*Tsamp;
end 

%function to calculate PSD using FFT
function [Pxx,f,signalf_estimate] = spectral_analysis(freq_samp,volty)
% Choose FFT size and calculate spectrum
Nfft = 2048;
[Pxx,f] = pwelch(volty,gausswin(Nfft),Nfft/2,Nfft,freq_samp);

% Get frequency estimate (spectral peak)
[~,loc] = max(Pxx);
signalf_estimate = f(loc);
end 

function filter_name = design_filter(fir_or_iir,theFilter,cutf,sampf,iir_order)
%Design Filters
switch fir_or_iir
    case 'FIR'
        if  strcmp(theFilter,'LPF')
            filter_name = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',...
            cutf,'DesignMethod','window','Window',{@kaiser,3},'SampleRate',sampf);
        elseif strcmp(theFilter,'HPF')
            filter_name = designfilt('highpassfir','FilterOrder',20,'CutoffFrequency',...
            cutf,'DesignMethod','window','Window',{@kaiser,3},'SampleRate',sampf);
        elseif strcmp(theFilter,'BPF')
            filter_name = designfilt('bandpassfir','FilterOrder',20,'CutoffFrequency1',...
            cutf(1),'CutoffFrequency2',cutf(2), ...
            'DesignMethod','window','Window',{@kaiser,3},'SampleRate',sampf);
        elseif strcmp(theFilter,'BSF')
            filter_name = designfilt('bandstopfir','FilterOrder',20,'CutoffFrequency1',...
            cutf(1),'CutoffFrequency2',cutf(2), ...
            'DesignMethod','window','Window',{@kaiser,3},'SampleRate',sampf);
        else
            error('the specified filter is invalid. Exiting...')
        end
    case 'IIR'
        if  strcmp(theFilter,'LPF')
            filter_name = designfilt('lowpassiir','FilterOrder',iir_order,...
            'PassbandFrequency',cutf,'PassbandRipple',0.2,...
            'SampleRate',sampf);
        elseif strcmp(theFilter,'HPF')
            filter_name = designfilt('highpassiir','FilterOrder',iir_order,...
            'PassbandFrequency',35e3,'PassbandRipple',0.2,...
            'SampleRate',sampf);
        elseif strcmp(theFilter,'BPF')
            filter_name = designfilt('bandpassiir','FilterOrder',iir_order, ...
            'HalfPowerFrequency1',cutf(1),'HalfPowerFrequency2',cutf(2),...
            'SampleRate',sampf);
        elseif strcmp(theFilter,'BSF')
            filter_name = designfilt('bandstopiir','FilterOrder',iir_order, ...
            'HalfPowerFrequency1',cutf(1),'HalfPowerFrequency2',cutf(2),...
            'SampleRate',sampf);
        else
            error('the specified filter is invalid. Exiting...')
        end 
    otherwise 
        error('ya got lost somewhere along the highway, kid')
end
end
               
   
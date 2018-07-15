function [got_signal,IIR_FIR,design, ...
    get_filter,cutoff_frequency,the_order,the_ripple] = userinput()
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
prompt = ['\nWould you like to use a FIR or IIR filter? ' ...
    '\na kaiser window filter will be used if choosing FIR\n\n '];
IIR_FIR = input(prompt,'s');
if ~strcmp(IIR_FIR,'FIR') && ~strcmp(IIR_FIR,'IIR')
    error('Error: ya gotta specify FIR or IIR')
end
if strcmp(IIR_FIR,'IIR') 
    prompt = '\n\Which IIR filter design method?: ';
    design = input(prompt,'s');
else 
    design = [];
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
    the_ripple = input(prompt);
else 
    the_ripple = [];
end 

%save local variables for future use
save('LastSetup.mat','got_signal','IIR_FIR','get_filter', ...
    'cutoff_frequency','the_order','the_ripple')
end

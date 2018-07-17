function [got_signal,Filter,design_arguments] = userinput()
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
    load('LastSetup.mat','got_signal','Filter','design_arguments')
    return
end
got_signal = load([get_signal,'.txt']);

%prompt user to specify FIR or IIR Filter
prompt = '\nWould you like to use a FIR or IIR filter? ';
Filter.IIR_FIR = input(prompt,'s');

%prompt user to specify which design method
Filter.design_method = input_designMethod(Filter.IIR_FIR);

%prompt user for filter type
prompt = ['\nWhich filter response would you like to use?'...
    '(LPF,HPF,BPF,BSF): '];
Filter.response = input(prompt,'s');

design_arguments = design_argumentNames(Filter);

%prompt user for cutoff frequency/frequencies
if strcmp(Filter.response,'LPF') || strcmp(Filter.response,'HPF')
    prompt = '\nWhat is the cutoff frequency?: ';
    Filter.cutoff_frequency = input(prompt);
elseif strcmp(Filter.response,'BPF') || strcmp(Filter.response,'BSF')
    prompt = '\nWhat is the lower cutoff frequency?: ';
    Filter.cutoff_frequency(1) = input(prompt);
    prompt = '\nWhat is the upper cutoff frequency?: ';
    Filter.cutoff_frequency(2) = input(prompt);
else
    error('Error: not a valid filter frequency response')
end

%prompt user to specify order
prompt = '\nWhat is the order of the filter?: ';
Filter.the_order = input(prompt);

%prompt user to specify a ripple only if IIR
prompt = '\nWhat is the ripple of the filter?: ';
Filter.the_ripple = input(prompt);

%save local variables for future use
save('LastSetup.mat','got_signal','Filter','design_arguments')
end



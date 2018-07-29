% SAMPLING() is a function to calculate sampling parameters such as rate

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
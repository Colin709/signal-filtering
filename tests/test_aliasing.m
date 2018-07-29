%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST_ALIASING.M
%
% author: Colin King - July 28, 2018
%
% Tests specifically for aliasing.
% All filter related functions are excluded.
% The original signal is plotted, as well as additional downsampling figs.
% Downsample a signal with consecutive integers, and downsample a signal by 
%   a factor of two and continue to downsample the result by a factor of 
%   two. It also plots the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all

% Load Signal. The signal should be a text file with two columns
% The file should be located in the MATLAB working directory
% Column 1 is the sample (time, etc), Column 2 is the measurement (V, etc)
signal = load('Em25ms10kSs.txt');

% Sampling parameters of the signal
[Nsamples,samples,voltages,rate] = sampling(signal);

% plot the original signal
figure
grid on
plot (samples,voltages)
title('Original Signal Waveform')
xlabel('Time (seconds)'); ylabel('Voltage (mV)')
title('Voltage vs time')

% downsample the signal by powers of 2 and plot
DownSample_twos(signal);

% downsample the signal itteratively and plot
% less aliasing compared to the previous downsampling
DownSample_ones(signal);

function [num_samples,sample_array,voltage_array,sample_rate] ...
    = sampling(my_signal)
% SAMPLING(my_signal) is a function to calculate sampling parameters

%Number of Samples
[num_samples,~] = size(my_signal);

%arrays of samples and voltages
sample_array = my_signal(:,1);
voltage_array = my_signal(:,2)*1000;

%get sample rate (frequency)
max_sample = max(sample_array);
sample_rate = num_samples/max_sample;
end

function DownSample_twos(signal2sample)
% downsample by a factor of two, four times, ad subplot.
% performing downsampling on downsampled signals
    figure
for i = 1:4
    signal2sample = downsample(signal2sample,2);
    
    % get sample rate (frequency)
    dsTime = signal2sample(:,1);
    [Ntime,~] = size(dsTime);
    dsRate = Ntime/max(dsTime);
    
    % plot the downsampled signals in a 2x2 figure
    subplot(2,2,i)
    grid on
    plot(dsTime,signal2sample(:,2))
    title(['Downsampled Sample Rate = ',num2str(round(dsRate)),' hZ'])
    xlabel('Time (seconds)'); ylabel('Voltage (mV)')
    xlim([0,max(dsTime)])
end
end

function DownSample_ones(Signal2sample)
% downsampling by consecutive integers
% only the original signal is downsampled
    figure
for j = 1:4
    sampleThis = Signal2sample;
    sampleThis = downsample(sampleThis,j+1);
    
    % get sample rate (frequency)
    DsTime = sampleThis(:,1);
    [nTime,~] = size(DsTime);
    DsRate = (nTime/max(DsTime));
    
    % plot the downsampled signals in a 2x2 figure
    subplot(2,2,j)
    grid on
    plot(DsTime,sampleThis(:,2))
    title(['Downsampled Sample Rate = ',num2str(round(DsRate)),' hZ'])
    xlabel('Time (seconds)'); ylabel('Voltage (mV)')
    xlim([0,max(DsTime)])
end
end
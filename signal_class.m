%%%%%%%%%Signal Class%%%%%%%%%%%%%%%%%%%
% MATLAB Code for Signal Class
% DSP Assignment
% Memorial University of Newfoundland
% Colin King - 200842029 - cbk618
% July 13, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef signal_class
    % signal_class takes an input signal and performs the following:
    % -adjusted voltage and time scale for plotting
    % -calculates the sampling rate and nyquist frequency
    % -calculates the PSD using FFT
    
    properties
        time
        voltage
        Nrows
        Ncolumns
        sampling_f
        nyquist_f
        estimated_f
        sampled_f
        PSD
    end
    
    methods (Static)
        
        function obj = signal_class(given_signal)
            %SIGNAL_CLASS Construct an instance of this class
            
            % Access the time and voltage in columns 1 and 2
            time_ = given_signal(: , 1);
            voltage_ = given_signal(: , 2);
            
            % Retrieve number of rows and columns
            [obj.Nrows,obj.Ncolumns] = size(given_signal);
            
            % Adjust time to start at 0 and v to be in mV
            obj.time = time_ - time_(1);
            obj.voltage = voltage_*1000;
            
            % Get the sampling parameters of the signal
            [obj.sampling_f,obj.nyquist_f] = ...
                signal_class.sample_rate(obj.time,obj.Nrows);
            
            % Get the PSD of the signal
            [obj.PSD,obj.sampled_f,obj.estimated_f] = ...
                signal_class.spectral_analysis(obj.sampling_f,obj.voltage,obj.Nrows);
            
        end
        
        function [sample_frequency,nyquist_frequency] = ...
                sample_rate(sampleTime,sampleRows)
            %function to get sample rate (as frequency) and nyquist freq
            
            Nsamps = sampleRows;
            Tsamp = max(sampleTime)/Nsamps;
            sample_frequency = 1/Tsamp;
            nyquist_frequency = sample_frequency/2;
        end
        
        function [Pxx,f,signalf_estimate] = ...
                spectral_analysis(freq_samp,volts,num_rows)
            %function to calculate PSD using FFT
            
            % Choose FFT size and calculate spectrum
            Nfft = 2^(floor(log(num_rows)/log(2)));
            [Pxx,f] = pwelch(volts,gausswin(Nfft),Nfft/2,Nfft,freq_samp);
            
            % Get frequency estimate (spectral peak)
            [~,loc] = max(Pxx);
            signalf_estimate = f(loc);
        end
    end
end
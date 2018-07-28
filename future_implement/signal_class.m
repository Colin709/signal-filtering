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
    % -calculates the sampling rate
    % -calculates the PSD using FFT
    
    properties
        time
        voltage
        % startTime
        % endTime
        Nrows
        Ncolumns
        sampling_f
        % nyquist_f
        estimated_f
        sampled_f
        PSD
        downSamples
    end
    
    methods (Static)
        
        function obj = signal_class(given_signal)
            %SIGNAL_CLASS Construct an instance of this class
            
            % Access the time and voltage in columns 1 and 2
            obj.time = given_signal(: , 1);
            obj.voltage = given_signal(: , 2)*1000;
            
            % Retrieve number of rows and columns
            [obj.Nrows,obj.Ncolumns] = size(given_signal);
            
            % Adjust time to start at 0 and v to be in mV
            % commented section are optional adjustments
            %             cnt=1;
            %             while abs(obj.voltage(cnt)) < 10
            %                 cnt=cnt+1;
            %             end
            %             obj.startTime = obj.time(cnt);
            %             obj.endTime = obj.time(end);
            %             obj.time = time_ - time(1);
            
            % Get the sampling parameters of the signal
            [obj.sampling_f,obj.downSamples] = ...
                signal_class.sample_rate(obj.time,obj.Nrows);
            
            % Get the PSD of the signal
            [obj.PSD,obj.sampled_f,obj.estimated_f] = ...
                signal_class.spectral_analysis(obj.sampling_f,obj.voltage,obj.Nrows);
            
        end
        
        function [sample_frequency,dSample_factor] = ...
                sample_rate(sampleTime,sampleRows)
            %function to get sample rate (as frequency) 
            
            Nsamps = sampleRows;
            Tsamp = max(sampleTime)/Nsamps;
            sample_frequency = 1/Tsamp;
            
            %get three downsampling factors
            %dSample_factor=zeros();
            time2sample=sampleTime;
            dSample_factor{1,3} = zeros(1,3);
            i=1;
            for fact = 1:3
                dSample_factor{fact} = downsample(time2sample,2);
                time2sample = dSample_factor{fact};
                fact=fact+1;
            end
            
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
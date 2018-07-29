classdef Signal
    % SIGNAL creates a signal object with sampling and frequency attributes
    %   determined by the input signal
    
    properties
        samples
        Nsamples
        values
        FS
        FFT
        Welch
    end
    
    methods(Static)
        
        function obj = Signal(inputSignal)
            % Construct an instance of this class
            
            % get the sampling properties from the input signal
            [obj.Nsamples,~] = size(inputSignal);
            obj.samples = inputSignal(:,1);
            obj.values = inputSignal(:,2);
            obj.FS = obj.Nsamples/max(obj.samples);
            
            % call the class function 'frequency()' to get FFT and Welch's
            %   method for plotting frequency spectra
            [obj.Welch,obj.FFT] = ...
                Signal.frequency(obj.Nsamples,obj.values,obj.FS);
        end
        
        function [Welch,FFT] = frequency(N_samples,Values,sample_rate)
            % calculate the frequency properties and send to constructor
            
            % Parameters for Plotting FFT
            FFT.n = 2^nextpow2(N_samples);
            FFT.trans = fft(Values,FFT.n);
            FFT.f = sample_rate*(0:(FFT.n/2))/FFT.n;
            FFT.P = abs(FFT.trans/FFT.n);
            
            % Parameters for Plotting Pwelchs PSD
            Nfft = 2^(floor(log(N_samples)/log(2)));
            [Welch.PSD,Welch.f] = ...
                pwelch(Values,gausswin(Nfft),Nfft/2,Nfft,sample_rate);
            [~,loc] = max(Welch.PSD);
            Welch.f_est = Welch.f(loc);
        end
    end
end
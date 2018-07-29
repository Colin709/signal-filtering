classdef downSample
    % DOWNSAMPLE contains methods to downsample a signal with consecutive
    %   integers, or downsample a signal by a factor of two and continue to
    %   downsample the result by a factor of two. It also plots the results
    % Returns a cell array of downsampled signals
    % Takes a signal and number of iterations as arguments
    
    properties
        signal
        samples
        Nsamples
        values
        FS
    end
    
    methods(Static)
        
        function obj = downSample(inputSignal,Factor)
            % Construct instance of downSample class
            
            obj.signal = downsample(inputSignal,Factor);
            obj.samples = obj.signal(:,1);
            [obj.Nsamples,~] = size(obj.samples);
            obj.values = obj.signal(:,2);
            obj.FS = (obj.Nsamples/max(obj.samples));
        end
    end
end


classdef downSample
    % DOWNSAMPLE contains methods to downsample a signal with consecutive
    %   integers, or downsample a signal by a factor of two and continue to
    %   downsample the result by a factor of two. It also plots the results
    
    properties
    end
    
    methods (Static)

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
    end
end


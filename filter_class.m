%%%%%%%%%Signal Class%%%%%%%%%%%%%%%%%%%
% MATLAB Code for Signal Class
% DSP Assignment
% Memorial University of Newfoundland
% Colin King - 200842029 - cbk618
% July 13, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef filter_class
    %filter_class designes the filter based on user input
    
    properties
    end
    
    methods
        function obj = filter_class(inputArg1,inputArg2)
            %FILTER_CLASS Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end


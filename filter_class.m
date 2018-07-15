%%%%%%%%%Signal Class%%%%%%%%%%%%%%%%%%%
% MATLAB Code for Signal Class
% DSP Assignment
% Memorial University of Newfoundland
% Colin King - 200842029 - cbk618
% July 13, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef filter_class
    %filter_class designs the filter based on user input
    
    properties
        type
        response
        cutoff_f
        order
        ripple
        designed_filter
    end
    
    methods (Static)
        
        function obj = ...
                filter_class(fir_or_iir,filt_response,cutf,sampf,ord,rip)
            %FILTER_CLASS Construct an instance of this class
            
            obj.type = fir_or_iir;
            obj.response =  filt_response;
            obj.cutoff_f = cutf;
            obj.order = ord;
            obj.ripple = rip;
            
            %Design Filters
            switch fir_or_iir
                case 'FIR'
                    if  strcmp(filt_response,'LPF')
                        obj.designed_filter = designfilt('lowpassfir', ...
                            'FilterOrder',ord,'CutoffFrequency',cutf, ...
                            'DesignMethod','window', ...
                            'Window',{@kaiser,3},'SampleRate',sampf);
                    elseif strcmp(filt_response,'HPF')
                        obj.designed_filter = designfilt('highpassfir', ...
                            'FilterOrder',ord,'CutoffFrequency',cutf, ...
                            'DesignMethod','window', ...
                            'Window',{@kaiser,3},'SampleRate',sampf);
                    elseif strcmp(filt_response,'BPF')
                        obj.designed_filter = designfilt('bandpassfir', ...
                            'FilterOrder',ord,'CutoffFrequency1',cutf(1),...
                            'CutoffFrequency2',cutf(2), ...
                            'DesignMethod','window', ...
                            'Window',{@kaiser,3},'SampleRate',sampf);
                    elseif strcmp(filt_response,'BSF')
                        obj.designed_filter = designfilt('bandstopfir', ...
                            'FilterOrder',ord,'CutoffFrequency1',cutf(1),...
                            'CutoffFrequency2',cutf(2), ...
                            'DesignMethod','window', ...
                            'Window',{@kaiser,3},'SampleRate',sampf);
                    else
                        error('the specified filter is invalid. Exiting..')
                    end
                    
                case 'IIR'
                    if  strcmp(filt_response,'LPF')
                        obj.designed_filter = designfilt('lowpassiir', ...
                            'FilterOrder',ord,'PassbandFrequency',cutf, ...
                            'PassbandRipple',rip,'SampleRate',sampf);
                    elseif strcmp(filt_response,'HPF')
                        obj.designed_filter = designfilt('highpassiir', ...
                            'FilterOrder',ord,'PassbandFrequency',cutf, ...
                            'PassbandRipple',rip,'SampleRate',sampf);
                    elseif strcmp(filt_response,'BPF')
                        obj.designed_filter = designfilt('bandpassiir', ...
                            'FilterOrder',ord,'HalfPowerFrequency1',cutf(1),...
                            'HalfPowerFrequency2',cutf(2),'SampleRate',sampf);
                    elseif strcmp(filt_response,'BSF')
                        obj.designed_filter = designfilt('bandstopiir', ...
                            'FilterOrder',ord, 'HalfPowerFrequency1',cutf(1),...
                            'HalfPowerFrequency2',cutf(2),'SampleRate',sampf);
                    else
                        error('the specified filter is invalid. Exiting..')
                    end
                    
                otherwise
                    error('ya got lost somewhere along the highway, kid')
            end
        end
    end
end


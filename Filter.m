classdef Filter
    % FILTER creates four filters and contains the class function to plot
    %   the filter response and filtered signals
    
    properties
    end
    
    methods(Static)
        
        % design_filters() creates a structure that contains four minimum order
        %   FIR filters based on the sampling rate of the original signal
        % frequency band values are hard coded and tuned values depend on the
        %   signal and application
        function [filt] = design_filters(samp_rate)
            
            % low-pass FIR min-order filter
            filt{1} = designfilt('lowpassfir', ...
                'PassbandFrequency',650,'StopbandFrequency',700,...
                'StopbandAttenuation',80,'PassbandRipple',1,...
                'DesignMethod','equiripple','SampleRate',samp_rate);
            
            % high-pass FIR min-order filter
            filt{2} = designfilt('highpassfir',...
                'PassbandFrequency',85,'StopbandFrequency',70,...
                'StopbandAttenuation',80,'PassbandRipple',1,...
                'DesignMethod','equiripple','SampleRate',samp_rate);
            
            % band-pass FIR min-order filter
            filt{3} = designfilt('bandpassfir', ...
                'StopbandFrequency1',70,'PassbandFrequency1',85,...
                'PassbandFrequency2',650,'StopbandFrequency2',700,...
                'StopbandAttenuation1',80,'PassbandRipple',1,...
                'StopbandAttenuation2',80,'DesignMethod','equiripple',...
                'SampleRate',samp_rate);
            
            % band-stop FIR min-order filter
            filt{4} = designfilt('bandstopfir', ...
                'StopbandFrequency1',250,'PassbandFrequency1',230,...
                'PassbandFrequency2',350,'StopbandFrequency2',330,...
                'StopbandAttenuation',80,'PassbandRipple1',1,...
                'PassbandRipple2',1,'DesignMethod','equiripple',...
                'SampleRate',samp_rate);
        end
        
        function [filtered_signal,filtered_signalAdj] = ...
                plot_filters(Nfilters,Filter,voltages,samples)
            
            [filtered_signal(1,1:Nfilters),samplesAdj(1,1:Nfilters),...
                voltagesAdj(1,1:Nfilters),...
                filtered_signalAdj(1,1:Nfilters)] = deal({[]});
            figure
            for k = 1:Nfilters
                % filter the original signal with each filter
                filtered_signal{k} = filter(Filter{k},voltages);
                delay = mean(grpdelay(Filter{k}));
                samplesAdj{k} = samples(1:end-delay);
                voltagesAdj{k} = voltages(1:end-delay);
                filtered_signalAdj{k} = filtered_signal{k};
                filtered_signalAdj{k}(1:delay) = [];
                
                % plot each filtered signal overlayed on the original 
                %   signal
                % NOTE THAT THIS IS ADJUSTED FOR PHASE DELAY.
                % DEPENDING ON SIGNAL, MAY THROW A WARNING
                subplot(2,2,k); plot(samplesAdj{k},voltagesAdj{k}); 
                hold on,plot(samplesAdj{k},filtered_signalAdj{k},'-r',...
                    'linewidth',1.5),hold off
                xlim([0,0.15])
                xlabel('Time (s)'); ylabel('Amplitude (mV)')
                legend('Original Signal','Filtered Data')
            end
            
            response(1,1:Nfilters) = {[]};
            for p = 1:Nfilters
                % Magnitude Frequency response of each filter in 4 figures
                response{p}=fvtool(Filter{p});
            end
            
        end
        
    end
end


classdef downSample
    % DOWNSAMPLE contains methods to downsample a signal with consecutive
    %   integers, or downsample a signal by a factor of two and continue to
    %   downsample the result by a factor of two. It also plots the results
    % Returns a cell array of downsampled signals
    % Takes a signal and number of iterations as arguments
    
    properties
    end
    
    methods (Static)
        
        function [ds_Signal] = DownSample_ones(Signal2sample,Cnt)
            % downsampling by consecutive integers
            % only the original signal is downsampled
            ds_Signal(1,1:Cnt) = {[]};
            figure
            for j = 1:Cnt
                sampleThis = Signal2sample;
                sampleThis = downsample(sampleThis,j+1);
                ds_Signal{j} = sampleThis;
                
                % get sample rate (frequency)
                DsTime = sampleThis(:,1);
                [nTime,~] = size(DsTime);
                DsRate = (nTime/max(DsTime));
                
                % plot the downsampled signals in a 2x2 figure
                subplot(2,2,j)
                grid on
                plot(DsTime,sampleThis(:,2))
                title(['Downsampled Sample Rate = ',...
                    num2str(round(DsRate)),' hZ'])
                xlabel('Time (seconds)'); ylabel('Voltage (mV)')
                xlim([0,max(DsTime)])
            end
        end
        
        function [ds_signal] = DownSample_twos(signal2sample,cnt)
            % downsample by a factor of two, four times
            % performing downsampling on downsampled signals
            ds_signal(1,1:cnt) = {[]};
            figure
            for i = 1:cnt
                signal2sample = downsample(signal2sample,2);
                ds_signal{i} = signal2sample;
                % get sample rate (frequency)
                dsTime = signal2sample(:,1);
                [Ntime,~] = size(dsTime);
                dsRate = Ntime/max(dsTime);
                
                % plot the downsampled signals in a 2x2 figure
                subplot(2,2,i)
                grid on
                plot(dsTime,signal2sample(:,2))
                title(['Downsampled Sample Rate = ',...
                    num2str(round(dsRate)),' hZ'])
                xlabel('Time (seconds)'); ylabel('Voltage (mV)')
                xlim([0,max(dsTime)])
            end
        end
        
    end
end


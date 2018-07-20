classdef input_class
    %INPUT_CLASS takes user input for signal and filter design
    
    properties
    end
    
    methods(Static)
        
        function [got_signal,Filter] = userinput()
            %function to take user input for signal file and filter type
            %consider breaking this into separate functions for input and load
            
            %prompt user to load a signal file (has to be in working directory)
            prompt = ['Which signal file would you like to load? \nOptions: ' ...
                '\n-press enter for previous config ' ...
                '\n-type "dir" to view available files ' ...
                '\nNOTES: ' ...
                '\n-signal files should be in MATLAB working path ' ...
                '\n-type the file name without the directory or .txt' ...
                '\n\nChoice (file name): '];
            get_signal = input(prompt,'s');
            if strcmp(get_signal,'dir')
                while 1
                    clc; dir **/*.txt
                    get_signal = input(prompt,'s');
                    if ~strcmp(get_signal,'dir')
                        break
                    end
                end
            end
            if strcmp(get_signal,'')
                load('LastSetup.mat','got_signal','Filter')
                return
            end
            got_signal = load([get_signal,'.txt']);
            
            %prompt user to specify fir or iir Filter
            prompt = ['\nWould you like to use a FIR or IIR filter?'...
                '\n\n1. Finite Impulse Response (FIR)'...
                '\n2. Infinite Impulse Response (IIR)'...
                '\n\nChoice (1/2): '];
            Filter.iir_fir = input(prompt);
            if Filter.iir_fir == 1
                Filter.iir_fir = 'fir';
            elseif Filter.iir_fir == 2
                Filter.iir_fir = 'iir';
            else
                error('not a valid choice. Choose fir or iir')
            end
            
            %prompt user for filter type
            prompt = ['\nWhich filter response would you like to use?'...
                '\n\n1. Low-Pass'...
                '\n2. High-Pass'...
                '\n3. Band-Pass'...
                '\n4. Band-Stop'...
                '\n\nChoice (1-4): '];
            Filter.response = input(prompt);
            if Filter.response == 1
                Filter.response = 'lowpass';
            elseif Filter.response == 2
                Filter.response = 'highpass';
            elseif   Filter.response == 3
                Filter.response = 'bandpass';
            elseif  Filter.response == 4
                Filter.response = 'bandstop';
            else
                error('not a valid frequency response')
            end
            
            %prompt user to specify which design method
            Filter.design_method = ...
                input_class.input_designMethod(Filter.iir_fir);
            
            Filter.irResponse = strcat(Filter.response,Filter.iir_fir);
            
            %prompt user if they would like to design for minimum order
            prompt = ['\nWould you like to design the filter for minimum order'...
                'or custom parameters?'...
                '\n\n1. Minimum Order '...
                '\n2. Custom Parameters'...
                '\n\nselection (1/2): '];
            Filter.design = input(prompt);
            if Filter.design == 1
                Filter.design = 'Minimum Order';
                Filter = input_class.MinOrderFilter_input(Filter);
                save('LastSetup.mat','got_signal','Filter')
                return
            elseif Filter.design == 2
                Filter.design = 'Custom Design';
                Filter = input_class.CustomFilter_input(Filter);
                save('LastSetup.mat','got_signal','Filter')
                return
            else
                error('invalid filter option. Choose 1 or 2.')
            end
        end
        
        
        function filter_designMethod = input_designMethod(user_method)
            %FILTER_DESIGNMETHOD - determines fir or iir design method
            
            if strcmp(user_method,'fir')
                prompt = ['\nWhich fir design method would you like to use?:' ...
                    '\n\n1. Equiripple (default for min order fir)'...
                    '\n2. Kaiser Window (kaiserwin)'...
                    '\n3. Window'...
                    '\n4. Constrained Least Squares (cls)'...
                    '\n5. Least Squares (ls)\n\n'...
                    '\n\nChoice (1-5): '];
                selection_fir = input(prompt);
                if selection_fir == 1
                    filter_designMethod = 'equiripple';
                elseif selection_fir == 2
                    filter_designMethod = 'kaiserwin';
                elseif selection_fir == 3
                    filter_designMethod = 'window';
                elseif selection_fir == 4
                    filter_designMethod = 'cls';
                elseif selection_fir == 5
                    filter_designMethod = 'ls';
                else
                    error('not a valid fir design')
                end
                
            elseif strcmp(user_method,'iir')
                prompt = ['\nWhich iir design method would you like to use?:' ...
                    '\n\n1. Butterworth (default for min order)'...
                    '\n2. Chebyshev Type 1'...
                    '\n3. Chebyshev Type 2'...
                    '\n4. Elliptical\n\n'];
                selection_iir = input(prompt);
                
                if selection_iir == 1
                    filter_designMethod = 'butter';
                elseif selection_iir == 2
                    filter_designMethod = 'cheby1';
                elseif selection_iir == 3
                    filter_designMethod = 'cheby2';
                elseif selection_iir == 4
                    filter_designMethod = 'ellip';
                else
                    error('not a valid fir design')
                end
                
            else
                error('not a valid design method')
            end
        end
        
        
        function [MinOrderFilter] = MinOrderFilter_input(filter_min)
            %MINORDERFILTER - get filter params for min order design
            
            MinOrderFilter = filter_min;
            
            prompt='\nWhat is the Passband Frequency?: ';
            MinOrderFilter.PassbandFrequency = input(prompt);
            
            prompt='\nWhat is the Stopband frequency?: ';
            MinOrderFilter.StopbandFrequency = input(prompt);
            
            prompt='\nWhat is the Stopband Attenuation? (default = 60): ';
            MinOrderFilter.StopbandAttenuation = input(prompt);
            
            prompt='\nWhat is the Passband Ripple? (default = 1): ';
            MinOrderFilter.PassbandRipple = input(prompt);
            
            if strcmp(MinOrderFilter.response,'bandpass') ...
                    || strcmp(MinOrderFilter.response,'bandstop')
                
                prompt = '\nWhat is the Passband Frequency 2?: ';
                MinOrderFilter.PassbandFrequency2 = input(prompt);
                
                prompt = '\nWhat is the Stopband Frequency 2?: ';
                MinOrderFilter.StopbandFrequency2 = input(prompt);
                
                if strcmp(MinOrderFilter.response,'bandpass')
                    prompt = ['\nWhat is the Stopband Attenuation 2?'...
                        '(default = 60): '];
                    MinOrderFilter.StopbandAttenuation2 = input(prompt);
                    
                elseif strcmp(MinOrderFilter.response,'bandstop')
                    prompt = ['\nWhat is the Passband Ripple 2?'...
                        '(default = 1): '];
                    MinOrderFilter.PassbandRipple2 = input(prompt);
                end
            end
        end
        
        
        function [CustomFilter] = CustomFilter_input(filter_cust)
            %CUSTOMFILER_INPUT - input if not min order
            
            %prompt user to specify order
            prompt = '\nWhat is the order of the filter?: ';
            CustomFilter.FilterOrder = input(prompt);
            
            switch filter_cust.iir_fir
                
                case strcmp(filter_cust.iir_fir,'iir')
                    
                    if strcmp(filter_cust.DesignMethod,'butter')
                        prompt = ...
                            '\nWhat is the Half Power Frequency?: ';
                        CustomFilter.HalfPowerFrequency = input(prompt);
                        
                        if strcmp(filter_cust.FrequencyResponse,'bandpass') || ...
                                strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Half Power Frequency 2?: ';
                            CustomFilter.HalfPowerFrequency2 = input(prompt);
                        end
                        
                    elseif strcmp(filter_cust.DesignMethod,'cheby1')
                        prompt = ...
                            '\nWhat is the Passband Frequency?: ';
                        CustomFilter.PassbandFrequency = input(prompt);
                        prompt = ...
                            '\nWhat is the Passband Ripple?: ';
                        CustomFilter.PassbandRipple = input(prompt);
                        
                        if strcmp(filter_cust.FrequencyResponse,'bandpass')...
                                || strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Passband Frequency 2?: ';
                            CustomFilter.PassbandFrequency2 = input(prompt);
                        end
                        
                    elseif strcmp(filter_cust.DesignMethod,'cheby2')
                        prompt = ...
                            '\nWhat is the Stopband Frequency?: ';
                        CustomFilter.StopbandFrequency = input(prompt);
                        prompt = ...
                            '\nWhat is the Stopband Attenuation?: ';
                        CustomFilter.StopbandAttenuation = input(prompt);
                        
                        if strcmp(filter_cust.FrequencyResponse,'bandpass') || ...
                                strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Stopband Frequency 2?: ';
                            CustomFilter.StopbandFrequency2 = input(prompt);
                        end
                        
                    elseif strcmp(filter_cust.DesignMethod,'ellip')
                        prompt = ...
                            '\nWhat is the Passband Frequency?: ';
                        CustomFilter.PassbandFrequency = input(prompt);
                        prompt = ...
                            '\nWhat is the Passband Ripple?: ';
                        CustomFilter.PassbandRipple = input(prompt);
                        prompt = ...
                            '\nWhat is the Stopband Attenuation?: ';
                        CustomFilter.StopbandAttenuation = input(prompt);
                        
                        if strcmp(filter_cust.FrequencyResponse,'bandpass') || ...
                                strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Passband Frequency 2?: ';
                            CustomFilter.PassbandFrequency2 = input(prompt);
                            
                            if strcmp(filter_cust.FrequencyResponse,'bandpass')
                                prompt = ...
                                    '\nWhat is the Stopband Attenuation 2?: ';
                                CustomFilter.StopbandAttenuation2 = input(prompt);
                            end
                        end
                    end
                    
                case strcmp(filter_cust.iir_fir,'iir')
                    
                    if strcmp(filter_cust.DesignMethod,'window')
                        prompt = ...
                            '\nWhat is the Cutoff Frequency?: ';
                        CustomFilter.CutoffFrequency = input(prompt);
                        
                        if strcmp(filter_cust.FrequencyResponse,'bandpass') || ...
                                strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Cutoff Frequency 2?: ';
                            CustomFilter.CutoffFrequency2 = input(prompt);
                        end
                        
                    elseif strcmp(filter_cust.DesignMethod,'cls')
                        prompt = ...
                            '\nWhat is the Cutoff Frequency?: ';
                        CustomFilter.CutoffFrequency = input(prompt);
                        prompt = ...
                            '\nWhat is the Passband Ripple?: ';
                        CustomFilter.PassbandRipple = input(prompt);
                        prompt = ...
                            '\nWhat is the Stopband Attenuation?: ';
                        CustomFilter.StopbandAttenuation = input(prompt);
                        
                        if strcmp(filter_cust.FrequencyResponse,'bandpass')...
                                || strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Cutoff Frequency 2?: ';
                            CustomFilter.CutoffFrequency2 = input(prompt);
                            if strcmp(filter_cust.FrequencyResponse,'bandpass')
                                prompt = ...
                                    '\nWhat is the Stopband Attenuation2?: ';
                                CustomFilter.StopbandAttenuation2 = input(prompt);
                            elseif strcmp(filter_cust.FrequencyResponse,'bandstop')
                                prompt = ...
                                    '\nWhat is the Passband Ripple2?: ';
                                CustomFilter.PassbandRipple2 = input(prompt);
                            end
                        end
                        
                    elseif strcmp(filter_cust.DesignMethod,'equiripple')
                        prompt = ...
                            '\nWhat is the Passband Frequency?: ';
                        CustomFilter.PassbandFrequency = input(prompt);
                        prompt = ...
                            '\nWhat is the Stopband Frequency?: ';
                        CustomFilter.StopbandFrequency = input(prompt);
                        
                        if strcmp(filter_cust.FrequencyResponse,'bandpass') || ...
                                strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Passband Frequency?: ';
                            CustomFilter.PassbandFrequency = input(prompt);
                            prompt = ...
                                '\nWhat is the Stopband Frequency 2?: ';
                            CustomFilter.StopbandFrequency2 = input(prompt);
                        end
                        
                    elseif strcmp(filter_cust.DesignMethod,'ls')
                        prompt = ...
                            '\nWhat is the Passband Frequency?: ';
                        CustomFilter.PassbandFrequency = input(prompt);
                        prompt = ...
                            '\nWhat is the Stopband Frequency?: ';
                        CustomFilter.StopbandFrequency = input(prompt);
                        if strcmp(filter_cust.FrequencyResponse,'bandpass') || ...
                                strcmp(filter_cust.FrequencyResponse,'bandstop')
                            prompt = ...
                                '\nWhat is the Passband Frequency?: ';
                            CustomFilter.PassbandFrequency = input(prompt);
                            prompt = ...
                                '\nWhat is the Stopband Frequency 2?: ';
                            CustomFilter.StopbandFrequency2 = input(prompt);
                        end
                    end
                otherwise
                    error('something went wrong with custom filter')
            end
        end
    end
end



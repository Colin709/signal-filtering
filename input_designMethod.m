function filter_designMethod = input_designMethod(user_method)
%FILTER_DESIGNMETHOD - determines FIR or IIR design method

if strcmp(user_method,'FIR')
    prompt = ['\nWhich FIR design method would you like to use?:' ...
        '\n\n1. Equiripple'...
        '\n2. Kaiser Window (kaiserwin)'...
        '\n3. Window'...
        '\n4. Constrained Least Squares (cls)'...
        '\n5. Least Squares (ls)\n\n'];
    selection_FIR = input(prompt);
    if selection_FIR == 1
        filter_designMethod = 'equiripple';
    elseif selection_FIR == 2
        filter_designMethod = 'kaiserwin';
    elseif selection_FIR == 3
        filter_designMethod = 'window';
    elseif selection_FIR == 4
        filter_designMethod = 'cls';
    elseif selection_FIR == 5
        filter_designMethod = 'ls';
    else
        error('not a valid FIR design')
    end
    
elseif strcmp(user_method,'IIR')
    prompt = ['\nWhich IIR design method would you like to use?:' ...
        '\n\n1. Butterworth'...
        '\n2. Chebyshev Type 1'...
        '\n3. Chebyshev Type 2'...
        '\n4. Elliptical\n\n'];
    selection_IIR = input(prompt);
    
    if selection_IIR == 1
        filter_designMethod = 'butter';
    elseif selection_IIR == 2
        filter_designMethod = 'cheby1';
    elseif selection_IIR == 3
        filter_designMethod = 'cheby2';
    elseif selection_IIR == 4
        filter_designMethod = 'ellip';
    else
        error('not a valid FIR design')
    end
    
else
    error('not a valid design method')
end
disp('oh fuck')
end


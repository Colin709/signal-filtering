function filter_argumentNames = design_argumentNames(filter_argument)

if strcmp(filter_argument.IIR_FIR,'IIR') && strcmp(filter_argument.response,'LPF')
    switch filter_argument.design_method
        case 'butter'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpiir = input(prompt);
            if argSelection_lpiir == 1
                filter_argumentNames = '';
            elseif argSelection_lpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby1'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpiir = input(prompt);
            if argSelection_lpiir == 1
                filter_argumentNames = '';
            elseif argSelection_lpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby2'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpiir = input(prompt);
            if argSelection_lpiir == 1
                filter_argumentNames = '';
            elseif argSelection_lpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ellip'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpiir = input(prompt);
            if argSelection_lpiir == 1
                filter_argumentNames = '';
            elseif argSelection_lpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
elseif strcmp(filter_argument.IIR_FIR,'IIR') && strcmp(filter_argument.response,'HPF')
    switch filter_argument.design_method
        case 'butter'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpiir = input(prompt);
            if argSelection_hpiir == 1
                filter_argumentNames = '';
            elseif argSelection_hpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby1'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpiir = input(prompt);
            if argSelection_hpiir == 1
                filter_argumentNames = '';
            elseif argSelection_hpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby2'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpiir = input(prompt);
            if argSelection_hpiir == 1
                filter_argumentNames = '';
            elseif argSelection_hpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ellip'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpiir = input(prompt);
            if argSelection_hpiir == 1
                filter_argumentNames = '';
            elseif argSelection_hpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
elseif strcmp(filter_argument.IIR_FIR,'IIR') && strcmp(filter_argument.response,'BPF')
    switch filter_argument.design_method
        case 'butter'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpiir = input(prompt);
            if argSelection_bpiir == 1
                filter_argumentNames = '';
            elseif argSelection_bpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby1'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpiir = input(prompt);
            if argSelection_bpiir == 1
                filter_argumentNames = '';
            elseif argSelection_bpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby2'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpiir = input(prompt);
            if argSelection_bpiir == 1
                filter_argumentNames = '';
            elseif argSelection_bpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ellip'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpiir = input(prompt);
            if argSelection_bpiir == 1
                filter_argumentNames = '';
            elseif argSelection_bpiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
elseif strcmp(filter_argument.IIR_FIR,'IIR') && strcmp(filter_argument.response,'BSF')
    switch filter_argument.design_method
        case 'butter'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsiir = input(prompt);
            if argSelection_bsiir == 1
                filter_argumentNames = '';
            elseif argSelection_bsiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby1'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsiir = input(prompt);
            if argSelection_bsiir == 1
                filter_argumentNames = '';
            elseif argSelection_bsiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cheby2'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsiir = input(prompt);
            if argSelection_bsiir == 1
                filter_argumentNames = '';
            elseif argSelection_bsiir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ellip'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsiir = input(prompt);
            if argSelection_bsiir == 1
                filter_argumentNames = '';
            elseif input(prompt) == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
end

if strcmp(filter_argument.IIR_FIR,'FIR') && strcmp(filter_argument.response,'LPF')
    switch filter_argument.design_method
        case 'equiripple'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpfir = input(prompt);
            if argSelection_lpfir == 1
                filter_argumentNames = '';
            elseif argSelection_lpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'kaiserwin'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpfir = input(prompt);
            if argSelection_lpfir == 1
                filter_argumentNames = '';
            elseif argSelection_lpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'window'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpfir = input(prompt);
            if argSelection_lpfir == 1
                filter_argumentNames = '';
            elseif argSelection_lpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpfir = input(prompt);
            if argSelection_lpfir == 1
                filter_argumentNames = '';
            elseif argSelection_lpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_lpfir = input(prompt);
            if argSelection_lpfir == 1
                filter_argumentNames = '';
            elseif argSelection_lpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
elseif strcmp(filter_argument.IIR_FIR,'FIR') && strcmp(filter_argument.response,'HPF')
    switch filter_argument.design_method
        case 'equiripple'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpfir = input(prompt);
            if argSelection_hpfir == 1
                filter_argumentNames = '';
            elseif argSelection_hpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'kaiserwin'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpfir = input(prompt);
            if argSelection_hpfir == 1
                filter_argumentNames = '';
            elseif argSelection_hpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'window'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpfir = input(prompt);
            if argSelection_hpfir == 1
                filter_argumentNames = '';
            elseif argSelection_hpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpfir = input(prompt);
            if argSelection_hpfir == 1
                filter_argumentNames = '';
            elseif argSelection_hpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_hpfir = input(prompt);
            if argSelection_hpfir == 1
                filter_argumentNames = '';
            elseif argSelection_hpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
elseif strcmp(filter_argument.IIR_FIR,'FIR') && strcmp(filter_argument.response,'BPF')
    switch filter_argument.design_method
        case 'equiripple'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpfir = input(prompt);
            if argSelection_bpfir == 1
                filter_argumentNames = '';
            elseif argSelection_bpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'kaiserwin'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpfir = input(prompt);
            if argSelection_bpfir == 1
                filter_argumentNames = '';
            elseif argSelection_bpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'window'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpfir = input(prompt);
            if argSelection_bpfir == 1
                filter_argumentNames = '';
            elseif argSelection_bpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bpfir = input(prompt);
            if argSelection_bpfir == 1
                filter_argumentNames = '';
            elseif argSelection_bpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
           argSelection_bpfir = input(prompt);
            if argSelection_bpfir == 1
                filter_argumentNames = '';
            elseif argSelection_bpfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
elseif strcmp(filter_argument.IIR_FIR,'FIR') && strcmp(filter_argument.response,'BSF')
    switch filter_argument.design_method
        case 'equiripple'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsfir = input(prompt);
            if argSelection_bsfir == 1
                filter_argumentNames = '';
            elseif aargSelection_bsfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'kaiserwin'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsfir = input(prompt);
            if argSelection_bsfir == 1
                filter_argumentNames = '';
            elseif argSelection_bsfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'window'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsfir = input(prompt);
            if argSelection_bsfir == 1
                filter_argumentNames = '';
            elseif argSelection_bsfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'cls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsfir = input(prompt);
            if argSelection_bsfir == 1
                filter_argumentNames = '';
            elseif argSelection_bsfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
        case 'ls'
            prompt = ['\nWhich design argument Name-Value pairs would you like to use?'...
                '\n1.'...
                '\n2.\n\n'];
            argSelection_bsfir = input(prompt);
            if argSelection_bsfir == 1
                filter_argumentNames = '';
            elseif argSelection_bsfir == 2
                filter_argumentNames = '';
            else
                error('not a valid option')
            end
    end
end
end


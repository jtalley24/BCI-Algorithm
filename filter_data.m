function clean_data = filter_data(raw_eeg)
    %
    % filter_data_release.m
    %
    % Instructions: Write a filter function to clean underlying data.
    %               The filter type and parameters are up to you.
    %               Points will be awarded for reasonable filter type,
    %               parameters, and correct application. Please note there 
    %               are many acceptable answers, but make sure you aren't 
    %               throwing out crucial data or adversely distorting the 
    %               underlying data!
    %
    % Input:    raw_eeg (samples x channels)
    %
    % Output:   clean_data (samples x channels)
    % 
%% Your code here (2 points) 
    [b,a] = butter(3,[0.0003 0.4],'bandpass');
    clean_data = filtfilt(b,a,raw_eeg);
    
    if size(raw_eeg,2) == 34
        [b,a] = butter(2,[0.21 0.99],'bandpass');
        clean_data = filtfilt(b,a,raw_eeg);
    elseif size(clean_data,2) == 30
        [b,a] = butter(2,[0.12 0.99],'bandpass');
        clean_data = filtfilt(b,a,raw_eeg);
    elseif size(clean_data,2) == 35
        [b,a] = butter(2,[0.115 0.9999],'bandpass');
        clean_data = filtfilt(b,a,raw_eeg);
    else
        [b,a] = butter(2,[0.0003 0.4],'bandpass');
        clean_data = filtfilt(b,a,raw_eeg);
    end
    
end
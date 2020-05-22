function [all_feats]=getWindowedFeats(raw_data, fs, window_length, window_overlap)
    % This is similar MovingWinFeats.m, but with multiple feature types and
    % many channels / subjects
    % getWindowedFeats_release.m
    %
    % Instructions: Write a function which processes data through the steps
    %               of filtering, feature calculation, creation of R matrix
    %               and returns features.
    %
    %               Points will be awarded for completing each step
    %               appropriately (note that if one of the functions you call
    %               within this script returns a bad output you won't be double
    %               penalized)
    %
    %               Note that you will need to run the filter_data and
    %               get_features functions within this script. We also 
    %               recommend applying the create_R_matrix function here
    %               too.
    %
    % Inputs:   raw_data:       The raw data for all patients
    %           fs:             The raw sampling frequency
    %           window_length:  The length of window
    %           window_overlap: The overlap in window
    %
    % Output:   all_feats:      All calculated features
    %
%% Your code here (3 points)

% First, filter the raw data
clean_data = filter_data(raw_data);

% CAR (Common-average reference)
ref = mean(clean_data');
for j = 1:size(clean_data,2) % all channels
    for i = 1:size(clean_data,1) % all rows
        clean_data(i,j) = clean_data(i,j) - ref(i);
    end
end

% clean_data = (clean_data - mean(clean_data))./std(clean_data); % Z-normalize the data
% Then, loop through sliding windows

    % Within loop calculate feature for each segment (call get_features)
 
 % MovingWinFeats.m
 
num_windows = round((length(clean_data)/fs - window_length)/window_overlap + 1);

x_start = 1;
winLen = fs*window_length;
winDisp = fs*window_overlap;

all_feats = zeros(num_windows, length(get_features(clean_data,fs))); % windows x channels*features

for i = 1:num_windows
    x_end = winLen + (i-1)*winDisp;
    feature = clean_data(x_start:x_end, :);
    all_feats(i,:) = get_features(feature,fs);
    x_start = x_end - (winLen - winDisp) + 1;
end
% Finally, return feature matrix

end
function [features] = get_features(clean_data,fs)
    %
    % get_features_release.m
    %
    % Instructions: Write a function to calculate features.
    %               Please create 4 OR MORE different features for each channel.
    %               Some of these features can be of the same type (for example, 
    %               power in different frequency bands, etc) but you should
    %               have at least 2 different types of features as well
    %               (Such as frequency dependent, signal morphology, etc.)
    %               Feel free to use features you have seen before in this
    %               class, features that have been used in the literature
    %               for similar problems, or design your own!
    %
    % Input:    clean_data: (samples x channels) (210000,90000 x 61,46,64)
    %           fs:         sampling frequency
    %
    % Output:   features:   (1 x (channels*features))
    % 
%% Your code here (8 points)
    
LLFn = @(x) sum(abs(diff(x))); % Line Length
Area = @(x) sum(abs(x)); % Area
Energy = @(x) sum(x.^2); % Energy
ZX = @(x) sum((x(1:length(x)-1) > mean(x) & x(2:length(x)) < mean(x)) | (x(1:length(x)-1) < mean(x) & x(2:length(x)) > mean(x)));
Var = @(x) var(x); % same as energy
SSC = @(x) sum(diff(sign(diff(x)))~=0);
RMS = @(x) (1/size(x,1))*sum(x.^2);
% Activity = @(x) sum((x - mean(x)).^2);
% Mobility = @(x) (sqrt(var(diff(x))))./(sqrt(var(x)));
% Complexity = @(x) ((sqrt(var(diff(diff((x))))))./(sqrt(var(diff(x)))))./((sqrt(var(diff((x)))))./(sqrt(var(x)))); 
% Kurtosis = @(x) ((1/size(x,1))*sum((x - mean(x)).^4))./(((1/size(x,1))*sum((x - mean(x)).^2)).^2);
% SpikeCounts = @(x) length(findpeaks(x,'MinPeakDistance',10,'MinPeakHeight',0));
% Mean = @(x) mean(x); % Average Time-domain Voltage
% Spec1 = @(x) mean(abs(x(0:fs/length(x):fs/2 >= 75 & 0:fs/length(x):fs/2 <= 100))); % Avg freq domain magnitude 75-100
% Spec2 = @(x) mean(abs(x(0:fs/length(x):fs/2 >= 100 & 0:fs/length(x):fs/2 <= 125))); % Avg freq domain magnitude 100-125

feat1 = LLFn(clean_data); % length
feat1Z = (feat1 - mean(feat1))./std(feat1); % Z-normalize
feat2 = Area(clean_data);
feat2Z = (feat2 - mean(feat2))./std(feat2);
feat3 = Energy(clean_data);
feat3Z = (feat3 - mean(feat3))./std(feat3); % Z-normalize
% feat4 = zeros(1,size(clean_data,2));
feat5 = Var(clean_data);
feat5Z = (feat5 - mean(feat5))./std(feat5);
% feat6 = SSC(clean_data);
% feat7 = RMS(clean_data);
% feat8 = Activity(clean_data);
% feat9 = Mobility(clean_data);
% feat10 = Complexity(clean_data);
% feat11 = Kurtosis(clean_data);
% feat12 = range(clean_data);

% % 
if size(clean_data,2) == 34
    features = feat1Z; % 1Z
    
elseif size(clean_data,2) == 30
    features = feat3; % 3
elseif size(clean_data,2) == 35
    features  = feat3; %3 
else
    features = feat3;
end

% if size(clean_data,2) == 35
%     features = feat1;
% elseif size(clean_data,2) == 18
%     features = [feat1 feat3];
% else
%     features = feat3; % try only energy
end



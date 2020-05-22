function [R]=create_R_matrix(features, N_wind)
    %
    % get_features_release.m
    %
    % Instructions: Write a function to calculate R matrix.             
    %
    % Input:    features:   (samples x (channels*features))
    %           N_wind:     Number of windows to use
    %
    % Output:   R:          (samples x (N_wind*channels*features))
    % 
%% Your code here (5 points)

R = zeros(size(features,1), N_wind*size(features,2) + 1);
R(:,1) = 1; % first column all 1's

% manually fix time window 1
R(1,2:end) = [features(1,:) features(2,:) features(3,:) features(4,:) features(5,:) features(6,:) features(7,:) features(8,:) features(9,:) features(1,:)];
    
% manually fix time window 2
R(2,2:end) = [features(2,:) features(3,:) features(4,:) features(5,:) features(6,:) features(7,:) features(8,:) features(9,:) features(1,:) features(2,:)];

% manually fix time window 3
R(3,2:end) = [features(3,:) features(4,:) features(5,:) features(6,:) features(7,:) features(8,:) features(9,:) features(1,:) features(2,:) features(3,:)];

% manually fix time window 4
R(4,2:end) = [features(4,:) features(5,:) features(6,:) features(7,:) features(8,:) features(9,:) features(1,:) features(2,:) features(3,:) features(4,:)];

% manually fix time window 5
R(5,2:end) = [features(5,:) features(6,:) features(7,:) features(8,:) features(9,:) features(1,:) features(2,:) features(3,:) features(4,:) features(5,:)];

% manually fix time window 6
R(6,2:end) = [features(6,:) features(7,:) features(8,:) features(9,:) features(1,:) features(2,:) features(3,:) features(4,:) features(5,:) features(6,:)];

% manually fix time window 7
R(7,2:end) = [features(7,:) features(8,:) features(9,:) features(1,:) features(2,:) features(3,:) features(4,:) features(5,:) features(6,:) features(7,:)];

% manually fix time window 8
R(8,2:end) = [features(8,:) features(9,:) features(1,:) features(2,:) features(3,:) features(4,:) features(5,:) features(6,:) features(7,:) features(8,:)];

% manually fix time window 9
R(9,2:end) = [features(9,:) features(1,:) features(2,:) features(3,:) features(4,:) features(5,:) features(6,:) features(7,:) features(8,:) features(9,:)];


for M = 10:size(features,1)
    R(M, 2:end) = [features(M-9,:) features(M-8,:) features(M-7,:) features(M-6,:) features(M-5,:) features(M-4,:) features(M-3,:) features(M-2,:) features(M-1,:) features(M,:)];
end
end
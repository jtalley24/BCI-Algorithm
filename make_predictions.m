function [predicted_dg] = make_predictions(test_ecog)

% INPUTS: test_ecog - 3 x 1 cell array containing ECoG for each subject, where test_ecog{i} 
% to the ECoG for subject i. Each cell element contains a N x M testing ECoG,
% where N is the number of samples and M is the number of EEG channels.

% OUTPUTS: predicted_dg - 3 x 1 cell array, where predicted_dg{i} contains the 
% data_glove prediction for subject i, which is an N x 5 matrix (for
% fingers 1:5)

% Run time: The script has to run less than 1 hour. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('Model.mat');
f1 = Model{1};
f2 = Model{2};
f3 = Model{3};

leader_ecog1 = test_ecog{1};
leader_ecog1(:,55) = []; % remove bad channel 55
leader_ecog1 = leader_ecog1(:,[1:5,10,15:28,34:47]);
leader_ecog2 = test_ecog{2};
leader_ecog2(:,[21,38]) = []; % remove bad channels 21 and 37
leader_ecog2 = leader_ecog2(:,[7:13,15:29,31,34:36,38,43,45:46]);
leader_ecog3 = test_ecog{3};
leader_ecog3 = leader_ecog3(:,[7:29,34:35,41,44,46,48:49,51,54:55,57,61]);

leader_ecog1(38:end,:) = leader_ecog1(1:end-37,:);
leader_ecog2(38:end,:) = leader_ecog2(1:end-37,:);
leader_ecog3(38:end,:) = leader_ecog3(1:end-37,:);

leader_ecog1 = leader_ecog1(1:13455,:);
leader_ecog2 = leader_ecog2(1:13455,:);
leader_ecog3 = leader_ecog3(1:13455,:);

Fs = 1000; % Hz
window_length = 0.100; % seconds
window_overlap = 0.050; % seconds

leader_windowed_feats1 = getWindowedFeats(leader_ecog1, Fs, window_length, window_overlap);
leader_windowed_feats2 = getWindowedFeats(leader_ecog2, Fs, window_length, window_overlap);
leader_windowed_feats3 = getWindowedFeats(leader_ecog3, Fs, window_length, window_overlap);

N_wind = 10;
R1_leader = create_R_matrix(leader_windowed_feats1, N_wind);
R2_leader = create_R_matrix(leader_windowed_feats2, N_wind);
R3_leader = create_R_matrix(leader_windowed_feats3, N_wind);

Y1_hat = R1_leader*f1;
Y1_hat(size(R1_leader,1)+1,:) = Y1_hat(size(R1_leader,1),:);

Y2_hat = R2_leader*f2;
Y2_hat(size(R2_leader,1)+1,:) = Y2_hat(size(R2_leader,1),:);

Y3_hat = R3_leader*f3;
Y3_hat(size(R3_leader,1)+1,:) = Y3_hat(size(R3_leader,1),:);

% Get Leaderboard predictions

zoInterp = @(x,numInterp) reshape(repmat(x,numInterp,1),1,length(x)*numInterp);
% Y1_hat_up = zeros(size(leader_ecog1,1),5);
% Y2_hat_up = zeros(size(leader_ecog2,1),5);
% Y3_hat_up = zeros(size(leader_ecog3,1),5);

for i = 1:5
    Y1_hat_up(:,i) = zoInterp(Y1_hat(:,i)', 50);
    Y2_hat_up(:,i) = zoInterp(Y2_hat(:,i)', 50);
    Y3_hat_up(:,i) = zoInterp(Y3_hat(:,i)', 50);
end

Y1_hat_up(end+1:end+5,:) = Y1_hat_up(end-4:end,:);
Y2_hat_up(end+1:end+5,:) = Y2_hat_up(end-4:end,:);
Y3_hat_up(end+1:end+5,:) = Y3_hat_up(end-4:end,:);

% create predicted_dg{} array
predicted_dg = cell(3,1);
predicted_dg{1} = Y1_hat_up;
predicted_dg{2} = Y2_hat_up;
predicted_dg{3} = Y3_hat_up;



end


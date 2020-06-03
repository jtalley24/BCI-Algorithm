# UPenn-Bioengineering-Brain-Computer-Interfaces-Algorithm
BE 521 Final Project Algorithm

Included in this GitHUb repository is the final algorithm and supporting functions for UPenn Engineering's BE 521 Spring 2020 Brain-Computer Interfaces competition, based on Miller & Schalk's 2008 "Prediction of Finger Flexion" competition. This model involved a combination of data pre-processing, refined feature selection, an optimized linear decoder model, and rigorous prediction correlation validation to achieve an over 50% accuracy in predicting finger flexion data from 64-channel ECoG data alone. Below are the included functions listed hierarchically, with brief descriptions of their roles in the algorithm. This project was a synthesis of techniques learned in class and reviewed from literature, and a more detailed description of the algorithm and factors that led to the production of each step of the pipeline are detailed further in the final report included in this repository.

make_predictions.m - final script run to generate finger flexion prediction data matrix from input ECoG data matrices for 3 subjects, with the output prediction array predicted_dg

filter_data.m - apply an optimized second ordr Butterworth filter to all channels for each of the 3 subjects

get_features.m - feature selection and extraction from filtered data, creation of initial feature matrix

getWindowedFeats.m - create windowed feature matrix by performing feature extraction on sliding windows of the entire data set for all 3 subjects

create_R_matrix.m - generate R matrix from windowed feature matrices, creating parameter for linear decoder model of size Samples x (1 + N_windows * Features * Channels)

Model.mat - consolidated optimized linear decoder prediction model including the f matrices for all 3 subjects derived from the training and leaderboard data

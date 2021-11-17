# mRMR_Spearman
Feature selection using the mRMR Spearman

This function is a simplified, computationally efficient, robust approach for feature selection using the minimum Redundancy Maximum Relevance (mRMR) principle. 
The original paper by Peng et al. (2005) used the mutual information criterion (its computation is extremely demanding if done via proper density estimation, 
and likely problematic if done via crude histograms as in the open source code provided by most packages) to select features. 
Instead, here I opt for the Spearman correlation coefficient criterion which allows for a fast and computationally inexpensive feature selection algorithm 
(hence I call this technique mRMR_Spearman). 
More details can be found in my simple methodological guide for data analysis book chapter: 
A. Tsanas, M.A. Little, P.E. McSharry: "A methodology for the analysis of medical data", 
Chapter 7 in Handbook of Systems and Complexity in Health, pp. 113-125, Eds. J.P. Sturmberg, and C.M. Martin, Springer, 2013

%
% General call: features = mRMR_Spearman(X, y)
%
%% Function to select the optimal features using the mRMR_Spearman approach
%
% Inputs:  X        -> N by M matrix, N = observations, M = features
%          y        -> N by 1 vector with the numerical/categorical outputs
%__________________________________________________________________________
% optional inputs:  
%          K        -> number of features to be selected (integer value)    [default K = M, or K = 50 if there are more than 50 features in the dataset]
% =========================================================================
% Output:  features -> The selected features in descending order of
%                      importance (ranked by column index)
% =========================================================================


% Copyright (c) Athanasios Tsanas, 2014
%
% ********************************************************************
% If you use this program please cite:
%
% A. Tsanas, M.A. Little, P.E. McSharry: "A methodology for the analysis of
% medical data", Chapter 7 in Handbook of Systems and Complexity in Health, 
% pp. 113-125, Eds. J.P. Sturmberg, and C.M. Martin, Springer, 2013
% ********************************************************************
%
% For any question, to report bugs, or just to say this was useful, email
% tsanasthanasis@gmail.com

function features = mRMR_Spearman(X, y, K)
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
%
% -----------------------------------------------------------------------
% Useful references:
% 
% [1] H. Peng, F. Long, and C. Ding: Feature selection based on mutual 
%     information: criteria of max-dependency, max-relevance, and 
%     min-redundancy,IEEE Transactions on Pattern Analysis and Machine 
%     Intelligence, Vol. 27, No. 8, pp.1226-1238, 2005
% 
% [2] A. Tsanas, M.A. Little, P.E. McSharry: "A methodology for the 
%     analysis of medical data", Chapter 7 in Handbook of Systems and 
%     Complexity in Health, pp. 113-125, Eds. J.P. Sturmberg, and C.M. 
%     Martin, Springer, 2013
%
% -----------------------------------------------------------------------
% Last modified on 15 February 2014
%
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

%% Set some initial variables and defaults

[N,M] = size(X);

if(N~=length(y))
    error('The number of samples (rows) in the design matrix X is not equal to the number of samples in the response y');
end

if nargin<3
    K = min(50,M); % default to compute feature ranking for ALL features (or up to 50 if there are more than 50 features in the dataset
end

%% Main computations

% obtain absolute value correlations
CI = abs(corr(X, y, 'type', 'Spearman'));

% rank the correlation coefficients in descending order
[sort_CI, idx_CI] = sort(CI,'descend');

% Start completing the features vector
features(1) = idx_CI(1); % by definition, the first selected feature is the feature with maximum association with the response
idx_pointer = idx_CI(2:K);

% Calculate self correlation
all_redundancy = corr(X, 'type', 'Spearman');

% Loop to select features and their order
for k=2:K
   countdown = length(idx_pointer);
   last_feature = length(features);
   
   % get internal loop
   for i=1:countdown
       % compute the empirical criterion
       CI_relevance(i) = CI(idx_pointer(i));
       % CI_array(idx_pointer(i),last_feature) = abs(corr(X(:,features(last_feature)), X(:,idx_pointer(i)), 'type', 'Spearman'));
       CI_array(idx_pointer(i), last_feature)  = abs(all_redundancy(features(last_feature), idx_pointer(i)));
       CI_redundancy(i) = mean(CI_array(idx_pointer(i), :)); 
   end
   % Find compromise between relevance and redundancy
   [mRMR_val, mRMR_idx] = max(CI_relevance(1:countdown) - CI_redundancy(1:countdown));
 
   % fill in the feature vector with the selected features in order
   features(k) = idx_pointer(mRMR_idx); 
   idx_pointer(mRMR_idx) = [];
end

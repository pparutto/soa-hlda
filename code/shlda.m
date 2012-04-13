function A = shlda(A, P, ALPHA, SIGMA_g, SIGMA, GAMMA, ITERS, INITERS)
%SHLDA Smoothed heteroscedastic linear discriminant analysis

%NewA = shlda(A, P, ALPHA, SIGMA_g, SIGMA, GAMMA, ITERS, INITTERS)
% performs an iterative optimization of SHLDA transformation matrix
% and returns its new estimate, NewA.
% A       - initial guess of transformation matrix
%           (e.g. eye(size(SIGMA_g)) or LDA transformation matrix)
% P       - number of useful (wanted) dimensions
% ALPHA   - smoothing factor (value between 0.0 and 1.0)
% SIGMA_g - global covariance matrix
% SIGMA   - cell array of class covariance matrices
% GAMMA   - vector of class occupancy counts (samples per class)
% ITERS   - number of optimization iterations
% INITERS - number of optimization inner loop iterations (default 10)

% For ALPHA equal to 1.0, resulting trasformation is identical to that
% obtained with function HLDA. For ALPHA equal to 0.0, resulting
% trasformation correspons to LDA solution. For values between 0.0 and
% 1.0, resulting trasformation can be seen as a compromise between LDA,
% which is making wrong assumption of equality of class covariance
% matrices, and HLDA, where required class covariance matrices may be
% poorly estimated if the amount of training data is limited.

% See also HLDA
%
%References
%
%[1] L. Burget, Combination of Speech Features Using Smoothed
%Heteroscedastic Linear Discriminant Analysis, In Proc. ICSLP,
%Jeju Island, Korea, October 2004, accepted.

if nargin < 8,
INITERS = 10; end
% Estimation of within-class covariance matrix
WC = zeros(size(SIGMA_g));
for i=1:length(GAMMA)
WC = WC + SIGMA{i} * GAMMA(i);
end
WC = WC / sum(GAMMA);
% Covariance matrices smoothing
for i=1:length(GAMMA)
SIGMA{i} = SIGMA{i} * ALPHA + WC * (1-ALPHA);
end
A = hlda(A, P, SIGMA_g, SIGMA, GAMMA, ITERS, INITERS);

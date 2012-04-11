function A = hlda(A, p, SIGMA_g, SIGMA, gamma, iters, initers, alpha)
%HLDA Heteroscedastic linear discriminant analysis
%   NewA = hlda(A, p, SIGMA_g, SIGMA, gamma, iters) performe
%   iterative optimization of HLDA transformation matrix and
%   return its new estimate NewA. Base vectors are stored row-wise
%   in matrices A and NewA. For dimensionality reduction, use only
%   first p rows of the final transformation. After each iteration,
%   value of HLDA objective function is printed. The increase of
%   this value is directly related to the increase of the likelihood
%   obtained by use of the "improved" transformation.
%
%   A        - initial guess of transform matrix
%              (e.g. eye(size(SIGMA_g)) or LDA trasformation matrix)
%   p        - number of useful (wanted) dimensions
%   SIGMA_g  - global covariance matrix
%   SIGMA    - cell array of class covarience matrices
%   gamma    - vector of class occupancy counts (samples per class)
%   iters    - number of optimization iterations
%
%   Optional arguments:
%   initers  -  number of optimization inner loop iterations
%   alpha    - momentum (value between 0 and 1, default is 1)
%
%     See also COV
%
%   References
%
%     N. Kumar, Investigation of Silicon-Auditory Models and
%     Generalization of Linear Discriminant Analysis for Improved
%     Speech Recognition, Ph.D. Thesis, John Hopkins University,
%     Baltimore, 1997
%
%     M.J.F. Gales, Semi-tied covariance matrices for hidden Markov
%     Models", IEEE Transaction Speech and Audio Processing, vol. 7,
%     pp. 272-281, 1999.

if nargin < 8
  alpha = 1;
end

if nargin < 7
  initers = 10;
end


M = length(SIGMA);    % number of classes
d = size(SIGMA_g, 1); % original feature space dimension
tau = sum(gamma);     % total nuber of samples
momentum=zeros(d, d);

if det(A) < 1,
  disp('Init guess matrix does not have positive determinant. Multiplying first row by -1');
  A(1,:) = A(1,:) * -1;
end

% Normalize initial transformation to have determinant equal to 1 to avoid numerical precision problems 
A = A / (det(A)^(1/d));

disp(' ')
disp('Iteration    Q_hlda(M,M'')')
disp('-------------------------')

for iter =1:iters,
  Q = tau * log(det(A')^2); - tau * d * (log(2*pi)+1);
  for i =1:d,
    if i <= p
      G = zeros(d, d);
      for m = 1:M,
        sigma_i = A(:,i)' * SIGMA{m} * A(:,i);
        G = G + gamma(m) / sigma_i * SIGMA{m};
        Q = Q - gamma(m) * log(sigma_i);
      end
    else
      sigma_i = A(:,i)' * SIGMA_g * A(:,i);
      G = tau / sigma_i * SIGMA_g;
      Q = Q - tau * log(sigma_i);
    end
    invG{i} = inv(G);
  end

  Q = Q / 2;
  disp(sprintf('%5d        %.6g', iter-1, Q));

  for initer =1:initers,
    startA = A;
    for i =1:d,
      C = (inv(A')*det(A'))';
      ci_invG = C(i,:) * invG{i};
      A(:,i) = (ci_invG * sqrt(tau / (ci_invG * C(i,:)')))';
    end
    momentum = (1-alpha) * momentum + alpha * (A - startA);
    A = startA + momentum;
  end
end

%Normalize final transformation to have determinant equal to 1 (volume preserving transformation)
A = A / (det(A)^(1/d));


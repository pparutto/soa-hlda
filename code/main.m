load data.mat
train = reshape(TRAIN, 60000,28*28);
clear TRAIN;
test = reshape(TEST, 10000, 28*28);
clear TEST;

covmat = cov (double (train));
%functpca (covmat, train)
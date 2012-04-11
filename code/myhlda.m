%script for launching the HLDA

%This is the p argument, hardcoded value, maybe change?
wanted_dim = 87;

%This is the SIGMA_g argument
%general_cov = cov(double(train));

%This is the SIGMA argument
% within_cov = cell(10,1);
% for i = 0:9
%     indx=find(LABEL_TRAIN == i);
%      within_cov{i+1,1} = cov(double(train(indx,:)));
% end

%This is the number of samples per class (gamma argument)
num_samples = [];
for i = 0:9
    indx=find(LABEL_TRAIN == i);
    [w h] = size(train(indx,:));
    num_samples(i+1) = w;
end

%This is the number of iterations asked
nb_iter = 10;
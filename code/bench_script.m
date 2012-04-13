%bench script

pca_tmp = pcacov(cov(double(train)));
pca_A = pca_tmp(:,1:250);

pca_train = double(train) * pca_A;
pca_test = double(test) * pca_A;
% 
%This is the p argument, hardcoded value, maybe change?
wanted_dim = 9;

%This is the SIGMA_g argument
general_cov = cov(double(pca_train));

%This is the SIGMA argument
within_cov = cell(10,1);
for i = 0:9
    indx=find(LABEL_TRAIN == i);
     within_cov{i+1,1} = cov(double(pca_train(indx,:)));
end

%This is the number of samples per class (gamma argument)
num_samples = [];
for i = 0:9
    indx=find(LABEL_TRAIN == i);
    [w h] = size(pca_train(indx,:));
    num_samples(i+1) = w;
end

%This is the number of iterations asked
nb_iter = 1;

tabplot = cell(20,1);
for nbdim = 1:20

    A = hlda (eye(size(general_cov)), nbdim, general_cov, within_cov, num_samples, nb_iter);

    for i = 0:9
        indx=find(LABEL_TRAIN == i);
        hlda_centres(i+1,:) = mean(pca_train(indx,:)) * A;
    end

    tabplot{nbdim,1} = test_classif(pca_test * A, LABEL_TEST, hlda_centres)
end
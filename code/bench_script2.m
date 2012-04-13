%Bench_script2, change the number of iterations done

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

tabplot_iter = cell(20,1);
for nbiter = 1:20

    A = hlda (eye(size(general_cov)), 9, general_cov, within_cov, num_samples, nbiter);

    for i = 0:9
        indx=find(LABEL_TRAIN == i);
        hlda_centres(i+1,:) = mean(pca_train(indx,:)) * A;
    end

    tabplot_iter{nbiter,1} = test_classif(pca_test * A, LABEL_TEST, hlda_centres)
end

% matmat2 =
% 
%     0.8566
%     0.7805
%     0.6782
%     0.6434
%     0.6679
%     0.6202
%     0.5670
%     0.5458
%     0.5345
%     0.5311
%     0.5299
%     0.5284
%     0.5263
%     0.5257
%     0.5247
%     0.5176
%     0.4993
%     0.4957
%     0.4961
%     0.4972
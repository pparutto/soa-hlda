function [ Res ] = pca( data, X )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    [P D] = eig (data);
    
    dd = diag(D);
    %plot(x, dd)
    
    dd = sort(dd,'descend');
    
    %sum(dd(1:385)) / sum(dd)
    n = 86;
    W = D(:,784 - n:784);
    
    Res = double(X) * W;
end
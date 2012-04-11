function [ Res ] = test_classif( data, label_data, centre )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [nbx dim] = size(data);
    nbcentre = size (centre, 1);
    dist = zeros(nbx, nbcentre);
    for i = 1:nbcentre
        x = double (data) - repmat(centre(i,:), nbx, 1);
        x = x.^2;
        dist(:,i) = sum(x, 2);
    end

    [X class] = min (dist,[],2);
    Res = sum(class == label_data + 1) / nbx;
end
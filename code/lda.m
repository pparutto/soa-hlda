%LDA implementation
function [ A ] = lda(data, label_data, nbclasses)
%Takes: data, the data to work on, label_data: the labelled data, nbclasses
%the number of classes
%Return A, the linear transformation

%Compute the mean for all classes
for i = 0:nbclasses
    indx=find(label_data == i);
    m(i+1,:)=mean(data(indx,:));
end

%the total mean of the dataset
mtotal = mean(data);

%Compute Swithin, the within-class scatter

%compute the variance for class i
Swithin = zeros(784,784);
% for i = 0:nbclasses
%     indx = find(label_data == i);
%     Si = zeros(784);
%     Si = (data(indx,:) - repmat(m(i+1,:), lenght(indx), 1))' * (data(indx,:) - repmat(m(i+1,:), lenght(indx), 1))'
%     for j = 0:size(indx)
%         Si = Si + ((data(j+1,:) - m(i+1,:))' * (data(j+1,:) - m(i+1,:)));
%     end
%     Swithin = Swithin + Si;
% end
for i = 0:nbclasses
    indx = find(label_data == i);
    Swithin = Swithin + cov(data(indx,:),1);
end

%Compute Sbetween, the between-class scatter

Sbetween = zeros(784,784);
for i = 0:nbclasses
   indx = find(label_data == i);
   Sbetween = Sbetween + size(indx,1) * (((m(i+1,:) - mtotal)' * (m(i+1,:) - mtotal)));
end

sol = pinv(Swithin) * Sbetween;
[A D] = eigs(sol, 9);
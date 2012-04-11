%LDA implementation
function [ A ] = lda(data, label_data, nbclasses)
%Takes: data, the data to work on, label_data: the labelled data, nbclasses
%the number of classes
%Return A, the linear transformation

%Compute the mean for all classes
for i = 0:nbclasses
    indx=find(label_data == i);
    m(i+1,:)=sum(data(indx,:))/length(indx);
end

%the total mean of the dataset
mtotal = mean(data);

%Compute Swithin, the within-class scatter

%compute the variance for class i
Swithin = zeros(784,784);
for i = 0:nbclasses
    indx = find(label_data == i);
    Si = zeros(784);
    for j = 0:size(indx)
        Si = Si + ((data(j+1,:) - m(i+1,:))' * (data(j+1,:) - m(i+1,:)));
    end
    Swithin = Swithin + Si;
end

%Compute Sbetween, the between-class scatter

Sbetween = zeros(1,784);
for i = 0:nbclasses
   indx = find(label_data == i);
   Sbetween = Sbetween + ((m(i+1,:) - mtotal)' * (m(i+1,:) - mtotal));
end

A = inv(Swithin) * Sbetween;

%size(sum((data(indx,:) - repmat(m(i+1,:),size(indx,1), 1)) * (data(indx,:) - repmat(m(i+1,:),size(indx,1), 1))',2))
%repmat(M, 60000, 1)
% for i = 0:nbclasses
%     indx=find(label_data == i);
%     m(i+1,:)=sum(data(indx,:))/length(indx);
% end
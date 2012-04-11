load data.mat
train = reshape(TRAIN,60000,28*28);
test = reshape(TEST, 10000, 28*28);
clear TEST
clear TRAIN

for i = 0:9
    indx=find(LABEL_TRAIN == i);
     centres(i+1,:)=sum(train(indx,:))/length(indx);
end

for i =1:10
    subplot(2,5,i)
    imagesc(reshape(centres(i,:),28,28))
    colormap gray
    axis off
end
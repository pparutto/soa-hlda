%classification for the LDA

%A = lda(double(train), LABEL_TRAIN, 9);

for i = 0:9
   indx=find(LABEL_TRAIN == i);
    centres(i+1,:) = mean(train(indx,:)) * A;
end

new_test = double(test) * A;

test_classif(new_test, LABEL_TEST, centres)
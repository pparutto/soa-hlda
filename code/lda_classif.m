%classification for the LDA

lda_A = lda(double(train), LABEL_TRAIN, 9);

for i = 0:9
   indx=find(LABEL_TRAIN == i);
    centres(i+1,:) = mean(train(indx,:)) * lda_A;
end

lda_test = double(test) * lda_A;

test_classif(lda_test, LABEL_TEST, centres)
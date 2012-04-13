%dump script

subplot(1,3,1)
xlabel('y[0]')
ylabel('y[1]')
dump_points(pca_test, LABEL_TEST)
title('pca')

subplot(1,3,2)
xlabel('y[0]')
ylabel('y[1]')
dump_points(lda_test, LABEL_TEST)
title('lda')

subplot(1,3,3)
xlabel('y[0]')
ylabel('y[1]')
dump_points(hlda_test, LABEL_TEST)
title('hlda')
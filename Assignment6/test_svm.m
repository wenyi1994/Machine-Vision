function [ error, confusionmatrix ] = test_svm( svm, patterns, labels )
%TEST_SVM calculate relative test error of a svm on a testset
%[ error confusionmatrix ] = test_svm( svm, patterns, labels )
%   where:
%     'error' refers to the relative classification error
%     'confusionmatrix' refers to the confusion matrix
%     'svm' contains the support vector machine
%     'patterns' (matrix) contains the test patterns, one pattern per row
%     'labels' (vector) contains the true labels of the patterns

confusionmatrix = zeros (2,2);

pred = (svmclassify(svm, patterns))';
error = sum(pred ~= labels) / length(labels);

confusionmatrix(1,1) = sum( pred == (labels == 1));
confusionmatrix(2,2) = sum(-pred == (labels == -1));
confusionmatrix(1,2) = sum( pred == (labels == -1));
confusionmatrix(2,1) = sum(-pred == (labels == 1));
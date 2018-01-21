function [ svm, cverror, confmat, cmin, sigmamin] = train_svm_cv (train, trainlabel, k, c_vals, sigma_vals)
% train SVM with k-fold-crossvalidation; test various values for sigma and
% C and choose the best one
% [ svm cverror confmat cmin sigmamin] = train_svm_cv (training-patterns, training-labels, k, cvals, sigmavals)
%      svm: best svm trained on all training data
%      cverror: validation error of best svm
%      confmat: confusion matrix of best svm
%      cmin, sigmamin: parameters C and sigma of best svm
%      training-patterns: set of training patterns (array), each row
%           represents one pattern, each column one feature
%      training-labels: labels of training patterns (vector), one entry for
%           each pattern
%      k: perform k-fold cross-validation
%      sigmavals: a list of sigma values which should be tested
%      cvals: a list of C-values which should be tested

parameterlist = [];
n = length( trainlabel);

for ci = 1:length(c_vals)
    for si = 1:length(sigma_vals)
        try
            c=c_vals(ci);
            sigma=sigma_vals(si);
            % check C-value c and sigma-value sigma in this iteration
            confusionmatrix = [ 0 0; 0 0];
            validerror = 0;
            for kk=1:k
                % execute the k iterations of k-fold cross validation
                validindeces = round((kk-1)*n/k+1):round(kk*n/k);  % use the data with these indeces for validation
                trainindeces = 1:n;
                trainindeces(validindeces)=[];  % use the data with the remaining indeces for training
                % train SVM on subset of trainingdata:
                svm = svmtrain (train(trainindeces,:), trainlabel(trainindeces), 'KERNEL_FUNCTION', 'rbf', 'RBF_SIGMA', sigma, 'BOXCONSTRAINT', c);
                % calculate validation error:
                [ err, cm ] = test_svm (svm, train(validindeces,:), trainlabel(validindeces));
                confusionmatrix = confusionmatrix + cm;
                validerror = validerror + length(validindeces)*err;
            end
            % store result for these parameters in parameterlist:
            parameterlist = [ parameterlist; c sigma validerror/length(train) confusionmatrix(1,1) confusionmatrix(1,2) confusionmatrix(2,1) confusionmatrix(2,2)];
        catch
            warning(['Ignore parameters due to numerical problems. c=' num2str(c) ', sigma=' num2str(sigma)])
        end
    end
end
% search best parameterset in parameterlist:
parameterlist=sortrows (parameterlist, 3);
% retrain SVM on all trainingdata for best parameters:
svm = svmtrain (train, trainlabel, 'KERNEL_FUNCTION', 'rbf', 'RBF_SIGMA', parameterlist(1,2), 'BOXCONSTRAINT', parameterlist(1,1));
cverror = parameterlist(1,3);
cmin = parameterlist(1,1);
sigmamin = parameterlist(1,2);
confmat = [ parameterlist(1,4) parameterlist(1,5); parameterlist(1,6) parameterlist(1,7)];

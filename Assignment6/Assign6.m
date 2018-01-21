clear all;
close all;
clc;

%  Practical Exercises: Support-Vector-Machines
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2018/01/20

%% load data and test
load('smileys_train.mat');
% ---------------------- test output ----------------------
% n = length(trainlabel);
% for i = 1:n
%     figure(1);
%     plot_smiley(train(i,:),[20,20],[20,20]);
%     title(['Image: ',num2str(i),' / ',num2str(n)]);
%     drawnow;
% end
% -------------------------- end --------------------------

%% SVM-train
% svm = svmtrain(train, trainlabel, 'KERNEL_FUNCTION', 'rbf', 'RBF_SIGMA', 2.0, 'BOXCONSTRAINT', 5.0);

%% 1. complete test_svm.m function
% ---------------------- test output ----------------------
% [error, con_m] = test_svm(svm, train, trainlabel);
% -------------------------- end --------------------------

%% 2. vary parameters and check the resulting validation error (using train_svm_cv.m)
% k = 5;
% c_vals = 7.6:0.1:7.8;
% sigma_vals = 19.7:0.1:19.9;
% [svm, cverror, confmat, cmin, sigmamin] = train_svm_cv (train, trainlabel, k, c_vals, sigma_vals);  % best c = 7.7, sigma = 19.8, error = 0.2475

%% 3. vary patterns

% ========================== resize the image ==========================

% train_resize = change_size(train, [11,20,3,18],[20,20]);
% ---------------------- test output ----------------------
% n = length(trainlabel);
% for i = 1:n
%     figure(1);
%     plot_smiley(train_resize(i,:),[16,10],[16,10]);
%     title(['Image: ',num2str(i),' / ',num2str(n)]);
%     drawnow;
% end
% -------------------------- end --------------------------

% k = 5;
% c_vals = 1.5:0.1:1.7;
% sigma_vals = 10:0.1:11;
% [svm, cverror, confmat, cmin, sigmamin] = train_svm_cv (train_resize, trainlabel, k, c_vals, sigma_vals);   % best c = 1.6, sigma = 10.6, error = 0.1875

% ================================ end ================================

% ========================== HOG features ==========================

% train_HOG = HOG_features(train, 4, 4, 8, [20,20]);
% ---------------------- test output ----------------------
% n = length(trainlabel);
% for i = 1:n
%     figure(1);
%     bar(train_HOG(i,:));
%     title(['Image: ',num2str(i),' / ',num2str(n)]);
%     drawnow;
% end
% -------------------------- end --------------------------

% k = 5;
% c_vals = 0.8:0.1:1.2;
% sigma_vals = 10:20;
% [svm, cverror, confmat, cmin, sigmamin] = train_svm_cv (train_HOG, trainlabel, k, c_vals, sigma_vals);   % best c = 1, sigma = 9, error = 0.08

% =============================== end ==============================

%% combine resize and HOG-features
train_resize = change_size(train, [11,20,3,18],[20,20]);
train_HOG_resize = HOG_features(train_resize, 4, 4, 8, [10,16]);

k = 5;
c_vals = 1.5:0.1:2.5;
sigma_vals = 7:0.2:9;
[svm, cverror, confmat, cmin, sigmamin] = train_svm_cv (train_HOG_resize, trainlabel, k, c_vals, sigma_vals);   % best c = 1.8, sigma = 7.8, error = 0.0750
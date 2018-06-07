close all;
clc;

%  Practical Exercises: Deep Learning
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2018/01/30

%% 1. familiar with AlexNet
net = alexnet;
classNames = net.Layers(end).ClassNames;
img1 = imread('mineral_water_bottle.jpg');
img2 = imread('panda.jpg');
img3 = imread('glasses_box.jpg');
img4 = imread('bottle_zhangzhilong.jpg');
img_cell = {img1,img2,img3,img4};
sz = net.Layers(1).InputSize;
figure(1);
for i = 1:length(img_cell)
    img = img_cell{i};
    imt = img(1:sz(1),1:sz(2),1:sz(3));
    label = classify(net,img);
    subplot(2,2,i);
    imshow(img); 
    text(10,20,char(label),'Color','white');
end

figure(2);
camera = webcam;

while true
    picture = snapshot(camera);
    picture = imresize(picture, [227,227]);
    label = classify(net, picture);
    image(picture);
    title(char(label));
    drawnow;
end

%% 2. tranfer net
% % import image data
% imds = imageDatastore('machine vision/Assignment7/Images_scaled','IncludeSubfolders',true,'LabelSource','foldernames');
% % Use 70% of the images for training and 30% for validation
% [train_ims, valid_ims] = splitEachLabel(imds,0.7,'randomized');
% % Extract all layers, except the last three
% layersTransfer = net.Layers(1:end-3);
% % Replace the last three layers with a fully connected layer, a softmax layer, and a classification output layer
% numClasses = numel(categories(train_ims.Labels))
% layers = [
%     layersTransfer
%     fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
%     softmaxLayer
%     classificationLayer];
% 
% % Train Network
% miniBatchSize = 100;
% numIterationsPerEpoch = floor(1/2*numel(train_ims.Labels)/miniBatchSize);
% % options
% options = trainingOptions('sgdm',...
%     'MiniBatchSize',miniBatchSize,...
%     'MaxEpochs',30,...
%     'InitialLearnRate',1e-3,...
%     'Verbose',true,...
%     'Plots','training-progress',...
%     'ValidationData',valid_ims,...
%     'ExecutionEnvironment','parallel',...
%     'ValidationFrequency',numIterationsPerEpoch);
% % train
% netTransfer = trainNetwork(train_ims,layers,options);
% 
% % Classify Validation Images
% predictedLabels = classify(netTransfer,valid_ims);
% % Display four sample validation images with their predicted labels
% idx = [1 5 10 15];
% figure(2);
% for i = 1:numel(idx)
%     subplot(2,2,i)
%     I = readimage(valid_ims,idx(i));
%     label = predictedLabels(idx(i));
%     imshow(I)
%     title(char(label))
% end
% % Calculate the classification accuracy on the validation set
% valLabels = valid_ims.Labels;
% accuracy = mean(predictedLabels == valLabels)
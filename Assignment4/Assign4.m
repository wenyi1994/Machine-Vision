clear all;
close all;
clc;

%% Assign4.m
%  Practical Exercises: Color and Segmentation
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/12/01

%% 0. Read picture
% I_0 = imread('flower.png');
% Irgb_0 = im2double(I_0);
% 
% Ihsv_0 = rgb2hsv(Irgb_0);
% Irgb_0 = hsv2rgb(Ihsv_0);
% 
% Ilab_0 = rgb2lab(Irgb_0);
% Irgb_0 = lab2rgb(Ilab_0);
% 
% %  test showing pic
% figure('name','flower.png - original','numbertitle','off');
% set(gcf,'position',[400,200,900,300]);
% subplot(1,3,1);
% imshow(Irgb_0);
% subplot(1,3,2);
% imshow(Ihsv_0);
% subplot(1,3,3);
% imshow(Ilab_0);

%% 1. stack.png read and transform it in HSV and LAB space
I_1 = imread('stack.png');
Irgb_1 = im2double(I_1);
Ihsv_1 = rgb2hsv(Irgb_1);
Ilab_1 = rgb2lab(Irgb_1);

figure('name','1. stack.png','numbertitle','off');
set(gcf,'position',[100,100,1000,700]);

subplot('position',[0.03,0.53,0.45,0.45]);
imshow(Irgb_1);
title('in RGB space');

subplot('position',[0.53,0.53,0.45,0.45]);
imshow(Ihsv_1);
title('in HSV space');

subplot('position',[0.03,0.03,0.45,0.45]);
imshow(Ilab_1);
title('in L*a*b space');

subplot('position',[0.53,0.03,0.45,0.45]);
imshow(Ilab_1(:,:,1),[]);
title('in L* space');

%% 2. using ccl.m to stack.png
theta_rgb = 11/255;
theta_lab = 11/255 * 100;
theta_lab_l = 7/255 * 100;
theta_lab_ab = 7/255 * 100;
minpixel_rgb = 200;
minpixel_lab = 200;
Ilab_ab(:,:,1) = Ilab_1(:,:,2);
Ilab_ab(:,:,2) = Ilab_1(:,:,3);

[label_rgb_ccl, hist_rgb_ccl] = ccl(Irgb_1, theta_rgb, minpixel_rgb);
[label_lab_ccl, hist_lab_ccl] = ccl(Ilab_1, theta_lab, minpixel_lab);
[label_lab_ccl_l, hist_lab_ccl_l] = ccl(Ilab_1(:,:,1),theta_lab_l,minpixel_lab);
[label_lab_ccl_ab, hist_lab_ccl_ab] = ccl(Ilab_ab,theta_lab_ab, minpixel_lab);

% % coloring with jet(n) colors
% Irgb_ccl = coloring(label_rgb_ccl,length(hist_rgb_ccl));
% Ilab_ccl = coloring(label_lab_ccl,length(hist_lab_ccl));
% Ilab_ccl_l = coloring(label_lab_ccl_l,length(hist_lab_ccl_l));
% Ilab_ccl_ab = coloring(label_lab_ccl_ab,length(hist_lab_ccl_ab));

% coloring with avrg. colors
Irgb_ccl = coloring(label_rgb_ccl,Irgb_1);
Ilab_ccl = coloring(label_lab_ccl,Irgb_1);
Ilab_ccl_l = coloring(label_lab_ccl_l,Irgb_1);
Ilab_ccl_ab = coloring(label_lab_ccl_ab,Irgb_1);

figure('name','2. CCL on stack.png','numbertitle','off');
set(gcf,'position',[200,100,1000,700]);

subplot('position',[0.03,0.53,0.45,0.45]);
imshow(Irgb_ccl);
str=['RGB with \theta = ',num2str(theta_rgb),' min. ',num2str(minpixel_rgb),' pixels: ',num2str(length(hist_rgb_ccl)),' Segmentations'];
title(str);

subplot('position',[0.53,0.53,0.45,0.45]);
imshow(Ilab_ccl);
str=['L*a*b* with \theta = ',num2str(theta_lab),' min. ',num2str(minpixel_lab),' pixels: ',num2str(length(hist_lab_ccl)),' Segmentations'];
title(str);

subplot('position',[0.03,0.03,0.45,0.45]);
imshow(Ilab_ccl_l);
str=['L* with \theta = ',num2str(theta_lab_l),' min. ',num2str(minpixel_lab),' pixels: ',num2str(length(hist_lab_ccl_l)),' Segmentations'];
title(str);

subplot('position',[0.53,0.03,0.45,0.45]);
imshow(Ilab_ccl_ab);
str=['a*b* with \theta = ',num2str(theta_lab_ab),' min. ',num2str(minpixel_lab),' pixels: ',num2str(length(hist_lab_ccl_ab)),' Segmentations'];
title(str);

%% 3. using k-means to stack.png
k = 4;
[label_rgb_km, proto_rgb_km] = color_kmeans(Irgb_1, k);
[label_lab_km, proto_lab_km] = color_kmeans(Ilab_1, k);
[label_lab_km_l, proto_lab_km_l] = color_kmeans(Ilab_1(:,:,1), k);
[label_lab_km_ab, proto_lab_km_ab] = color_kmeans(Ilab_ab, k);
Irgb_km = coloring(label_rgb_km,proto_rgb_km);
Ilab_km = coloring(label_lab_km,proto_lab_km);
Ilab_km_l = coloring(label_lab_km_l,proto_lab_km_l);
Ilab_km_ab = coloring(label_lab_km_ab,proto_lab_km_ab);

figure('name','3. K-means on stack.png','numbertitle','off');
set(gcf,'position',[300,100,1000,700]);

subplot('position',[0.03,0.53,0.45,0.45]);
imshow(Irgb_km);
str=['RGB with k = ',num2str(k),': ',num2str(length(proto_rgb_km)),' Segmentations'];
title(str);

subplot('position',[0.53,0.53,0.45,0.45]);
imshow(Ilab_km);
str=['L*a*b* with k = ',num2str(k),': ',num2str(length(proto_lab_km)),' Segmentations'];
title(str);

subplot('position',[0.03,0.03,0.45,0.45]);
imshow(Ilab_km_l);
str=['L* with k = ',num2str(k),': ',num2str(length(proto_lab_km_l)),' Segmentations'];
title(str);

subplot('position',[0.53,0.03,0.45,0.45]);
imshow(Ilab_km_ab);
str=['a*b* with k = ',num2str(k),': ',num2str(length(proto_lab_km_ab)),' Segmentations'];
title(str);

%% 4. morphological operations on segments.png
I_4 = imread('segments.png');
Irgb_4 = im2double(I_4);

S1 = [1,1,1;1,1,1;1,1,1];
S2 = [0,1,0;1,1,1;0,1,0];
S3 = [1,1,1,1,1;1,0,0,0,1;1,0,0,0,1;1,0,0,0,1;1,1,1,1,1];
S4 = [1,0,0,0,1;0,1,0,1,0;0,0,1,0,0;0,1,0,1,0;1,0,0,0,1];

figure('name','4. Morphological operations on segments.png','numbertitle','off');
set(gcf,'position',[400,100,1000,700]);

I_4_mor = morphoim(Irgb_4,'erosion',S3,1,'dilation',S4,1,'erosion',S4,1,'dilation',S1,1);
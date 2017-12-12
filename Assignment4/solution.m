clc; clear;

%% Task 1

Irgb = im2double(imread('stack.png'));
Ihsv = rgb2hsv(Irgb);
Ilab = rgb2lab(Irgb);

figure(1);
H = subplot_tight(2,2,1);
imagesc(Ihsv(:,:,1));
colormap (H,hsv); title('hue'); axis image; axis off;
subplot_tight(2,2,2);
imagesc(Ihsv(:,:,2));
colormap(gray); title('saturation'); axis image; axis off;
subplot_tight(2,2,3);
imagesc(Ihsv(:,:,3));
colormap(gray); title('value'); axis image; axis off;
subplot_tight(2,2,4);
imagesc(Ilab(:,:,1));
colormap(gray); title('luminance'); axis image; axis off;

%% Task 2

figure (2);
[labels_rgb, rgbHist] = ccl(Irgb(:,:,:), 0.045, 100);
labels_lab = ccl(Ilab(:,:,:), 5.3, 100);
labels_ab = ccl(Ilab(:,:,2:3), 3, 100);
labels_l = ccl(Ilab(:,:,1), 1.5, 100);
labels_h = ccl(Ihsv(:,:,1), 0.006, 100);

colormap('default');
subplot_tight(2,2,1);
imagesc(labels_h);
title('H'); axis image; axis off;
subplot_tight(2,2,2);
imagesc(labels_lab);
title('L*a*b'); axis image; axis off;
subplot_tight(2,2,3);
imagesc(labels_ab);
title('a*b'); axis image; axis off;
subplot_tight(2,2,4);
imagesc(labels_l);
title('L'); axis image; axis off;

%%Task 3
figure(3);
labels_rgb = color_kmeans(Irgb, 4);
labels_lab = color_kmeans(Ilab, 4);
labels_ab = color_kmeans(Ilab(:,:,2:3), 4);
labels_l = color_kmeans(Ilab(:,:,1),4);

colormap('hsv');
subplot_tight(2,2,1);
imagesc(labels_rgb);
title('RGB'); axis image; axis off;
subplot_tight(2,2,2);
imagesc(labels_lab);
title('L*a*b'); axis image; axis off;
subplot_tight(2,2,3);
imagesc(labels_ab);
title('a*b'); axis image; axis off;
subplot_tight(2,2,4);
imagesc(labels_l);
title('L'); axis image; axis off;

%%Task 4
I = im2double(imread('segments.png'));
I = I==0;
figure(4);clf;
subplot_tight(1,2,1);
imagesc(I);

I1=I;

S = [1 1 1 1 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 1 1 1 1]

S1 = strel('square',4);
I1 = imdilate(I1,S1);
S2 = strel('disk',2);
I1 = imerode(I1,S2);

subplot_tight(1,2,2);
imagesc(I1);

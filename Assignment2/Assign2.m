clear all;
close all;
clc;

%% Calculate grey value gradient
im=imread('postit2g.png');
figure();
imshow(im,[]);
title('Original Image');

sobelfx=fspecial('sobel');
sobelfy=sobelfx';

imx=conv2(im,sobelfx);
imy=conv2(im,sobelfy);

grad_length=sqrt(imx.^2+imy.^2);
grad_angle=atan2(imx,-imy)./pi./2.*256.+256;
figure();
imshow(grad_length,[]);
title('Gradient Length');
figure();
imshow(grad_angle,[],'Colormap',hsv);
title('Gradient Angle');

%% Generate edge image
edge_canny=edge(im,'canny',[0.11,0.15],2);
edge_log=edge(im,'log',0.2,3);

figure();
pic=[edge_canny;edge_log];
imshow(pic,[]);
ylabel('with LoG-approach                    with Canny-approach');

%% Hough Transform
hs=robust_hough(edge_canny);
lines=robust_hough_lines(hs,11,edge_canny);
figure();
robust_hough_plot_lines(im,lines);
figure();
imagesc(hs.accumulator);
colormap('copper');
hold on;
plot(hs);

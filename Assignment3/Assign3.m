close all;
clear all;
clc;

%% Assign3.m
%  Practical Exercises: Line Estimation
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/11/16

%% Load Picture and dominant edges
img=imread('postit2g.png');
imgd=im2double(img);
% figure();                             % test picture
% imshow(imgd);

load 'pixellist_postit2g.mat';

%% Calculate theta and c of line x*cos(theta)+y*sin(theta)=c
theta=zeros(19,1);
c=zeros(19,1);
for i=1:19
    [theta(i),c(i)]=total_least_square(pixellist(i).list(:,1),pixellist(i).list(:,2));
end

%% Using RANSAC methode
theta2=zeros(19,1);
c2=zeros(19,1);
distance=5;
quality=0.95;
for i=1:19
    [theta2(i),c2(i)]=RANSAC_line(pixellist(i).list(:,1),pixellist(i).list(:,2),distance,quality);
end

%% Determine start and end point of Segment, remove 2 / 0 outmost points
start_p=zeros(2,19);
end_p=zeros(2,19);
start_p2=zeros(2,19);
end_p2=zeros(2,19);
for i=1:19
    [start_p(:,i),end_p(:,i)]=start_end_point(pixellist(i).list(:,1),pixellist(i).list(:,2),theta(i),c(i),2);
    [start_p2(:,i),end_p2(:,i)]=start_end_point(pixellist(i).list(:,1),pixellist(i).list(:,2),theta2(i),c2(i),0);
end

%% Show image and plot lines(segments)
figure();
imshow(imgd);
hold on;
for i=1:19
    plot([start_p(1,i) end_p(1,i)],[start_p(2,i) end_p(2,i)],'-', 'LineWidth', 3);
    plot(start_p(1,i),start_p(2,i),'g-o', end_p(1,i),end_p(2,i), 'r-o','LineWidth', 3);
end
hold off;
figure();
imshow(imgd);
hold on;
for i=1:19
    plot([start_p2(1,i) end_p2(1,i)],[start_p2(2,i) end_p2(2,i)],'-', 'LineWidth', 3);
    plot(start_p2(1,i),start_p2(2,i),'g-o', end_p2(1,i),end_p2(2,i), 'r-o','LineWidth', 3);
end
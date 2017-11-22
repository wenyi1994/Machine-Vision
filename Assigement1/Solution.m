format longG

(4*7-8)/(3^4-1)
exp(sin(3.2))
(5+log(37/(2.9*1.7)))/9

A=[3 5 1; 2 0 1; -1 1 0];
b=[-2 1 -4]';
c=inv(A)*b

-3:0.1:5
10.^[-3:5]

[1:100]*[100:-1:1]'

figure
x=-10:0.1:10;
plot (x,sinc(x),'r-')
hold on
plot (x,1/pi*x.^-1,'k:')
plot (x,-1/pi*x.^-1,'k:')
axis ([-10 10 -1.5 1.5])
plot (0,0,'b+')

euclidean_distance([1 1], [1 2])
euclidean_distance([1 1], [2 2])

figure
subplot(2,2,1);


kabel_salat = imread('kabel_salat.png');
imshow(kabel_salat,[])

size(kabel_salat)

max(max(kabel_salat))

min(min(kabel_salat))

sum(sum(kabel_salat))/(518*640)

f=fspecial('gaussian', 11, 4);
I=imfilter(double(kabel_salat), f);

subplot(2,2,2)
imshow(I,[])

J=deconvwnr(I,f,0.01);
subplot(2,2,3)
imshow(J,[])

II=fadeout(I,50);
J=deconvwnr(II,f,0.01);
subplot(2,2,4)
imshow(J,[])

function [s] = euclidean_distance (u,v)
%calculate the euclidean distance of two vectors
s = sqrt(sum((u-v).^2));
end
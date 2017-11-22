clear all;
close all;
clc;

%% Read and show Image
h=double(imread('kabel_salat.png'));
%imshow(h,[0,255]);

%% Find Size of Image
sizeim=size(h);

%% Max, Min and aver. gray vlaue of Image
maxgv=h(1,1);
mingv=h(1,1);
sumgv=0;
for i= 1:1:sizeim(1)
    for j= 1:1:sizeim(2)
        temp=h(i,j);
        if temp>maxgv
            maxgv=temp;
        end
        if temp<mingv
            mingv=temp;
        end
        sumgv=sumgv+temp;
    end
end
avegv=sumgv/(sizeim(1)*sizeim(2));

%%  Gaussian Filter
f=fspecial('gaussian',11,4);
gfim=imfilter(h,f);
%imshow(gfim,[0,255]);

%% Wiener deconvolution and Restore
orih=deconvwnr(gfim,f,0.1);
%imshow(orih,[0,255]);

%% Fade out
fogf=fadeout(gfim,50);
defo=deconvwnr(fogf,f,0.1);
pic=[h,gfim;orih,defo];
figure;
imshow(pic,[0,255]);

%% Vary PSF and NSR of Wiener deconvolution
fs1=fspecial('gaussian',11,1);
fs25=fspecial('gaussian',11,0.5);
gfim1=imfilter(h,fs1);
gfim25=imfilter(h,fs25);
orih11=deconvwnr(gfim1,fs1,0.1);
orih251=deconvwnr(gfim25,fs25,0.1);
orih01=deconvwnr(gfim,f,0.01);
orih101=deconvwnr(gfim1,fs1,0.01);
orih2501=deconvwnr(gfim25,fs25,0.01);
pic2=[gfim,gfim1,gfim25;orih,orih11,orih251;orih01,orih101,orih2501];
figure;
imshow(pic2,[0,255]);
title('sigma = 4                                                        sigma = 1                                                        sigma = 0.5');
ylabel('Deconv. NSR = 0.01                        Deconv.NSR = 0.1                        Gaussian Filter');
clc; clear;clf
%% Task 1
postit2g = imread('postit2g.png');
load('pixellist_postit2g.mat');
figure(1);
subplot(2,4,1);
imagesc(postit2g);
colormap(gray);

hold on;
for i=1:length(pixellist)
    S_ls = lslinefit (pixellist(i).list);
    plot(pixellist(i).list(:,1),pixellist(i).list(:,2),'gx');
    plot ([S_ls.point1(1) S_ls.point2(1)],[S_ls.point1(2) S_ls.point2(2)],'r-o','linewidth',2);
end
title('Least squares for all');
hold off;

%% Task 3
subplot(2,4,2);
points = [pixellist(1).list;pixellist(2).list];
imagesc(postit2g);hold on;
colormap(gray);
plot(points(:,1),points(:,2),'gx');
title('Line with outliers');
hold off;

%% LS
subplot(2,4,3);
S_ls = lslinefit (points);
imagesc(postit2g);hold on;
colormap(gray);
plot(points(:,1),points(:,2),'gx');
plot ([S_ls.point1(1) S_ls.point2(1)],[S_ls.point1(2) S_ls.point2(2)],'r-o','linewidth',2);
title('Least Squares');
hold off;

%% LTS
subplot(2,4,4);
S_lts = ltslinefit(points,0.8);
imagesc(postit2g);hold on;
colormap(gray);
plot(points(:,1),points(:,2),'gx');
plot ([S_lts.point1(1) S_lts.point2(1)],[S_lts.point1(2) S_lts.point2(2)],'r-o','linewidth',2);
title('Least Trimmed Squares');
hold off;

%% M-Estimator + Cauchy
subplot(2,4,5);
S_cauchy = mlinefit (points,'Cauchy',1);
imagesc(postit2g);hold on;
colormap(gray);
plot(points(:,1),points(:,2),'gx');
plot ([S_cauchy.point1(1) S_cauchy.point2(1)],[S_cauchy.point1(2) S_cauchy.point2(2)],'r-o','linewidth',2);
title('M-Estimator with Cauchy loss function');
hold off;

%% M-Estimator + Huber
subplot(2,4,6);
S_huber = mlinefit (points,'Huber',1);
imagesc(postit2g);hold on;
colormap(gray);
plot(points(:,1),points(:,2),'gx');
plot ([S_huber.point1(1) S_huber.point2(1)],[S_huber.point1(2) S_huber.point2(2)],'r-o','linewidth',2);
title('M-Estimator with Huber loss function');
hold off;

%% RANSAC
subplot(2,4,7);
S_rans = ransaclinefit(points,1);
imagesc(postit2g);hold on;
colormap(gray);
plot(points(:,1),points(:,2),'gx');
plot ([S_rans.point1(1) S_rans.point2(1)],[S_rans.point1(2) S_rans.point2(2)],'r-o','linewidth',2);
title('RANSAC');
hold off;

%% ALL
subplot(2,4,8);
imagesc(postit2g);hold on;
colormap(gray);
plot(points(:,1),points(:,2),'gx');
plot ([S_ls.point1(1) S_ls.point2(1)],[S_ls.point1(2) S_ls.point2(2)],'c-o','linewidth',2);
plot ([S_cauchy.point1(1) S_cauchy.point2(1)],[S_cauchy.point1(2) S_cauchy.point2(2)],'b-o','linewidth',2);
plot ([S_huber.point1(1) S_huber.point2(1)],[S_huber.point1(2) S_huber.point2(2)],'k-o','linewidth',2);
plot ([S_lts.point1(1) S_lts.point2(1)],[S_lts.point1(2) S_lts.point2(2)],'m-o','linewidth',2);
plot ([S_rans.point1(1) S_rans.point2(1)],[S_rans.point1(2) S_rans.point2(2)],'r-o','linewidth',2);
legend('MeasuredPoints','LeastSquares','M-Estimator + Cauchy','M-Estimator + Huber','LeastTrimmedSquares','RANSAC')
hold off;
%}

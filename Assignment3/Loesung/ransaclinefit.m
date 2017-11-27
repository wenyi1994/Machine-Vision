function [ S ] = ransaclinefit( P, q )
% RANSACLINEFIT calculate RANSAC line estimation from a
% set of 2D-positions
% [ S ] = ransaclinefit( P, q )
% P: list of positions (one point per line)
% q: threshold (RANSAC sensitivity threshold)
% S: struct, that contains a description of the line segment
% S.norm: the normal vector
% S.theta: direction of the normal vector (angle in rad)
% S.offset: offset of the line, i.e.
% x*cos(theta)+y*sin(theta)+offset=0
% S.point1, S.point2: start- and endpoint
[N, d]=size(P);
S.theta=0; % an arbitrary line as baseline
S.offset=0;
S.norm=[1 0]';
inlier_index = (abs(P*S.norm)<q); % those points are inliers
error = N-sum(inlier_index);
for i=1:200 % repeat 200 trials
    perm = randperm (N);
    subset = P(perm(1:2),:); % randomly select two points
    S1 = lslinefit (subset); % fit a line to the selected two points
    inlier_index1 = (abs(P*S1.norm+S1.offset)<q);
    error1 = N-sum(inlier_index1); % error for all points
    if (error1 < error)
        error = error1;
        S = S1;
        inlier_index = inlier_index1;
    end
end
% end of least-sum-of-squares estimator
% from here on: calculate end points
% determine a point p on the line:
p=-S.offset*S.norm;
% determine a vector orthogonal to normal vector
r=[ S.norm(2); -S.norm(1) ];
% determine tau-values for all points:
tau=P(inlier_index,:)*r;
% determine minimal and maximal tau:
tmn=min(tau);
tmx=max(tau);
S.point1=p+tmn*r;
S.point2=p+tmx*r;

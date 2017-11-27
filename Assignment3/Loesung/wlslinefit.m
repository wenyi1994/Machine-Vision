function [ S ] = wlslinefit( P, w )
% WLSLINEFIT calculate weighted least-squares line estimation from a
% set of 2D-positions
% [ S ] = lslinefit( P, w )
% P: list of positions (one point per line)
% w: list of weights (one per point)
% S: struct, that contains a description of the line segment
% S.norm: the normal vector
% S.theta: direction of the normal vector (angle in rad)
% S.offset: offset of the line, i.e.
% x*cos(theta)+y*sin(theta)+offset=0
% S.point1, S.point2: start- and endpoint
% 1st step (see description):
W = sum(w);
sx = sum(w'.*P(:,1));
sy = sum(w'.*P(:,2));
sxx = sum(w'.*(P(:,1).^2));
syy = sum(w'.*(P(:,2).^2));
sxy = sum(w'.*(P(:,1).*P(:,2)));
% 2nd step:
M=[sxx-sx*sx/W sxy-sx*sy/W; sxy-sx*sy/W syy-sy*sy/W];
% 3rd step:
[V, D]=eig(M);
% 4th step:
if ( D(1,1)<D(2,2) )
S.norm = V(:,1);
else
S.norm = V(:,2);
end
S.theta=atan2(S.norm(2),S.norm(1));
S.offset=-sum(w'.*(P*S.norm))/W;

% end of least-sum-of-squares estimator
% from here on: calculate end points
% determine a point p on the line:
p=-S.offset*S.norm;
% determine a vector orthogonal to normal vector
r=[ S.norm(2); -S.norm(1) ];
% determine tau-values for all points:
tau=P*r;
% determine minimal and maximal tau:
tmn=min(tau);
tmx=max(tau);
S.point1=p+tmn*r;
S.point2=p+tmx*r;

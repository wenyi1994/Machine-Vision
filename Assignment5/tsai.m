function [ A, R, t ] = tsai( C )
%TSAI Tsai's camera calibration approach
%   [ A, R, t ] = tsai( C )
%   C: n x 5 matrix that contains in every line the coordinates of one
%   calibration marker in the form [xi eta zeta u v] where [xi eta zeta]
%   denotes the 3D position in the world coordinate system and [u v] the
%   position in the image
%   A: 3 x 3 matrix containing the intrinsic camera parameters
%   R, t: rotation matrix and translation vector of extrinsic paramaters
[n d]=size(C);
W=ones (n,4);
W(:,1:3)=C(:,1:3);
S=zeros(4,4);
Su=zeros(4,4);
Sv=zeros(4,4);
Suv=zeros(4,4);
for i=1:n
    S=S+W(i,:)'*W(i,:);
    Su=Su-C(i,4)*W(i,:)'*W(i,:);
    Sv=Sv-C(i,5)*W(i,:)'*W(i,:);
    Suv=Suv+(C(i,4)^2+C(i,5)^2)*W(i,:)'*W(i,:);
end
T=zeros(12,12);
T(1:4,1:4)=S;
T(5:8,5:8)=S;
T(9:12,1:4)=Su;
T(9:12,5:8)=Sv;
T(1:4,9:12)=Su;
T(5:8,9:12)=Sv;
T(9:12,9:12)=Suv;
[V D]=eig(T);
ei=1;
for i=1:12
    if (D(i,i)<D(ei,ei))
        ei=i;
    end
end
Mv = V(:,ei);
len = sqrt(Mv(9)*Mv(9)+Mv(10)*Mv(10)+Mv(11)*Mv(11));
Mv = Mv/len;
for usign = 1:2
    Mv = -Mv;
    M=zeros(3,4);
    M(1,1)=Mv(1);
    M(1,2)=Mv(2);
    M(1,3)=Mv(3);
    M(1,4)=Mv(4);
    M(2,1)=Mv(5);
    M(2,2)=Mv(6);
    M(2,3)=Mv(7);
    M(2,4)=Mv(8);
    M(3,1)=Mv(9);
    M(3,2)=Mv(10);
    M(3,3)=Mv(11);
    M(3,4)=Mv(12);
    R=zeros(3,3);
    t=zeros(3,1);
    R(3,:)=M(3,1:3);
    t(3)=M(3,4);
    v0=M(3,1:3)*M(2,1:3)';
    u0=M(3,1:3)*M(1,1:3)';
    betapp=sqrt(M(2,1:3)*M(2,1:3)'-v0*v0);
    t(2)=(M(2,4)-v0*t(3))/betapp;
    R(2,:)=(M(2,1:3)-v0*R(3,:))/betapp;
    gammapp=(u0*v0-M(1,1:3)*M(2,1:3)')/betapp;
    alpha=sqrt(M(1,1:3)*M(1,1:3)'+gammapp*gammapp-u0*u0);
    R(1,:)=(M(1,1:3)+gammapp*R(2,:)-u0*R(3,:))/alpha;
    t(1)=(M(1,4)+gammapp*t(2)-u0*t(3))/alpha;
    theta=acos(gammapp/betapp);
    beta=betapp*sin(theta);
    A=zeros(3,3);
    A(1,1)=alpha;
    A(1,2)=gammapp;
    A(2,2)=betapp;
    A(1,3)=u0;
    A(2,3)=v0;
    A(3,3)=1;
    if (det(R)>0) 
        break;
    end
end

function [a,c] = total_least_square (x,y)
%% Total_Least_Square.m
%  calculate line parameters (a, c) from a list of pixel coordinates using
%  total least square methode, line: x*cos(a)+y*sin(a)=c
%  ----------------------------------------------------------------------
%  input:
%  x                    x-coordinate of points sequence
%  y                    y-coordinate of points sequence
%  output:
%  a                    parameter a of line x*cos(a)+ycos(a)=c
%  c                    parameter c of line x*cos(a)+ycos(a)=c
%  ----------------------------------------------------------------------
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/11/16
count=length(x);
county=length(y);
if count~=county
    disp('vector size must agree');
    return;
end
sumx=0;
sumy=0;
sumxx=0;
sumyy=0;
sumxy=0;
c=0;
for i=1:count
    sumx=sumx+x(i);
    sumy=sumy+y(i);
    sumxx=sumxx+x(i)*x(i);
    sumyy=sumyy+y(i)*y(i);
    sumxy=sumxy+x(i)*y(i);
end
alpha=sumxx-sumx^2/count;
beta =sumxy-sumx*sumy/count;
gamma=sumyy-sumy^2/count;
lag_matrix=[alpha,beta;beta,gamma];
[n, lamda]=eig(lag_matrix);
if lamda(1,1)>lamda(2,2)
    n_c=n(:,2);
else
    n_c=n(:,1);
end
for i=1:count
    c=c-dot(n_c,[x(i);y(i)]);
end
if n_c(1)>0 && n_c(2)<0
    c=-c;
end
c=c/count;
a=atan(n_c(2)/n_c(1));
% if a<0
%     a=a+pi;
% end
end
function [rmx,rmy] = remove_outmost (x,y,a,c,n)
%% Remove_Outmost.m
%  remove n points from x,y vector with outmost distance from line:
%  x*cos(a)+y*sin(a)=c.
%  ----------------------------------------------------------------------
%  input:
%  x                    x-coordinate of points sequence
%  y                    y-coordinate of points sequence
%  a                    parameter a of line x*cos(a)+ycos(a)=c
%  c                    parameter c of line x*cos(a)+ycos(a)=c
%  n                    number of removed outmost points 
%  output:
%  rmx                  new x-coordinate of points sequence
%  rmy                  new y-coordinate of points sequence
%  ----------------------------------------------------------------------
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/11/17

count=length(x);
county=length(y);
if count~=county
    disp('vector size must agree');
    return;
end
norm=[cos(a),sin(a)];
d_x_y=zeros(count,3);
for i=1:count
    d_x_y(i,:)=[abs(dot(norm,[x(i);y(i)])-c),x(i),y(i)];
end
sortrows(d_x_y);
rmx=zeros(count-n);
rmy=zeros(count-n);
for i=1:(count-n)
    rmx(i)=d_x_y(i,2);
    rmy(i)=d_x_y(i,3);
end
end
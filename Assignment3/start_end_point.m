function [start_p,end_p] = start_end_point (x,y,a,c,n)
%% Start_End_Point.m
%  calculate start and end point of a segment in the line:
%  x*cos(a)+ycos(a)=c.
%  ----------------------------------------------------------------------
%  input:
%  x                    x-coordinate of points sequence
%  y                    y-coordinate of points sequence
%  a                    parameter a of line x*cos(a)+ycos(a)=c
%  c                    parameter c of line x*cos(a)+ycos(a)=c
%  n                    number of removed outmost points 
%  output:
%  start_p              (x;y)vector of start point
%  end_p                (x;y)vector of end point
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
norm=[cos(a),sin(a)];

% remove outmost points
d_x_y=zeros(count,3);
for i=1:count
    d_x_y(i,:)=[abs(dot(norm,[x(i);y(i)])-c),x(i),y(i)];
end
sortrows(d_x_y);
rmx=zeros(count-n,1);
rmy=zeros(count-n,1);
for i=1:(count-n)
    rmx(i)=d_x_y(i,2);
    rmy(i)=d_x_y(i,3);
end

init_d=dot(norm,[rmx(1);rmy(1)])-c;
if a==0
    init_y=rmy(1)-init_d*sin(a);
    ymax=init_y;
    ymin=init_y;
    for i=1:(count-n)
        d=dot(norm,[rmx(i);rmy(i)])-c;
        ytemp=rmy(i)-d*sin(a);
        if ytemp>=ymax
            ymax=ytemp;
        end
        if ytemp<=ymin
            ymin=ytemp;
        end
    end
    xmax=(c-ymax*sin(a))/cos(a);
    xmin=(c-ymin*sin(a))/cos(a);
else
    init_x=rmx(1)-init_d*cos(a);
    xmax=init_x;
    xmin=init_x;
    for i=1:(count-n)
        d=dot(norm,[rmx(i);rmy(i)])-c;
        xtemp=rmx(i)-d*cos(a);
        if xtemp>=xmax
            xmax=xtemp;
        end
        if xtemp<=xmin
            xmin=xtemp;
        end
    end
    ymax=(c-xmax*cos(a))/sin(a);
    ymin=(c-xmin*cos(a))/sin(a);
end
start_p=[xmin;ymin];
end_p=[xmax;ymax];
end
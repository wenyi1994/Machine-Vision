function [a,c] = RANSAC_line(x,y,distance,quality)
%% RANSAC_line.m
%  calculate parameters a and c of line: x*cos(a)+ycos(a)=c, using RANSAC
%  estimating methode.
%  ----------------------------------------------------------------------
%  input:
%  x                    x-coordinate of points sequence
%  y                    y-coordinate of points sequence
%  distance             permitted distance from the line
%  quality              percentage of points should satisfy requirement
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

K=1000;                                          % iteration times
k=1;
pretotal=0;
d=zeros(count,1);
while pretotal<count*quality && k<K
    index_rand=floor(1+count*rand(2,1));    % pick randomly
    sampx=x(index_rand(1:2));
    sampy=y(index_rand(1:2));
    a_temp=atan((sampx(2)-sampx(1))/(sampy(1)-sampy(2)));
    c_temp=sampx(1)*cos(a_temp)+sampy(1)*sin(a_temp);
    norm=[cos(a_temp),sin(a_temp)];
    for i=1:count
        d(i)=abs(dot(norm,[x(i);y(i)])-c_temp);
    end
    sum_ok=sum(d<distance);
    if sum_ok>pretotal
        pretotal=sum_ok;
        a=a_temp;
        c=c_temp;
    end
    k=k+1;
end

end
function [ J ] = fadeout( I, b )
% J = FADEOUT (I, b)
% FADEOUT takes a grey value image I and makes it fade out
% on the boundaries using a trapezoid function. b is the
% maximal distance of pixels from the boundary which are changed
% FADEOUT returns an image J of the same size as I.
J=I;
[r,c]=size(I);
for i=1:b
    f=i/b;
    for j=1:c
        J(i,j)=f*I(i,j);
        J(r+1-i,j)=f*I(r+1-i,j);
    end
end
for j=1:b
    f=j/b;
    for i=j:r+1-j
        J(i,j)=f*I(i,j);
        J(i,c+1-j)=f*I(i,c+1-j);
    end
end

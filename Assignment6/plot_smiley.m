function [ ] = plot_smiley( I ,size1,size2)
%PLOT_SMILEY plot a 20x20 smiley image represented as 400-dimensional 
%row vector
imagesc(col2im(I',size1,size2, 'distinct')')
end

function [I_changed] = change_size(I, resize, ori_size)
%  change_size.m
%  resize an pattern-image by given size
%  ----------------------------------------------------------------------
%  input:
%  resize               a vector like [1 20 10 30], means using x-range
%                       1:20 and y-range 10:30 of original image
%  I                    original pattern-image
%  ori_size             a vector lake [width height]
%  ----------------------------------------------------------------------
%  output:
%  I_changed            re-sized pattern-image
%  ----------------------------------------------------------------------
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2018/01/20

I_changed = [];
n = size(I);
temp_c = zeros(resize(2)-resize(1)+1, resize(4)-resize(3)+1);
for i = 1:n(1)
    I_row = I(i,:);
    temp = reshape(I_row,ori_size(2),ori_size(1))';
    for j = resize(1):resize(2)
        for k = resize(3):resize(4)
            temp_c(j-resize(1)+1, k-resize(3)+1) = temp(j,k);
        end
    end
    I_changed = [I_changed; reshape(temp_c',numel(temp_c),1)'];
end
    
end
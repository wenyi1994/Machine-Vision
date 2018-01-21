function [I_changed] = HOG_features(I, m, n, x, ori_size)
%  HOG_features.m
%  resize an pattern-image by given size
%  ----------------------------------------------------------------------
%  input:
%  I                    original pattern-image
%  m                    devide width in m parts
%  n                    devide height in n parts
%  x                    devide 2*pi in x parts
%  ori_size             a vector lake [width height]
%  ----------------------------------------------------------------------
%  output:
%  I_changed            HOG-features applied pattern-image
%  ----------------------------------------------------------------------
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2018/01/20

sobelfx=fspecial('sobel');
sobelfy=sobelfx';
nn = size(I);
I_changed = [];

for i = 1:nn(1)
    I_row = I(i,:);
    temp = reshape(I_row,ori_size(2),ori_size(1))';
    imx=conv2(temp,sobelfx);
    imy=conv2(temp,sobelfy);
    grad_length=sqrt(imx.^2+imy.^2);
    grad_angle=atan2(imx,-imy);
    row_changed = [];

    for j = 1:m
        for k = 1:n
            % devide 2*pi in x parts
            vecx = zeros(1,x);
            temp_x = round((j-1)*ori_size(1)/m+1):round(j*ori_size(1)/m);
            temp_y = round((k-1)*ori_size(2)/n+1):round(k*ori_size(2)/n);
            grad_angle_range = ceil((grad_angle(temp_x,temp_y) + pi) ./ 2 ./ pi .* 8);
            grad_length_range = grad_length(temp_x,temp_y);
            for xx = 1:x
                vecx(xx) = sum(sum((grad_angle_range == xx) .* grad_length_range));
            end
            row_changed = [row_changed, vecx];
        end
    end

    I_changed = [I_changed; row_changed];
end
    
end
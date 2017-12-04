function color_seg = coloring(ori_seg,color)
%  coloring.m
%  fill a image with colors
%  ----------------------------------------------------------------------
%  input:
%  ori_seg              Original picture with entries from 0 to n
%  color                Number of colors that used to fill the image;
%                       If this parameter is color matrix, the image will
%                       be filled with given colors;
%                       'Color' can also be a image with same size of
%                       ori_seg, filling colors will picked up from average
%                       value of 'color'
%  output:
%  color_seg            colored picture
%  ----------------------------------------------------------------------
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/12/02
[m,n] = size(ori_seg);
[c_m,c_n] = size(color);
if c_m == 1 && c_n == 1
    colors = jet(color);
elseif c_n == 3
    colors = color;
elseif c_n == n * 3 && c_m == m
    colors = [0,0,0];
    index = max(max(ori_seg));
    for k = 1:index
        r = sum(sum((ori_seg(:,:) == k) .* color(:,:,1))) / sum(sum(ori_seg(:,:) == k));
        g = sum(sum((ori_seg(:,:) == k) .* color(:,:,2))) / sum(sum(ori_seg(:,:) == k));
        b = sum(sum((ori_seg(:,:) == k) .* color(:,:,3))) / sum(sum(ori_seg(:,:) == k));
        colors(k,:) = [r,g,b];
    end
else
    colors = jet(length(color));
end
total_color = size(colors);
for i = 1:m
    for j = 1:n
        if ori_seg(i,j)==0
            color_seg(i,j,1) = 0; color_seg(i,j,2) = 0; color_seg(i,j,3) = 0;
        else
            % temp = mod(ori_seg(i,j),total_color(1));
            % count = [temp ~= 0, temp == 0] * [temp; total_color(1)];
            count = mod(ori_seg(i,j),total_color(1)+1);
            color_seg(i,j,1) = colors(count,1);
            color_seg(i,j,2) = colors(count,2);
            color_seg(i,j,3) = colors(count,3);
        end
    end
end
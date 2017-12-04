function S = bimat2im(binary_mat, size_im)
%  bimat2im.m
%  generate a image with a binary matrix
%  ----------------------------------------------------------------------
%  input:
%  binary_mat           binary matrix with entries 0 and 1
%  size_im              size of generated image
%  output:
%  S                    generated image
%  ----------------------------------------------------------------------
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/12/02
[m,n] = size(binary_mat);
[m_im,n_im] = size(size_im);
if m_im == 1 && n_im == 1
    im_width = size_im;
    im_height = size_im;
else
    im_width = size_im(1);
    im_height = size_im(2);
end
trans_w = im_width/m;
trans_h = im_height/n;
for i = 1:im_width
    for j = 1:im_height
        S(i,j) = 1 - binary_mat(floor((i-1)./trans_w)+1,floor((j-1)./trans_h)+1);
    end
end
end
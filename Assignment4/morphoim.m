function MI = morphoim(I,varargin)
%  morphoim.m
%  morphological operations on image
%  M = morphoim(I, type, S, times, ...)
%  ----------------------------------------------------------------------
%  input:
%  I                    original image
%  type                 Type of morphological operations including 
%                       'erosion', 'dilation', 'closing' and 'opening.
%                       These operations can be superimposed.
%  S                    a binary matrix that specifies the neighbourhood of
%                       a pixel to use
%  times                operation times
%  output:
%  MI                   generated image
%  ----------------------------------------------------------------------
%  Wen Yi, Karlsruhe Institut of Technology
%  yi.wen@student.kit.edu
%  2017/12/02
I_temp = I;
if nargin-1 == 0
    MI = I;
    warning('no operations detected');
    return;
end
n_figure = (nargin-1) / 3;
sub1 = floor(sqrt(n_figure));
sub2 = floor(n_figure/sub1) + mod(n_figure,sub1);
for i = 1:3:(nargin-3)
    count = (i+2) / 3;
    if (strcmp(varargin{i},'erosion'))
        for j = 1:varargin{i+2}
            I_er = imerode(I_temp, varargin{i+1});
            I_temp = I_er;
        end
        str=['Erosion ',num2str(varargin{i+2}), ' times'];
    elseif (strcmp(varargin{i},'dilation'))
        for j = 1:varargin{i+2}
            I_di = imdilate(I_temp, varargin{i+1});
            I_temp = I_di;
        end
        str=['Dilation ',num2str(varargin{i+2}), ' times'];
    elseif (strcmp(varargin{i},'closing'))
        for j = 1:varargin{i+2}
            I_cl = imclose(I_temp, varargin{i+1});
            I_temp = I_cl;
        end
        str=['Closing ',num2str(varargin{i+2}), ' times'];
    elseif (strcmp(varargin{i},'opening'))
        for j = 1:varargin{i+2}
            I_op = imopen(I_temp, varargin{i+1});
            I_temp = I_op;
        end
        str=['Opening ',num2str(varargin{i+2}), ' times'];
    else
        warning(['unknown morphological operation', varargin{i}]);
        str=['unknown morphological operation'];
    end
    subplot(sub1, sub2, count);
    imshow(I_temp);
    title(str);
    
    Sim = bimat2im(varargin{i+1},75);
    pos1 = floor(count/(sub2+1))+1;
    pos2 = [mod(count,sub2) ~= 0, mod(count,sub2) == 0] * [mod(count,sub2); sub2];
    sub_11 = (pos2-1)/sub2 + 0.48 / sub2;
    sub_22 = (sub1-pos1)/sub1 + 0.02 / sub1;
    subplot('position',[sub_11, sub_22, 0.04, 0.04]);
    imshow(Sim);
    % title({'used';'binary';'Matrix'});
end
MI = I_temp;
end

function [ labels hist ] = ccl( I, theta, minpixel )
% CCL implements the connected components labeling algorithm
%   [labels hist] = CCL ( I, theta, minpixel )
%   I: the input image that sould be segmented. The image can be given as
%      greyvalue image or color image in any color space
%   theta: the threshold for the ccl algorithm, i.e. the maximal
%          distance in colorspace up to which neighboring pixels are put
%          into the same cluster
%   minpixel: the minimal number of pixels that a segment should have.
%             Smaller clusters are suppressed
%   labels: index image showing to which cluster a pixel belongs to. Index
%           0 means that a pixel belongs to a cluster which is smaller than
%           minpixel
%   hist: a statistics on the cluster sizes. length(hist) is the number of
%         clusters, hist(k) the size of the k-th cluster
[rows cols cdepth] = size (I);
Id = double(I);
Cleft = [ zeros(rows,1) sum((Id(:,2:cols,:)-Id(:,1:cols-1,:)).^2,3)<theta*theta ];
Cup = [ zeros(1,cols); sum((Id(2:rows,:,:)-Id(1:rows-1,:,:)).^2,3)<theta*theta ];

k = 1;
labels = uint32(zeros (rows, cols));
hist = [];
labelmap = [];
for v=1:rows
    for u=1:cols
        if (Cup(v,u))
            lup = labelmap(labels(v-1,u));
            if (Cleft(v,u))
                lleft = labelmap(labels(v,u-1));
                if (lup==lleft)
                    hist(lleft) = hist(lleft)+1;
                    labels(v,u) = lleft;
                else
                    % merger
                    lmin = min (lleft, lup);
                    lmax = max (lleft, lup);
                    hist (lmin) = hist(lmin)+hist(lmax)+1;
                    hist (lmax) = 0;
                    labelmap (labelmap==lmax) = lmin;
                    labels(v,u) = lmin;
                end
            else
                hist(lup) = hist(lup)+1;
                labels(v,u) = lup;
            end
        else
            if (Cleft(v,u))
                lleft = labelmap(labels(v,u-1));
                hist(lleft) = hist(lleft)+1;
                labels(v,u) = lleft;
            else
                k = k+1;
                hist(k) = 1;
                labels (v,u) = k;
                labelmap (k) = k;
            end
        end
    end
end

[ hist_sort permut ] = sort (hist, 'descend');
ipermut (permut) = 1:length(permut);
hist = hist_sort;
labels = ipermut(labelmap(labels));
hist (hist<minpixel) = [];
labels (labels>length(hist)) = 0;

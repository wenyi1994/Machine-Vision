function [ labels prototypes ] = color_kmeans ( I, k )
%COLOR_KMEANS segments an image using k-means clustering
%   [ labels prototypes ] = color_kmeans ( I, k )
%   with I          the input image
%        k          the number of clusters
%        labels     an array that assigns to each pixel the segment number
%        prototypes an array with k rows. The i-th row represents 
%                   the prototype color of the i-th segment

[rows cols cdepth] = size(I);
I1 = reshape (double(I), rows*cols, cdepth);

% repeat the clustering 3 times to avoid local minima
[cluster_idx prototypes] = kmeans(I1, k, 'distance','sqEuclidean', 'Replicates',3);
labels = reshape(cluster_idx, rows, cols);
end

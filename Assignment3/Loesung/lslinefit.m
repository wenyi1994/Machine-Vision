function [ S ] = lslinefit( P )
S = wlslinefit(P,ones([1,length(P)]));
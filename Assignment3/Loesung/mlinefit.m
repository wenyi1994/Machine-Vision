function [ S ] = mlinefit( P, type, parameter )
% MLINEFIT calculate M-estimator line estimation from a set of 2D-positions
% [ S ] = mlinefit( P, type, parameter )
% P: list of positions (one point per line)
% type: either 'Huber' or 'Cauchy' to specify the error term
% parameter: parameter of the error term (k or c)
% S: struct, that contains a description of the line segment
% S.norm: the normal vector
% S.theta: direction of the normal vector (angle in rad)
% S.offset: offset of the line, i.e.
% x*cos(theta)+y*sin(theta)+offset=0
% S.point1, S.point2: start- and endpoint
[N, d]=size(P);
weights = (1/N)*ones (1, N); % initialize weights equally
for i=1:5 % repeat 5 times
    S = wlslinefit (P, weights); % calculate weighted least squares fit
    d = (P*S.norm+S.offset)'; % calculate distances
    % recalculate weights:
    if (strcmp(type,'Huber'))
        absd = abs(d);
        weights = [absd<=parameter]+[absd>parameter]*parameter./absd;
    elseif (strcmp(type,'Cauchy'))
        weights = (d.^2/(parameter*parameter)+1).^-1;
    else
        warning (['unknown type of distance for m-estimator: ' type])
    end
end

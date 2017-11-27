function [ S ] = ltslinefit( P, q )
% LTSLINEFIT calculate LTS line estimation from a set of 2D-positions
% [ S ] = lslinefit( P, q )
% P: list of positions (one point per line)
% q: acceptance ratio (between 0 and 1)
% S: struct, that contains a description of the line segment
% S.norm: the normal vector
% S.theta: direction of the normal vector (angle in rad)
% S.offset: offset of the line, i.e.
% x*cos(theta)+y*sin(theta)+offset=0
% S.point1, S.point2: start- and endpoint
[N, d]=size(P);
qn = floor(N*q); % the number of points considered
S.theta=0; % an arbitrary line as baseline
S.offset=0;
S.norm=[1 0]';
error = sum(abs(P*S.norm));
for i=1:10 % repeat 10 trials
    perm = randperm (N);
    subset_index = perm(1:2); % randomly select two points
    perm_old = zeros (N,1);
    converged = false;
    while (~converged) % while not this trial converged...
        S1 = lslinefit (P(subset_index,:)); % fit line to selected points
        d = abs(P*S1.norm+S1.offset); % error for all points
        [ds, perm] = sort (d); % sort in order of ascending error
        if (perm(1:qn)==perm_old(1:qn)) % stop, if subset does not change
            converged = true;
        end
        subset_index = perm (1:qn); % qn best points for next iteration
        perm_old = perm;
    end
    error1 = sum(d(subset_index));
    if (error1 < error) % check if present trial is best
        error = error1;
        S = S1;
    end
end

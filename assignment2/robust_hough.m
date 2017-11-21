function [ hs ] = robust_hough( I )
%ROBUST_HOUGH calculates the Hough transform of an edge image
%   hs = ROBUST_HOUGH (I)
%   where I contains the edge image
%   and hs is a structure that contains the hough accumulator array
%   and the peaks in the accumulator array
ephi = 5;
eoff = 6;
threshold = 20;
[rows cols] = size(I);
acols = 180+2*ephi;
arows = ceil(sqrt(rows*rows+cols*cols))+eoff;
hs.accumulator = zeros (arows, acols);
hs.u0 = cols/2;
hs.v0 = rows/2;
hs.offset = floor(arows/2);
for v=1:rows
    for u=1:cols
        if (I(v,u))
            x = u-hs.u0;
            y = v-hs.v0;
            c1 = floor(x+0.5);
            for phi=1:acols
                c2 = floor(x*cos(phi*pi/180)+y*sin(phi*pi/180)+0.5);
                hs.accumulator (c2+hs.offset, phi) = hs.accumulator (c2+hs.offset, phi)+1;
                if (abs(c2-c1)>1)
                    c12 = floor((c1+c2)/2);
                    if (c2>c1)
                        increment = 1;
                    else
                        increment = -1;
                    end
                    if (phi>1)
                        for c=c1+increment:increment:c12
                            hs.accumulator (c+hs.offset, phi-1) = hs.accumulator (c+hs.offset, phi-1)+1;
                        end
                    end
                    for c=c12+increment:increment:c2-increment
                        hs.accumulator (c+hs.offset, phi) = hs.accumulator (c+hs.offset, phi)+1;
                    end
                end
                c1 = c2;
            end
        end
    end
end
hs.accumulator_peaks = zeros (size(hs.accumulator));
hs.peaks = [];
for v=eoff+1:arows-eoff
    for u=ephi+1:acols-ephi
        w = hs.accumulator (v,u);
        if (w>=threshold)
            if (sum(sum(w<hs.accumulator(v-eoff:v+eoff,u-ephi:u+ephi)))==0)
                hs.accumulator_peaks (v,u) = w;
                hs.peaks = [ hs.peaks; v u w ];
            end
        end
    end
end
hs.peaks = sortrows (hs.peaks, -3);

end

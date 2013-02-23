% Jens Raaby
% September 2012

function J = intensityRangeTransform(I, R1, R2)
%INTENSITYRANGETRANSFORM Transforms intensities of image I to range R1 to R2
%   Produces an image J by mapping linearly intensities from image I to
%   range [R1, R2]
    
%TODO fix this so it can take any numeric class and deal with it.
    I = cast(I,'int8');
    minI = min(min(I));
    maxI = max(max(I));
    rangeI = cast(maxI-minI,'double');
    
    
    rangeJ = cast(R2-R1,'double');
  
    scale = rangeJ/rangeI;

    
    J = (I - minI) * scale + R1;
    

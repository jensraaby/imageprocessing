% Jens Raaby
% September 2012
function image_ = gammaTransform( image, gamma )
%GAMMATRANSFORM Transforms IMAGE with a GAMMA value.

    image_ = im2double(image);
    image_ = image_ .^ gamma;
   

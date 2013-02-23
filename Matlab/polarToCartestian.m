% Jens Raaby
% February 2013

function [rectangular] = polarToCartestian(polarim, resolution)
%POLARTOCARTESIAN Converts a polar image (generally a square image with
%circular content) into a rectangular Cartesian plot.
%   POLARIM - the image which will be converted - the centre is the origin
%   for the transform
%   RESOLUTION - the number of horizontal pixels in the resulting image.


if (nargin<2)
    resolution = 360;
end

[M,N] = size(polarim);

midY = (M+1)/2;
midX = (N+1)/2;

% get all the radii (assuming the midpoint on the right is the starting point):
radii = linspace(0,midY,midY);

% get all the angles needed for this resolution:
theta = linspace(2*pi,0,resolution);

% get all the polar coordinates needed:
% NB swap here to get a 'vertical' orientation!
% [r,th] = meshgrid(radii,theta);
[th,r] = meshgrid(theta,radii);


% now interpolate the input image with these coordinates

% first get the cartesian coordinates:
[X,Y] = pol2cart(th,r);

% shift so the coordinates are not centred on the image
X_ = X + repmat(midY,size(X));
Y_ = Y + repmat(midY,size(X));

% interpolate image with the new coordinates:
rectangular = interp2(polarim,X_,Y_,'linear');
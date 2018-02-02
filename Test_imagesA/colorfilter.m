% ----------------------------------------------------------------------- %
%                        C O L O R    F I L T E R                         %
% ----------------------------------------------------------------------- %
% This function modifies a given image in order to keep a specific hue(??)%
% (given too) and to desaturate?????? the rest of the image. This procedure     %
% originates a image with black and white colormap, excluding the parts   %
% colored with that hue.                                                  %
%                                                                         %
%   Input parameters:                                                     %
%        image:   input image with double format (0 to 1 values).        %
%        range:   range of hues vector to maintain with the following    %
%                  format: [range_min, range_max], whose mins and max     %
%                  belongs to [0,360].                                   %
%         Note: Red hue appears in both ends of the hue spectrum (called H%
%         in HSV). If red hue is desired, it is necessary to indicate a   %
%         higher value in 'range_min' than 'range_max'. This way assumes  %
%         that the next value of 360 is 0, and so on.                   %
%           Example: range = [350, 50];                                   %
%                                                                         %
%   Output variables:                                                     %
%        I:       modified image.                                        %
% ----------------------------------------------------------------------- %
%   Author:  Vctor Martnez Cagigal                                      %
%   Date:    23/02/2015                                                   %
%   E-mail:  victorlawliet (dot) gmail (dot) com                          %
% ----------------------------------------------------------------------- %
function I = colorfilter(image, range)

    % RGB to HSV conversion
    I = rgb2hsv(image);         
    
    % Normalization range between 0 and 1
    range = range./360;
    
    % Mask creation
    if(size(range,1) > 1), error('Error. Range matriz has too many rows.'); end
    if(size(range,2) > 2), error('Error. Range matriz has too many columns.'); end

    if(range(1) > range(2))
        % Red hue case
        mask = (I(:,:,1)>range(1) & (I(:,:,1)<=1)) + (I(:,:,1)<range(2) & (I(:,:,1)>=0));
    else
        % Regular case
        mask = (I(:,:,1)>range(1)) & (I(:,:,1)<range(2));
    end
    
    % Saturation is modified according to the mask
    I(:,:,2) = mask .* I(:,:,2);
    
    % HSV to RGB conversion
    I = hsv2rgb(I);
    
end

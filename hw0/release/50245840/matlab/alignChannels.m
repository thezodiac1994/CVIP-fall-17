function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here

r = 100,c = 100, szr = 100, szc = 100; 
fix = red(r:r+szr,c:c+szc);
[gr,gc,br,bc] = deal(0,0,0,0);


tot = normxcorr2(fix,green);
[gr,gc]= find(tot==max(tot(:)));        
green_new = circshift(green,[r-gr+szr,c-gc+szc]);

tot = normxcorr2(fix,blue);
[br,bc]= find(tot==max(tot(:)));        
blue_new = circshift(blue,[r-br+szr,c-bc+szc]);
[rgbResult] = cat(3, red, green_new, blue_new);


end

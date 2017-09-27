function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here
%whos img
if (size(img,3)==1)
    img = repmat(img,[1 1 3]);
end
    

img = RGB2Lab(img); %conversion to CEILAB L*A*B
C = cell(size(filterBank));
P = cell(size(filterBank));

for i = 1:size(filterBank)
    imgnew = imfilter(img,filterBank{i,1}); % using i th filter on the image
    C{i} = imgnew;  %store filtered image response in C
    %pth = strcat (strcat ('../data/test/filter',num2str(i)),'.tif');
    %imwrite(imgnew, pth);      
    %P{i} = pth;
end

filterResponses = cat(3,C{:}); % concatenate all responses to create C as WxHxN*3 as expected

%montage(cat(4,C{:}),'Size',[4,5]); %using montage to display 4 x 5


end
% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
red = importdata('C:\Gautam\Masters\class notes\cse 573\hw0\release\data\red.mat');  % Red channel
green = importdata('C:\Gautam\Masters\class notes\cse 573\hw0\release\data\green.mat');  % Green channel
blue = importdata('C:\Gautam\Masters\class notes\cse 573\hw0\release\data\blue.mat');  % Blue channel


%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
[rgbResult] = alignChannels(red, green, blue); %solved by NCC
[rgb2] = sse(red,green,blue); %solved by SSD 

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
%A = image(rgbResult)
imwrite(rgbResult,'C:\Gautam\Masters\class notes\cse 573\hw0\release\50245840\results\rgb_output.jpg');
imwrite(rgb2,'C:\Gautam\Masters\class notes\cse 573\hw0\release\50245840\results\rgb_output2.jpg');
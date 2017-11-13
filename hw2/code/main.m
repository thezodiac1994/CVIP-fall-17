img = imread('../data/butterfly.jpg');
img = rgb2gray(img);
img = im2double(img);
%figure, imshow(img);

%initializations
n = 12; k = 1.5; threshold = 0.001; 
type = 1;  %set type = 1 for filter upsampling and 2 for image downsampling
solve(n,k,threshold,type,img);

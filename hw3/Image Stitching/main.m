img1 = im2double(rgb2gray(imread('..\data\part1\ledge\1.jpg')));
img2 = im2double(rgb2gray(imread('..\data\part1\ledge\2.jpg')));

%imshow (img1);
n = 15; k = 1.5; threshold = 0.042; first = 1;
type = 2;  %set type = 1 for filter upsampling and 2 for image downsampling
[cx1,cy1,r1] = solve(n,k,first,threshold,type,img1);
descriptors1 = find_sift(img1,[cy1 cx1 r1]);
%imagesc(descriptors1)
%descriptor 1




n = 15; k = 1.5; threshold = 0.025; first = 1;
[cx2,cy2,r2] = solve(n,k,first,threshold,type,img2);
descriptors2 = find_sift(img2,[cy2 cx2 r2]);
%descriptor 2


distances = dist2(descriptors1,descriptors2);       
pairs = 300;
sorted_distances = unique(distances(:));
distances_threshold = sorted_distances(pairs,1);
[xmatches,ymatches] = ind2sub(size(distances),find(distances < distances_threshold));
%xmatches -> cx1,cy1,r1
%ymatches -> cx2,cy2,r2

points1 = [cx1(xmatches(:)) , cy1(xmatches(:))];
points2 = [cx2(ymatches(:)) , cy2(ymatches(:))];
figure, show_all_circles(img1, points1(:,2), points1(:,1), 3, 'r', 1.5);
figure, show_all_circles(img2, points2(:,2), points2(:,1), 3, 'r', 1.5);



rand_cnt = 4;

%H = ransack(points1,points2,rand_cnt)
%H = [0.6971,    0.6036,    0.0017;-0.2916   -0.2526   -0.0007; -0.0201,    0.0218,   -0.0000]

[~,~,~,~,H] = estimateTransformRANSAC(points1,points2);


% rgb double

%{
iA = inv(H);
tform = projective2d(iA');
transformedImage = imwarp(img2,tform);
figure, imshow(transformedImage);
 %}  

trans = transformImage(img2,H);
figure , imshow (trans);


%{
Expanding the images
img1rgb = im2double(imread('..\data\part1\ledge\2.jpg'));
im1_size = size(img1rgb);
im2_transformed_size = size(new_img1);
padsize = im2_transformed_size-im1_size;
img1_expanded = padarray(img1rgb,padsize,'post');
figure
imshow(img1_expanded)
%}
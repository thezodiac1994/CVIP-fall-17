function [] = solve_by_ransack(I1,I2,correspondences,inlier_threshold)

I1 = I1(10 : size(I1,1) - 10, 10 : size(I2,2) - 10,:);
I2 = I2(10 : size(I2,1) - 10, 10 : size(I2,2) - 10,:);
img1 = im2double(rgb2gray(I1));
img2 = im2double(rgb2gray(I2));

% find descriptors:
n = 15; k = 1.5; first = 1;type = 2; 
[cim,cx1,cy1] = harris(img1,2,0.01,1,0);
descriptors1 = find_sift(img1,[cy1 cx1 ones(size(cx1,1))]);

[cim,cx2,cy2] = harris(img2,2,0.01,1,0);
descriptors2 = find_sift(img2,[cy2 cx2 ones(size(cx2,1))]);


distances = dist2(descriptors1,descriptors2);
sorted_distances = unique(distances(:)); % sort distances 
distances_threshold = sorted_distances(correspondences,1); % set threshold
[xmatches,ymatches] = ind2sub(size(distances),find(distances < distances_threshold));
%xmatches -> cx1,cy1,r1
%ymatches -> cx2,cy2,r2

points1 = [cy1(xmatches(:)) , cx1(xmatches(:))];
points2 = [cy2(ymatches(:)) , cx2(ymatches(:))];
%figure, show_all_circles(I1, points1(:,2), points1(:,1), 5, 'r', 1.5);
%figure, show_all_circles(I2, points2(:,2), points2(:,1), 5, 'r', 1.5);


matches = [points1 points2];
F = ransack2(points1,points2,8,I1,I2,inlier_threshold); % Main ransack function body
N = size(matches,1);
residual_error = Residual(F,N,matches,I1,I2,1,inlier_threshold);
end
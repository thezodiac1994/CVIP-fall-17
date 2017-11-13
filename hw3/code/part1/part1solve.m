function [final_img] = part1solve(rgbimg1,rgbimg2,threshold1,threshold2,correspondences)

img1 = im2double(rgb2gray(rgbimg1));
img2 = im2double(rgb2gray(rgbimg2));

n = 15; k = 1.5; first = 1;type = 2; 
[cx1,cy1,r1] = solve(n,k,first,threshold1,type,img1); %blobs
descriptors1 = find_sift(img1,[cy1 cx1 r1]);
%descriptor 1

[cx2,cy2,r2] = solve(n,k,first,threshold2,type,img2); %blobs
descriptors2 = find_sift(img2,[cy2 cx2 r2]);
%descriptor 2


distances = dist2(descriptors1,descriptors2);
sorted_distances = unique(distances(:));
distances_threshold = sorted_distances(correspondences,1);
[xmatches,ymatches] = ind2sub(size(distances),find(distances < distances_threshold));
%xmatches -> cx1,cy1,r1
%ymatches -> cx2,cy2,r2

points1 = [cx1(xmatches(:)) , cy1(xmatches(:))];
points2 = [cx2(ymatches(:)) , cy2(ymatches(:))];

n_points = 4;
[H,closest1,closest2,inliers] = ransack(points1,points2,n_points);
%figure, show_all_circles(img1, inliers(:,2), inliers(:,1), 5, 'y', 1.5);
%figure, show_all_circles(img2, inliers(:,4), inliers(:,3), 5, 'y', 1.5);
%uncomment the above comments to show inliers between the two images
    
%closest1
%closest2
tform1 = maketform('projective',[closest2(1:4,2) closest2(1:4,1)],[closest1(1:4,2) closest1(1:4,1)]);

merged_img = cell(1,3); % will hold rgb responses of stitched image 
for i = 1:3
    merged_img{i,1} = merge(rgbimg1(:,:,i),rgbimg2(:,:,i),tform1);
end

final_img = cat(3,merged_img{:,1}); % merged rgb image
end

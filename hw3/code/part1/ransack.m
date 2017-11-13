function [H,set1,set2,inlier_points] = ransack(points1,points2,cnt)
%Homography and RANSAC: https://www.youtube.com/watch?v=oT9c_LlFBqs
% for some random iterations

% returns H = homography matrix , set1 and set2 are the closest matches for
% maketform calculation and inlier points is the set of all inliers 

iter = 5000;
max_inliers = -1;
mean_residual = 0;
inlier_points = [];

for i = 1 : iter
    indices = randi (size(points1,1),[cnt 1],'uint8');	% generate random indices 
    H1 = homography([points1(indices(:),:)],[points2(indices(:),:)],cnt);  % get Homography mat
    mat = [points1(:,1)' ; points1(:,2)' ; ones(size(points1,1),1)']; % [ [x1 y1 1] [x2 y2 1] [x3 y3 1] ... [xn yn 1] ] 
    points1_trans = H1*mat; %transformed points1 
    points1_trans(:,:) = points1_trans(:,:)./points1_trans(3,:); % divide by 3rd value to get 1
    abserror = [abs(points1_trans(1,:) - points2(:,1)') ; abs(points1_trans(2,:) - points2(:,2)')];
    error = (abserror(1,:).*abserror(1,:) + abserror(2,:).*abserror(2,:)); % euclidean dist ^ 2
    threshold = 100;
    no_of_inliers = numel (find(error <= threshold));
    %closest_points = find()
    if(no_of_inliers > max_inliers)
        max_inliers = no_of_inliers;
        H = H1;
        inliers_residual_indices = find(error <= threshold);
        inlier_points = [points1(inliers_residual_indices',:) points2(inliers_residual_indices',:)];
        inlier_residual_error = error(inliers_residual_indices');
        mean_residual = sum(inlier_residual_error) / size(inlier_residual_error,2);
        [set1,~] = getbestinliers(points1,points2,error);
        set2 = H*[set1'; ones(1,size(set1,1))];
        set2(:,:) = set2(:,:) ./ set2(3,:);
        set2 = set2';
        set2 = set2(:,1:2);
    end
    
    
end

max_inliers
mean_residual
end
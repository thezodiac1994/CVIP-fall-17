function [F] = ransack2(points1,points2,cnt,I1,I2,inlier_threshold)

iter = 100000  ;
max_inliers = -1;

for i = 1 : iter
    indices = randi (size(points1,1),[cnt 1],'uint8');	% generate random indices 
    F1 = N_Fundamental(points1(indices(:),:) , points2(indices(:),:));  % get Fundamental mat
    matches = [points1 points2];
    N = size(matches,1);
    residual_error = Residual(F1,N,matches,I1,I2,0,inlier_threshold);
    inliers = numel(find (residual_error < inlier_threshold));
    
    if(max_inliers < inliers)
        max_inliers = inliers;
        F = F1;
    end

end
max_inliers
inliers_indices = find (residual_error < inlier_threshold); % find indices of inliers to get corresponding points
inliers_res_err = residual_error(inliers_indices(:)); % inliers total error
mean_inliers_res = sum(inliers_res_err) / size(inliers_res_err,1)

end
       
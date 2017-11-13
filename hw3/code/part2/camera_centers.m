function [centers] = camera_centers(A)
    %Returns homogenised camera centers 
    [U, S, V] = svd(A);
    centers = V(:,end);
    centers = homogenize(centers');
end

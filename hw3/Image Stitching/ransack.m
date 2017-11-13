function [H] = ransack(points1,points2,cnt)

% for some random iterations
iter = 1000000;
max_inliers = -1;

for i = 1 : iter
    indices = randi (size(points1,1),[cnt 1],'uint8');	
    H1 = homography([points1(indices(:),1) points1(indices(:),2)],[points2(indices(:),1) points2(indices(:),2)],cnt);
    mat = [points1(:,1)' ; points1(:,2)' ; ones(size(points1,1),1)'];
    % calc inlier outlier
    % mat is getting multiple same points maybe due to one point being
    % matched to more than one point in the other image 
    points1_trans = H1*mat;
    points1_trans(1,:) = points1_trans(1,:)./points1_trans(3,:);
    points1_trans(2,:) = points1_trans(2,:)./points1_trans(3,:);
    abserror = [abs(points1_trans(1,:) - points2(:,1)') ; abs(points1_trans(2,:) - points2(:,2)')];
    error = (abserror(1,:).*abserror(1,:) + abserror(2,:).*abserror(2,:)).^(0.5); % euclidean dist
    inliers = numel (find(error < 300)); %50 shouldnt be hardcoded
    if(inliers > max_inliers)
        max_inliers = inliers
        H = H1;
        inliers
    end
    
    
end


end
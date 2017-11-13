function [newpts, T] = normalize( pts )
% returns a transform for column vectors to normalize the points 

centroid = sum(pts(:,1:2)) / size(pts,1);
centered = pts(:,1:2) - repmat(centroid,size(pts,1),1);
meanSquaredDistance = sum((centered(:,1).^2 + centered( :,2).^2)) / size(pts,1);
scale = 2 / meanSquaredDistance;
T = diag([scale scale 1]) * [eye(3,2) [-centroid 1]'];
newpts = pts;
newpts(:,3) = 1;
newpts = newpts * T';
newpts = newpts ./ repmat( newpts(:,3), 1, 3);
newpts(:,3) = [];

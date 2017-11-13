function [set1,set2] = getbestinliers(points1,points2,error);
    % this function returns the 10 closest inliers which will help in
    % calculation of maketform
    sorted_error = sort(error);
    indices = find(error<=sorted_error(10));
    set1 = points1(indices(1:8),:);
    set2 = points2(indices(1:8),:); 
end
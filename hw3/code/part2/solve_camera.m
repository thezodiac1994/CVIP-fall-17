function [] = solve_camera(matches)
% centers 
camMat1 = load('../../data/part2/house1_camera.txt'); 
centers1 = camera_centers(camMat1) 
camMat2 = load ('../../data/part2/house2_camera.txt');
centers2 = camera_centers(camMat2)

%triangulation and visualization of 3d plot
[proj1,proj2,triangulation_points] = triangulate(matches,camMat1,camMat2);
visualize(triangulation_points,[centers1;centers2]);

%residual error between 2d and projected 3d points 
distances1 = diag(dist2(matches(:,1:2), proj1));
distances2 = diag(dist2(matches(:,3:4), proj2));
avg_residual_1 = sum(distances1) / size(distances1,1)
avg_residual_2 = sum(distances2) / size(distances2,1)

end


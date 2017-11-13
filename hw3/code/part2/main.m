I1 = imread('../../data/part2/house1.jpg');
I2 = imread('../../data/part2/house2.jpg');
matches = load('../../data/part2/house_matches.txt'); 

choice = 1; %set to 2 for RANSAC

inlier_threshold = 25; %set to 30 when using library

if(choice==1)
    normalization = 0; % set to 1 for normalized fundamental matrix 
    groundtruth(I1,I2,matches,normalization,inlier_threshold);
else 
    correspondences  = 89; %set to 149 or 199 when testing with library
    solve_by_ransac(I1,I2,correspondences,inlier_threshold);
end

solve_camera(matches);


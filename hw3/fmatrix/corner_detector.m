function feature_list = corner_detector (A_img,n) 
% image as obtained by im=imread('filename');
min_threshold_in_percentage = 1/10; % to be a feature, its value has to be over this percentage among all features in the image
show_resulting_img = 0; % 1: show the resulting img; 0 : don't show
%input image
%parameters for the gaussian
%feature window calculation
%find features
    if i <= strongest_features_overall
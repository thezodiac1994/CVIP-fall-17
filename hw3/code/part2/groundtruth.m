function [] = groundtruth(I1,I2,matches,Normalization,inlier_threshold)
N = size(matches,1);
% set this to 1 for normalization
% This function gets the F using groundtruth matches
if(Normalization==0)
    F = Fundamental(matches); 
else
    F = N_Fundamental(matches(:,1:2) , matches(:,3:4)); 
end

residual_error = Residual(F,N,matches,I1,I2,1,inlier_threshold);
mean_res = sum(residual_error) / size(residual_error,1)
end
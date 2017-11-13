function [na, N] = normalize(a)
%normalizes the given matrix a 
mean_a = mean(a);
Centers = a - repmat(mean_a, [size(a,1), 1]); %center the matrix at centroid
var_a = var(Centers);
sd_a = sqrt(var_a); 
N = [1/sd_a(1), 0,0; 0,1/sd_a(2), 0; 0,0,1]*[1,0,-mean_a(1);0,1,-mean_a(2);0,0,1]; % Scaling 
na = N * [a'; ones(1,size(a,1))];
na = na';
end

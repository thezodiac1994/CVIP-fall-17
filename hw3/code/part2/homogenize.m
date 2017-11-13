function [hA] = homogenize(A)    
    A(:,:) = A(:,:) ./ A(:,end); 
    hA = A(:,1:size(A, 2) - 1);
end
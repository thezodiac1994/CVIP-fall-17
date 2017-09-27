function histInter = distanceToSet(wordHist, histograms)
% Compute distance between a histogram of visual words with all training image histograms.
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) − 1 / 3) × 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) − 1 / 3) × T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 × T vector

	% TODO Implement your code here
    %whos wordHist
    %whos histograms
    
	histInter = zeros(1,size(histograms,2));
    for i = 1 : size(histograms,2)
        for j = 1:size(histograms,1)
            histInter(1,i) = histInter(1,i) + min(wordHist(j,1), histograms(j,i)); 
        end
    end
end
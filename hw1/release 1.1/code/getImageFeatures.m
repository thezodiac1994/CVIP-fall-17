function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
	h = zeros (1,dictionarySize);
    
    for i = 1 : size(wordMap,1)
        for j = 1 : size(wordMap,2)
            h (1,wordMap(i,j)) = h (1,wordMap(i,j)) + 1;
        end
    end
    
    h = h ./ norm (h,1);
    assert(numel(h) == dictionarySize);
end
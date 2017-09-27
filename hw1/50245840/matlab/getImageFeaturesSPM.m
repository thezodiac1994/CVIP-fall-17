function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)
% 21 histograms --> 16 of weight 1/2 ; 4 of weight 1/4 and 1 of weight 1/4
    % TODO Implement your code here
    
    % we start by working for the finest layer
    sz = power(4,layerNum-1); %sz is the number of divisions of the image
    div = sqrt(sz); %x and y axes are divided into sqrt no of total divisions of image i.e.div
    img16 = cell(sz,1); % this is the cell vector containing all the divisions of finest layer
    k = 1; % variable used as counter for current division number
    % [sz,div]
    histvalues = cell (1,21); % used to store hist normalized values as cell for easier operations
    
    % here we pass layernum = 3 so sz = 16 and div = 4
    % we are dividing the X and Y axis into blocks of  
    % sz/div sz/div sz/div sz 
    
    
    for i = 1:div       % i goes from 1 to 4 
        for j = 1:div   % j goes from 1 to 4 
            %the current cell window will be from xl to xu in the X axis
            %the current cell window will be from yl to yu in the Y axis
            % we have divided each dimension into div number of divisions so we find the indices 
            % of the ith block as follows :  
            xl = int32(((i-1)*size(wordMap,1))/div) + 1;  % start index for kth block in 1st dimension  
            xu = int32(((i)*size(wordMap,1))/div);  % end index for kth block in 1st dimension
            yl =  int32(((j-1)*size(wordMap,2))/div)+1 ;  % start index for kth block in 2nd dimension
            yu = int32(((j)*size(wordMap,2))/div);  % start index for kth block in 2nd dimension
            
            img16{k,1} = wordMap( xl : xu , yl:yu); % getting the cell using slicing as 
            %xl to xu on X axis and yl to yu on Y axis
            
            %figure, imagesc(img16{k,1});
            histvalues{1,k} = getImageFeatures(img16{k,1},dictionarySize);
            k = k + 1; %increase cell counter
        end
    end
    
    % 1  2   3   4 
    % 5  6   7   8 
    
    % 9  10  11  12 
    % 13 14  15  16 
    %v1 v2 v3 and v4 are vector histograms of 4 cells of the image 
    % so we can figure out from the figure how we can obtain it from
    % previous 16 blocks 
    
    v1 = histvalues{1,1} + histvalues{1,2} + histvalues{1,3} + histvalues{1,4};
    histvalues{1,17} = v1 ./ norm(v1,1);
    
    v2 = histvalues{1,3} + histvalues{1,4} + histvalues{1,7} + histvalues{1,8};
    histvalues{1,18} = v2 ./ norm(v2,1);
    
    
    v3 = histvalues{1,9} + histvalues{1,10} + histvalues{1,13} + histvalues{1,14};
    histvalues{1,19} = v3 ./ norm(v3,1);
    
    
    v4 = histvalues{1,11} + histvalues{1,12} + histvalues{1,13} + histvalues{1,14};
    histvalues{1,20} = v4 ./ norm(v4,1);
    
    v11 = v1 + v2 + v3 + v4; % v11 is the histogram for the entire image
    histvalues{1,21} = v11 ./ norm(v11,1);
    
    % now using weights 1/2 and 1/4 appropriately
    for i = 1 : 16
        histvalues{1,i} = histvalues {1,i} ./ 2;
    end
    for i = 17:21
        histvalues{1,i} = histvalues {1,i} ./ 4;
    end
    
    h = [];
    for i = 1:21
        h = [h  histvalues{1,i}];
    end
    
    % sum(h(:)) % this is 9.25
    h = h./sum(h(:));
    h = h.'; % make h a 21k x 1 column vector as reqd
    %sum (h(:)) % this is 1 
    %h = net_hist;
end
    
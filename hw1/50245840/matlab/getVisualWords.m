function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    
    FR = extractFilterResponses(img, filterBank);
    %whos FR 
    %figure, imshow(img);
    % concat along w X h X 60 to wh X 60 --> this is wrong
    %cat (1,FR(,:,:),FR());
    %FR = reshape(FR,[size(FR,1)*size(FR,2) size(FR,3)]); %problem is that this takes col1 col2 col3 ans so on instead of row1 row2 and so on ... but dont know if this should create a problem
    
    wordMap = zeros(size(img,1), size(img,2));
    dictionary = dictionary.'; % retransforming dictionary to row wise orientation for simple calculations 
    
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            pixel_vector = FR(i,j,:); % get the pixel value across 60 dimensions
            pixel_vector = reshape(pixel_vector , [1 60]); % go from 1 x 1 x 60 to 1 x 60
            %whos pixel_vector   %1 x 60    
            distance = pdist2(pixel_vector,dictionary); % distance from k clusters
            %whos distance % 1 x k --> distance from k vectors 
            [rmin,cmin] = find(distance == min(distance));% rmin = 1 , cmin = closest cluster
            wordMap(i,j) = cmin;
        end
    end
    
   % figure, imagesc(wordMap);
    
   
end

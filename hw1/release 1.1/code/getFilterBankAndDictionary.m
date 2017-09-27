function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();

    % TODO Implement your code here
    alpha = 80;
    
    alpres = cell(length(imPaths),1);  % this will store alpha points of responses
    
    mn = 111111111; % min size of a dimension among all images 
    
    
    for i = 1 : length(imPaths)
        img = imread(strcat('../data/',imPaths{i,1}));
        mul = size(img,1)*size(img,2);
        mn = min(mn,mul);
    end
    
    x = randperm(mn,alpha); % this is random perm of alpha points with each num <= mn

    
    for i = 1 : length(imPaths)
        img = imread(strcat('../data/',imPaths{i,1}));
        %imresize(img,[mn , mn]);
        % first convert gray scale image to rgb
        if (size(img,3)==1)
            img = repmat(img,[1 1 3]);
        end
        res = extractFilterResponses(img,filterBank);
        % response is w * h * (20*n)
        
        
        cu_row = cell(1,60); % this will store the current response along the 60 dimensions
        for k = 1:60
            tempres = res(:,:,k); %get the 1st dimension response
            tempres = tempres(x); %select x random points 
            %whos tempres 
            cu_row{1,k} = tempres.'; %save transpose as tempres is a row vector  
        end
        
        whos cu_row
        cu_row = cat(2,cu_row{:});
        whos cu_row
        % row = cell2mat(cu_row);
        
        %whos cu_row
        
        alpres{i,1} = cu_row; % store the current response in alpha responses cell
        i
    end
    
       % whos alpres
       alpmat = cell2mat(alpres);
       %alpmat = transpose(alpmat);
       %whos alpmat % T*alpha x 3*F = 80*T x 60 
    [~,dictionary] = kmeans(alpmat,100,'EmptyAction', 'drop');
   
    %dictionary
     dictionary = dictionary.';%lena hai ke nahi transpose ?
    
    
    
end

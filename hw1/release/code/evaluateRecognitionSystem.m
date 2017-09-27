function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    maps = string (zeros(1,size(mapping,2)));%Conversion of mapping from struct to
    %string array. This is an array of strings that stores each of the possible class names. 
    
    for i = 1 : 8 
        maps(1,i) = mapping {1,i}; 
    end
    
conf = zeros(8,8); %init confusion matrix
for i = 1:size(test_imagenames,1)
    pth = test_imagenames{i,1}; %load the image path
    pth = strcat('../data/',pth); % format the path 
    predicted = find (maps == guessImage(pth)); % replace guessImage(pth) by guessImage(pth)for knn matching
    actual = test_labels(i,1);
    fprintf ('i = %d ,,, a, p = %d , %d\n',i,actual,predicted); % for i th image, print the actual and expected labels
    conf(actual,predicted) = conf(actual,predicted) + 1;
end
    dlmwrite('confusion.mat',conf); % save confusion matrix in a text file
    percent = trace(conf) / sum (conf(:));
    percent*100
    
end
function guessedImage = guessImage( imagename ) 
% Given a path to a scene image, guess what scene it is
% Input:
%   imagename - path to the image

	%fprintf('[Loading..]\n');
    load('vision.mat');
	load('../data/traintest.mat','mapping');

	image = im2double(imread(imagename));

%	imshow(image);
	%fprintf('[Getting Visual Words..]\n');
	wordMap = getVisualWords(image, filterBank, dictionary);
	h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
	distances = distanceToSet(h, train_features);
    
    knn = 30;
    knn_labels = zeros(1,knn);
    for i = 1 : knn
        [~,nnI] = max(distances);
        knn_labels(1,i) = train_labels(nnI);
        distances(nnI) = -1;
    end
    
    
    mean_closest = mode(knn_labels(:));
	guessedImage = mapping{mean_closest};
	
    
    
    %fprintf('[My Guess]:%s.\n',guessedImage);

	%figure(1);
	%imshow(image);
	%title('image to classify')

end

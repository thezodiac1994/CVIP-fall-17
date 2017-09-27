function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');
    
	% TODO create train_features
    k = 100;
    histograms = cell (1,size(train_imagenames,1));  %this will store the 21 histograms
    for i = 1:size(train_imagenames,1)
        pth = train_imagenames{i,1}; %load path of all image names
        pth1 = strrep (pth,'.jpg','.mat'); %replace jpg with mat extension to load wordmap
        pth1 = strcat('../data/',pth1);  % change working directory
        wfile = load(pth1); %load all the files
        histograms{1,i} = getImageFeaturesSPM(3,wfile.wordMap,k); %store the ith histograms
    end
    %%}
    train_features = cell2mat(histograms); %convert to matrix
    %whos train_features



	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end
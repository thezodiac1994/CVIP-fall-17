buildRecognitionSystem();
evaluateRecognitionSystem();

%[filterBank, dictionary] = getFilterBankAndDictionary(train_imagenames);
%save('dictionary.mat','filterBank','dictionary'); 
%myCluster = parcluster('local');
%myCluster.NumWorkers = 4;  % 'Modified' property now TRUE
%saveProfile(myCluster); 
%batchToVisualWords(4);


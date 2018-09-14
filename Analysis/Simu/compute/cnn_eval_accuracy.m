function results = cnn_eval_accuracy(allData)
	%% CNN_EVAL_ACCURACY()
	% 
	% computes learning curves with mean accuracy and reward, as well as mean accuracy for each phase (train and test)
	% for all models, regimes and input codes
	%
	% (c) Timo Flesch, 2017
	

	% params 
	numTestTrials = 10000;
	numTestSessions = 2;
	inputRegimes = {'blocked','interleaved'};


	results = struct();
	results.lcurves = struct();
	results.accuracies = struct();


	for ii_ir = 1:length(inputRegimes) 
		ir = inputRegimes{ii_ir}
		accTrain = allData.(ir).resp.accTrain; % cat(1,allData_ns.(ir).resp.accTrain,allData_sn.(ir).resp.accTrain);
		accTest = allData.(ir).resp.accTest;   % cat(1,allData_ns.(ir).resp.accTest,allData_sn.(ir).resp.accTest);

		results.lcurves.(ir) = smoothMean(accTrain,100);

		
		for sess = 1:numTestSessions
			results.accuracies.mean.test.first.(ir)(sess,:) = nanmean(nanmean(accTest(:,:,sess,1),2),1);
			results.accuracies.mean.test.second.(ir)(sess,:) = nanmean(nanmean(accTest(:,:,sess,2),2),1);
			results.accuracies.mean.test.both.(ir)(sess,:)  = nanmean(nanmean(nanmean(accTest(:,:,sess,:),4),2),1);

			results.accuracies.std.test.first.(ir)(sess,:) = std(nanmean(accTest(:,:,sess,1),2),0,1,'omitnan');
			results.accuracies.std.test.second.(ir)(sess,:) = std(nanmean(accTest(:,:,sess,2),2),0,1,'omitnan');
			results.accuracies.std.test.both.(ir)(sess,:)  = std(nanmean(nanmean(accTest(:,:,sess,:),4),2),0,1,'omitnan');

			results.accuracies.all.test.first.(ir)(sess,:) = nanmean(accTest(:,:,sess,1),2);
			results.accuracies.all.test.second.(ir)(sess,:) = nanmean(accTest(:,:,sess,2),2);
			results.accuracies.all.test.both.(ir)(sess,:)  = nanmean(nanmean(accTest(:,:,sess,:),4),2);

		end
	end




end
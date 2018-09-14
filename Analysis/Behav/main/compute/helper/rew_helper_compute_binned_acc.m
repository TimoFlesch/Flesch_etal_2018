function [binsTrainPhase1,binsTrainPhase2,binsTestPhase] = rew_helper_compute_binned_acc(data,acc_col,trainBins1,trainBins2,testBins,binSize,binNumber)
% computes binned accuracy
% (c) Timo Flesch, 2017

%% main

	% allocate data to bins
	binsTrainPhase1 = [];
	binsTrainPhase2 = [];
	binsTestPhase   = [];

	for binID = 1:binNumber
		binsTrainPhase1(binID,:) = squeeze(data(trainBins1(binID):trainBins1(binID)+binSize-1,acc_col));
		binsTrainPhase2(binID,:) = squeeze(data(trainBins2(binID):trainBins2(binID)+binSize-1,acc_col));
		binsTestPhase(binID,:)   =     squeeze(data(testBins(binID):testBins(binID)+binSize-1,acc_col));
	end

	% avg bins
	binsTrainPhase1 = squeeze(nanmean(binsTrainPhase1,2));
	binsTrainPhase2 = squeeze(nanmean(binsTrainPhase2,2));
	binsTestPhase   =   squeeze(nanmean(binsTestPhase,2));


end

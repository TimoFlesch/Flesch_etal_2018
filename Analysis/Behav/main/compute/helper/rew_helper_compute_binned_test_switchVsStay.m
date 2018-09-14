function [binsTestStay,binsTestSwitch] = rew_helper_compute_binned_test_switchVsStay(testData,acc_col,binNumber)
% computes binned accuracy during test for switch and stay trials
% (c) Timo Flesch, 2017
	% separate data in switch and stay
	[switchData, stayData] = rew_helper_compute_SwitchVsStay_subsets(testData);

	% allocate data to bins
	switchBinSize = floor(size(switchData,1)/binNumber)
	stayBinSize   =   floor(size(stayData,1)/binNumber)

	switchBinIDX = 1;
	stayBinIDX   = 1;

	for binID = 1:binNumber
		binsTestSwitch(binID,:) = squeeze(switchData(switchBinIDX:switchBinIDX+switchBinSize-1,acc_col));
		binsTestStay(binID,:) = squeeze(stayData(stayBinIDX:stayBinIDX+stayBinSize-1,acc_col));
		stayBinIDX   =     stayBinIDX+stayBinSize;
		switchBinIDX = switchBinIDX+switchBinSize;
	end

	% avg bins
	binsTestSwitch = squeeze(nanmean(binsTestSwitch,2));
	binsTestStay   =   squeeze(nanmean(binsTestStay,2));

end

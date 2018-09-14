function cfMat = rew_helper_compute_choiceMatrixAvgCond(data,leaf_col,branch_col,resp_col,subCodes)
% brings matrices with same condition in same reference frame
% computes choice matrix
% (c) Timo Flesch, 2017

%% main 
	for leafLevel = 1:5
		for branchLevel = 1:5
			trialCount = length(find(data(:,leaf_col)==leafLevel & data(:,branch_col)==branchLevel)); % more of a sanity check
			plantCount = length(find(data(:,leaf_col)==leafLevel & data(:,branch_col)==branchLevel ...
				& data(:,resp_col)==1));
			cfMat(branchLevel,leafLevel) = plantCount/trialCount; % was only plantCount in first version!!!!!!!
		end
	end
	if subCodes(1) == 1 & subCodes(2) == 1
		cfMat = flipud(fliplr(cfMat)); % code 0 0
	elseif subCodes(1) == 0 & subCodes(2) == 1
		cfMat = fliplr(flipud(cfMat)) % code 1 0
	end
end

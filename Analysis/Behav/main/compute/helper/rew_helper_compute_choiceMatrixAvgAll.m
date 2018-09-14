function cfMat = rew_helper_compute_choiceMatrixAvgAll(data,leaf_col,branch_col,resp_col,subCodes)
% brings all matrices in same reference frame
% computes choice matrices
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
	if subCodes(1) == 1 % leaf flip
		cfMat = fliplr(cfMat);
	end
	if  subCodes(2) == 1 % branch flip
		cfMat = flipud(cfMat)
	end
end

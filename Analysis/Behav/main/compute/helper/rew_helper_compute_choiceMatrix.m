function cfMat = rew_helper_compute_choiceMatrix(data,leaf_col,branch_col,resp_col)
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
end

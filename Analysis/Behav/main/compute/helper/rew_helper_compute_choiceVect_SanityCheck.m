function cVect = rew_helper_compute_choiceVect_SanityCheck(data,task_col,resp_col,taskID,subCodes)
% little sanity check function
% computes choice psychometrics on single-subject level
% input:
% data: data matrix (task specific subset of all the data)
% task_col: column in data with task values (condition)
% resp_col: column in data wiht response values (choice)
% taskID: north/leaf (1) vs south/branch (2) of relevant OR irrelevant dimension
% subCodes: Flipped vs original reward assignment (0,1)
%
% (c) Timo Flesch, 2017


%% main

	%% compute
	cVect = [];
	for condLevel = 1:5
		% find all trials with this particular condition level
		% find all correct trials --
		%put ratio in vect
		allCount = length(find(data(:,task_col)==condLevel));
	  plantCount = length(find(data(:,task_col)==condLevel & data(:,resp_col)==1));
		cVect(condLevel) = plantCount/allCount;
	end

	%% align
	% if code was flipped, change it
	if (subCodes(taskID) == 1 )
		cVect = fliplr(cVect);
	end
end

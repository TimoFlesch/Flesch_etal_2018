function results = dissim_statinf_PrePostCorrDiff(tausPre,tausPost)
	%% RESULTS = DISSIM_STATINF_PREPOSTCORRDIFF(TAUSPRE,TAUSPOST)
	% 
	% tests for significant difference in pre and post 
	% model correlations for all models
	% Input: 
	% - n-x-m matrix of taus (n=subjects,m=models)
	% Output:
	% - taudiff: difference post minus pre
	% - pvals  : p-values 
	% 
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford	

	%% MAIN
	results =   struct();
	results.taudiff = tausPost-tausPre;
	results.pvals   = [];

	for modID = 1:size(results.taudiff,2)
		[results.pvals(modID),~] = signrank(results.taudiff(:,modID));
	end
end

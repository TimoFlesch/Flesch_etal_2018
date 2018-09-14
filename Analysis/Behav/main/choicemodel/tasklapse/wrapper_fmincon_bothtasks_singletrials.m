function results = wrapper_fmincon_bothtasks_singletrials(data,boundaryName,monitor)
	%% RESULTS = WRAPPER_FMINCON(DATA,BOUNDARYNAME,MONITOR)
	%
	% playground for various psychophysical models
	% note: modelfit NOT on single-trial leve, but on choice probability matrices (rotated and mirrored to be in the same frame of reference)
	%
	% INPUTS:
	% - data:	struct with single trial data
	% - boundaryName: 'cardinal' or 'diagonal' (depending on chosen cmat struct)
	% - monitor: 1 or 0, creates many figures
	%
	% OUTPUTS:
 	% -results: 	comparisonStats struct with all results
 	%
	% Timo Flesch, 2018
	if ~exist('boundaryName')
		boundaryName = 'cardinal';
	end
	if ~exist('monitor')
		monitor = 0;
	end
	results = struct();

	% 1. set all parameters
	results.params = main_setFittingParams(boundaryName);

	% 2. fit all the models & compute BIC
	results.modelfits = main_fitAllModels_singletrials(data,results.params);

	% 3. model comparison
	results.modelcomps = main_compareModels(results.modelfits,results.params,{[1,4]}); % fully parametrised vs tasklapse model

	% 4. stats
	results.stats = main_computePVals(results.modelfits,results.modelcomps,results.params);

	% 5. make maaaaaany barplots
	if monitor
		main_plotFittingResults(results.modelfits,results.params)
	end

end

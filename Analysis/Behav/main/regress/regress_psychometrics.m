function results = regress_psychometrics(data)
	%% REGRESS_PSYCHOMETRICS(DATA)
	%
	% fits sigmoids to choice probabilities
	% for all groups, and both the relevant as well as
	% irrelevant dimensions at single subject label
	% and performs inferential stats on slopes between groups
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	% groupNames = {'b200','b20','b2','int'};
	groupNames = {'b200','int'};
	expPhase   = {'test'};
	taskDim    = {'rel','irrel'};
	results = struct();

	%% 1. non-linear fit of sigmoid
	results.sigm_params = struct(); % slope and intercept
	for ep = expPhase
		for g = groupNames
			for td = taskDim
				for ii = 1:size(data.(ep{1}).(td{1}).(g{1}),1)
					x = zscore(-2:2);
					p_choices = squeeze(data.(ep{1}).(td{1}).(g{1})(ii,:));
					% fit sigmoid
					results.sigm_params.(ep{1}).(g{1}).(td{1}).sigma(ii,:) = fitSigmoid([x',p_choices']);
				end
			end
		end
	end


	%% 2. statistical inference (diff between all pairs of groups)
	results.pvals = [];
	for ep = expPhase
		for td = taskDim
			for ig1 = 1:length(groupNames)
				for ig2 = 1:length(groupNames)
					if ~strcmp(groupNames{ig1},groupNames{ig2})
						% results.pvals(ig1,ig2) = ranksum(results.sigm_params.(ep{1}).(groupNames{ig1}).(td{1}).sigma(:,1),results.sigm_params.(ep{1}).(groupNames{ig2}).(td{1}).sigma(:,1),'tail','right');
						[results.pvals.(td{1})(ig1,ig2),~] = ranksum(results.sigm_params.(ep{1}).(groupNames{ig1}).(td{1}).sigma(:,1),results.sigm_params.(ep{1}).(groupNames{ig2}).(td{1}).sigma(:,1));
					end
				end
			end
		end
	end


end

function sigmas = sample_fitsigmoids(modelsamples)
	%% SIGMAS = SAMPLE_FITSIGMOIDS(MODELSAMPLES)
	%
	% fits sigmoidal choice functions to synthetic data
	% for relevant and irrelevant dimensions
	%
	% note: modelfits are slightly off, try on avg values instead of single trials
	% alternative: rescale rew mats

	groups  = {'b200','b20','b2','int'};
	tasks   = {'north','south'};

	for gg = 1:length(groups)
		for tt = 1:length(tasks)
			for sID = 1:size(modelsamples.(groups{gg}).(tasks{tt}),1)
				x_rel = squeeze(modelsamples.(groups{gg}).(tasks{tt})(sID,:,4));
				x_irrel = squeeze(modelsamples.(groups{gg}).(tasks{tt})(sID,:,5));
				y = squeeze(modelsamples.(groups{gg}).(tasks{tt})(sID,:,3));
				betas = fitSigmoid([zscore(x_rel)',y']);
				sigmas.(groups{gg}).(tasks{tt}).rel(sID,:) = betas(1);
				betas = fitSigmoid([zscore(x_irrel)',y']);
				sigmas.(groups{gg}).(tasks{tt}).irrel(sID,:) = betas(1);
			end
		end

	end

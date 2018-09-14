function gridprior_mediansplit_modelCorrs()
	%% GRIDPRIOR_MEDIANSPLIT_MODELCORRS
	%
	% computes model correlations separately for low and high prior groups
	%
	% Timo Flesch, 2017

	curricula   =     {'B200', 'INT'};
	cfield     = {'b200','int'};
	experiments =  {'exp2a', 'exp2b'};
	expPhase   =              {'train','test'};

	for bID = 1:length(experiments)
		load(['taus_rsa_' experiments{bID} '.mat']);
		modelcorrs_low  = struct();
		modelcorrs_high = struct();
		for cID = 1:length(curricula)
			% load data
			load(['tauas_features_modelRDM_correlations_'  curricula{cID} '_pre_' experiments{bID} '.mat']);
			tauas = squeeze(tauas_features(:,3));
			% low prior and high prior subjects
			ii_subs_low  = find(tauas<=median(tauas));
			ii_subs_high =  find(tauas>median(tauas));
			for ep = expPhase
				modelcorrs_low.(ep{1}).(cfield{cID})  =  taus.(ep{1}).(cfield{cID}).both(ii_subs_low,:);
				modelcorrs_high.(ep{1}).(cfield{cID}) = taus.(ep{1}).(cfield{cID}).both(ii_subs_high,:);
			end
		end
		clear taus;
		taus = struct();
		taus.modelcorrs_high = modelcorrs_high;
		taus.modelcorrs_low  =  modelcorrs_low;
		save(['corrs_rdms_highVSlowGridiness_' experiments{bID} '.mat'],'taus');

	end


end

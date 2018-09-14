function gridprior_mediansplit_choicematrices()
	%% GRIDPRIOR_MEDIANSPLIT_CHOICEMATRICES()
	%
	% for blocked and interleaved and both boundaries, median split
	% choice matrix data into low and high gridiness prior groups
	% Timo Flesch, 2017


	curricula  =      {'B200', 'INT'};
	cfield     =       {'b200','int'};
	experiments =  {'exp2a', 'exp2b'};
	expPhase   =     {'train','test'};
	taskID     =    {'north','south'};


	for bID = 1:length(experiments)
		load(['choiceRTstats_' experiments{bID} '.mat']);
		choicemats_low  = struct();
		choicemats_high = struct();
		for cID = 1:length(curricula)
			% load data
			load(['tauas_features_modelRDM_correlations_'  curricula{cID} '_pre_' experiments{bID} '.mat']);
			tauas = squeeze(tauas_features(:,3));
			% low prior and high prior subjects
			ii_subs_low  = find(tauas<=median(tauas));
			ii_subs_high =  find(tauas>median(tauas));
			for ep = expPhase
				for tID = taskID
					choicemats_low.(ep{1}).(tID{1}).(cfield{cID})  =  results.choicematrix.(ep{1}).(tID{1}).(cfield{cID})(ii_subs_low,:,:);
					choicemats_high.(ep{1}).(tID{1}).(cfield{cID}) = results.choicematrix.(ep{1}).(tID{1}).(cfield{cID})(ii_subs_high,:,:);
				end
			end
		end
		clear results;
		results = struct();
		results.choicemats_high = choicemats_high;
		results.choicemats_low  =  choicemats_low;
		save(['choicemats_highVSlowGridiness_' experiments{bID} '.mat'],'results');

	end


end

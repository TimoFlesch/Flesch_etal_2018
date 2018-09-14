function gridprior_mediansplit_accuracy()
	%% GRIDPRIOR_MEDIANSPLIT_ACCURACY()
	%
	% for blocked and interleaved and both boundaries, median split
	% accuracy data into low and high gridiness prior groups
	% Timo Flesch, 2017


	curricula   =     {'B200', 'INT'};
	cfield      =      {'b200','int'};
	experiments =  {'exp2a', 'exp2b'};
	expPhase    =    {'train','test'};



	for bID = 1:length(experiments)
		load(['accuracies_' experiments{bID} '.mat']);
		accuracy_low  = struct();
		accuracy_high = struct();
		for cID = 1:length(curricula)
			% load data
			load(['tauas_features_modelRDM_correlations_'  curricula{cID} '_pre_' experiments{bID} '.mat']);
			tauas = squeeze(tauas_features(:,3));
			% low prior and high prior subjects
			ii_subs_low  = find(tauas<=median(tauas));
			ii_subs_high =  find(tauas>median(tauas));
			for ep = expPhase
				accuracy_low.(ep{1}).(cfield{cID})  =  acc_all.(ep{1}).(cfield{cID})(ii_subs_low);
				accuracy_high.(ep{1}).(cfield{cID}) = acc_all.(ep{1}).(cfield{cID})(ii_subs_high);

			end
		end
		clear acc_all;
		acc_all = struct();
		acc_all.accuracy_high = accuracy_high;
		acc_all.accuracy_low  =  accuracy_low;
		save(['accuracy_highVSlowGridiness_' experiments{bID} '.mat'],'acc_all');

	end


end

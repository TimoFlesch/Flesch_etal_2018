function [h,atab,ctab,stats] = gridprior_ancova(whichData,experiments,monitor)
	%% GRIDPRIOR_ANCOVA()
	%
	% performs ancova on accuracy and model parameters
	%
	% whichData = 'acc', 'rsa'
	%
	% Timo Flesch, 2017

	if ~exist('monitor')
		monitor = 1;
	end
	if ~exist('experiments')
		experiments =  {'exp2a', 'exp2b'};
	end

	for bID = 1:length(experiments)
			% load modelcorrs - Pre
			load(['tauas_features_modelRDM_correlations_B200_pre_' experiments{bID} '.mat']);
			taus_pre = tauas_features;
			% taus_pre(36,:) = []; % dodgy, diagonal
			gridiness_scores_blocked = squeeze(taus_pre(:,3)); % grid taus
			load(['tauas_features_modelRDM_correlations_INT_pre_' experiments{bID} '.mat']);
			taus_pre = tauas_features;
			% taus_pre(2,:)  = []; % dodgy, cardinal
			gridiness_scores_interleaved = squeeze(taus_pre(:,3));

			gridiness = [gridiness_scores_blocked;gridiness_scores_interleaved];
			groups    = [ones(length(gridiness_scores_blocked),1);2.*ones(length(gridiness_scores_interleaved),1)];

			switch whichData
				case 'acc'
					load(['accuracies_' experiments{bID} '.mat']);
					acc_blocked     = acc_all.test.b200';
					acc_interleaved =  acc_all.test.int';
					% acc_blocked(36) = [];
					acc = [acc_blocked;acc_interleaved];
					[h,atab,ctab,stats] = aoctool(gridiness,acc,groups,[],'gridiness','acc','curriculum','off');
					% multcompare(stats,0.05,'on','bonferroni','s');
				case 'rsa'
					load(['taus_rsa_' experiments{bID} '.mat']);
					taus_blocked     = squeeze(taus.test.b200.both(:,1));
					taus_interleaved = squeeze(taus.test.int.both(:,1));
					corrs = [taus_blocked;taus_interleaved];
					[h,atab,ctab,stats] = aoctool(gridiness,corrs,groups,[],'gridiness','factorisation','curriculum','off');
					% multcompare(stats,0.05,'on','bonferroni','s');
				end
				if monitor
					disp([experiments{bID} ':'])
					atab
				end
	end

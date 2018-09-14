function dissim_statinf_ranksumBetweenAllGroups()
	%% DISSIM_STATINF_RANKSUMBETWEENALLGROUPS
	%
	% performs rank sum between the model correlations of
	% all pairs of groups,
	% both for pre and post
	% to test the hypothesis that there are
	% differences in the arena estimates post training
	%
	% saves results directly
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford


	groupNames = {'cardinal_groupBlocked200',
	              'cardinal_groupInterleaved',
	              'diagonal_groupBlocked200',
	              'diagonal_groupInterleaved'};
	exp_phases = {'pre','post'};



	pvals = [];
	for eIDX = 1:length(exp_phases)
		for g1 = 1:length(groupNames)
			for g2 = 1:length(groupNames)
				if(g1 ~= g2)
					% load data
					load(['tauas_modelRDMpixelRDM_correlations_' groupNames{g1} '_' exp_phases{eIDX} '_premainpost_ARENAONLY_goodsubs.mat']);
					tausG1 = tauas;
					load(['tauas_modelRDMpixelRDM_correlations_' groupNames{g2} '_' exp_phases{eIDX} '_premainpost_ARENAONLY_goodsubs.mat']);
					tausG2 = tauas;
					for modIDX = 1:size(tausG1,2)
						pvals(eIDX,modIDX,g1,g2) = ranksum(squeeze(tausG1(:,modIDX)),squeeze(tausG2(:,modIDX)));
					end
				end
			end
		end
	end

	save('pvals_diffBetweenGroupModelCorr_statinf.mat','pvals');
end

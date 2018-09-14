function wrapper_dissim_statinf_RDMmassTtest()
	%% WRAPPER_DISSIM_STATINF_RDMMASSTTEST()
	%
	% wrapper function to compare all pairs
	% of participant groups for pre and post
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
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
					load(['rdmSet_' groupNames{g1} '_' exp_phases{eIDX} '.mat']);
					rdmSet = squeeze(mean(rdmSet,2));
					rdmsG1 = rdmSet;
					load(['rdmSet_' groupNames{g2} '_' exp_phases{eIDX} '.mat']);
					rdmSet = squeeze(mean(rdmSet,2));
					rdmsG2 = rdmSet;
					pvals(eIDX,g1,g2,:) = dissim_statinf_RDMmassTtest(rdmsG1,rdmsG2);

				end
			end
		end
	end

	save('pvals_diffBetweenGroupRDMs_statinf.mat','pvals');

end

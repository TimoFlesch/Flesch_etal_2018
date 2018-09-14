function wrapper_dissim_computeLBUB_RDMCorrs()
	%% WRAPPER_DISSIM_COMPUTELBLB_RDMCORRS()
	%
	% wrapper function to compute group-specific
	% lower and upper bound of the rdm noise ceiling
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	curricula       =               {'B200','INT'};
	exp_phases      =               {'pre','post'};
	boundary_groups =      {'cardinal','diagonal'};

	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			for eIDX = 1:length(exp_phases)
				load(['rdmSet_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat']);
				tauas = dissim_computeLBUB_RDMCorrs(rdmSet);
				save(['tauas_LBUB_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat'],'tauas');
			end
		end
	end

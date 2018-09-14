function wrapper_dissim_computePrePostRDMCorrelations()
	%% WRAPPER_DISSIM_COMPUTEPREPOSTRDMCORRELATIONS()
	%
	% computes rdm model correlations for all subjects
	% and all conditions between pre and post
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford

	curricula       = {'B200','INT'};

	boundary_groups =      {'cardinal','diagonal'};



	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)

			% load subject rdms - PRE
			load(['rdmSet_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_pre.mat']);
			rdmSet_pre = rdmSet;
			% load subject rdms - POST
			load(['rdmSet_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_post.mat']);
			rdmSet_post = rdmSet;
			% compute correlation coefficients
			tauas = dissim_computePrePostRDMCorrelations(rdmSet_pre,rdmSet_post);

			% save results
			save(['tauas_PrePostRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '.mat'],'tauas');


		end
	end

end

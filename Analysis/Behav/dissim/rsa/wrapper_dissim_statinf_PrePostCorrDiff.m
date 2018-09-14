function wrapper_dissim_statinf_PrePostCorrDiff()
	%% WRAPPER_DISSIM_STATINF_PREPOSTCORRDIFF()
	%
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford


	curricula       =              {'B200','INT'};
	boundary_groups =      {'cardinal','diagonal'};

	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			load(['tauas_modelRDMpixelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_pre.mat']);
			tausPre = tauas;

			load(['tauas_modelRDMpixelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_pre.mat']);
			tausPost = tauas;

			results = dissim_statinf_PrePostCorrDiff(tausPre,tausPost);
			save(['taua_diffprepost_statinf_modelRDMpixelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '.mat'],'results');

		end
	end

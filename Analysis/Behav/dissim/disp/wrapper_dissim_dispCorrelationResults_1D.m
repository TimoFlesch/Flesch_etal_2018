function wrapper_dissim_dispCorrelationResults_1D()
	%% WRAPPER_DISSIM_DISPCORRELATIONRESULTS_1D
	%
	% wrapper to displaye model correlation results
	% for all groups (curricula, boundaries)
	%
	% (C) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% Univerity of Oxford


	curricula       = {'Blocked200','Interleaved'};
	boundary_groups =      {'cardinal','diagonal'};

	

	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)			
			
			% load modelcorrs - Pre
			load(['tauas_1D_modelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' 'pre' '_premainpost_allindia.mat']);
			taus_pre = tauas_1D;

			% load modelcorrs - Post
			load(['tauas_1D_modelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' 'post' '_premainpost_allindia.mat']);
			taus_post = tauas_1D;

			% load noise ceiling - pre
			load(['tauas_LBUB_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' 'pre' '_premainpost_allindia.mat']);
			noiseceil_pre = tauas;

			% load noise ceiling - post
			load(['tauas_LBUB_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' 'post' '_premainpost_allindia.mat']);
			noiseceil_post = tauas;

			titleStr = [curricula{cIDX} ' ' boundary_groups{bIDX}  ' PRE vs POST'];
			% call funct
			dissim_dispCorrelationResults_1D2D(taus_pre,taus_post,noiseceil_pre,noiseceil_post,titleStr,1);

			
		end
	end

end 
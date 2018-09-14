function tauas = cvae_compute_rdmCorr(rdmSet)
	%% CVAE_COMPUTE_RDMCORR(RDMSET)
	%
	% computes correlation between cvae encoder rdms and model rdms
	% for last training epoch
	%
	% Timo Flesch, 2017
	
	tauas    = [];
	modelSet = dissim_computeModelRDMs_features();
	for ii = 1:5 % for each model
		for jj = 1:6 % for each run
			tauas(ii,jj) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(rdmSet(jj,end,:,:))),vectorizeRDM(squeeze(modelSet.rdmSet(ii,:,:))));
		end
	end


end
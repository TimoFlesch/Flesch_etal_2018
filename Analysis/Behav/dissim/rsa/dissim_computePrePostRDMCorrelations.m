function tauas = dissim_computePrePostRDMCorrelations(rdmSet_pre,rdmSet_post)
	%% TAUAS = DISSIM_COMPUTEPREPOSTRDMCORRELATIONS
	%
	% computes various correlations between
	% - pre RDMs, post RDMs
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	tauas = [];

	% average rdms across trials:
	rdmSet_pre = squeeze(mean(rdmSet_pre,2));
	rdmSet_post = squeeze(mean(rdmSet_post,2));

	% iterate through subs:
	for ii = 1:size(rdmSet_pre,1) % for all subjects		
		tauas(ii) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(rdmSet_pre(ii,:,:))),vectorizeRDM(squeeze(rdmSet_post(ii,:,:))));
	end

end
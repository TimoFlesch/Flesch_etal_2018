function tauas = dissim_computeRDMCorrelations(modelRDMs, pixelRDMs, subjectRDMs,modelIDs)
	%% DISSIM_COMPUTERDMCORRELATIONS(MODELRDMS,PIXELRDMS,SUBJECTRDMS,BOUNDARYIDCES)
	%
	% computes kendalls tau a between model and behavioural RDMs
	% uses boundary indices to select correct cluster/bias model
	%
	% (c) Timo Flesch, 2017
	% Summerfield lab, Experimental Psychology Department,
	% University of Oxford

	tauas = [];

	% average rdms across trials:
	subjectRDMs = squeeze(mean(subjectRDMs,2));
	%pixelRDMs   =   squeeze(mean(pixelRDMs,2));

	% iterate through subs:
	for ii = 1:size(subjectRDMs,1) % for all subjects		
		for jj = 1:size(modelIDs,2)
		for kk = 1:size(modelIDs,3) % for all models
			tauas(ii,jj,kk) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(modelRDMs(modelIDs(ii,jj,kk),:,:))),vectorizeRDM(squeeze(subjectRDMs(ii,:,:))));
		end
		end			
		% stimuli (pixel rdms)

		%tauas(ii,size(modelIDs,2)+1,1) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(pixelRDMs(ii,:,:))),vectorizeRDM(squeeze(subjectRDMs(ii,:,:))));
	end
end

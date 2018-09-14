function tauas =  dissim_computeRDMCorrelations_features(modelRDMs, pixelRDMs, subjectRDMs)
	%
	% computes correlation between feature based model rdms and subject rdms
	% for arena task
	%
	% Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	%% MAIN

	tauas = [];

	% average rdms across trials:
	subjectRDMs = squeeze(mean(subjectRDMs,2));
	%pixelRDMs   =   squeeze(mean(pixelRDMs,2));

	% iterate through subs:
	for ii = 1:size(subjectRDMs,1) % for all subjects		
		for jj = 1:size(modelRDMs,1)
			tauas(ii,jj) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(modelRDMs(jj,:,:))),vectorizeRDM(squeeze(subjectRDMs(ii,:,:))));
		end
		
		% stimuli (pixel rdms)
		%tauas(ii,size(modelRDMs,1)+1,1) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(pixelRDMs(ii,:,:))),vectorizeRDM(squeeze(subjectRDMs(ii,:,:))));
	end
end

function dissim_disp_prior_histograms()
	%% DISSIM_DISP_PRIOR_HISTOGRAMS
	% 
	% plots histograms of gridiness priors for each
	% group of participants in a 4x4 matrix
	% (curriculum x boundary)
	%
	% Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	curricula = {'Blocked200', 'Interleaved'};
	boundaries = {'cardinal', 'diagonal'};

	figure();set(gcf,'Color','w');
	plID = 1;
	for cID = 1:length(curricula)
		for bID = 1:length(boundaries)
		subplot(2,2,plID); plID = plID+1;
		% load data
		load(['tauas_features_modelRDM_correlations_' boundaries{bID} '_group' curricula{cID} '_pre_premainpost_allindia.mat']);
		tauas = squeeze(tauas_features(:,3));
		% hist
		hist(tauas,20);
		xlim([-0.2,0.8]);
		ylim([0,10]);
		title({['\bf Gridiness Prior, ' curricula{cID} ', ' boundaries{bID}]; ['\rm' num2str(sum(tauas<=0.3)) ' low, ' num2str(sum(tauas>0.3)) ' high']});
		xlabel('Gridiness');ylabel('# Subjects')
		end
	end


end

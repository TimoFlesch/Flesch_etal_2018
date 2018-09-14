function wrapper_cnn_collectSubjects(monitor)
	%% WRAPPER_CNN_COLLECTSUBJECTS(MONITOR)
	%
	% wrapper function to collect all runs (='subjects')
	% for a particular experimental setting
	% 
	% if monitor flag is set, mean accuracies for each run and first as well as second testing session are being displayed
	% 
	% Timo Flesch, 2017

	if ~exist('monitor')
		monitor = 0;
	end 


	boundaries = {'cardinal','diagonal'};
	curricula = {'blocked','interleaved'};
	taskOrder = {'ns','sn'};
	rewards   = {'pp','mm','mp','pm'};


	for bound = boundaries
		for to = taskOrder
			for rew = rewards
				allRuns = cnn_collectSubjects(to{1},bound{1},rew{1});
				if monitor
					for curr = curricula				
						disp('---------------------------------------------------------------')
						disp([ curr{1} ' ' bound{1}, ' ' to{1}, ' ' rew{1} ' -  Accuracy, first session:']);
						squeeze(nanmean(allRuns.cnn.(curr{1}).resp.accTest(:,:,1,:),2))
						disp([ curr{1} ' ' bound{1}, ' ' to{1}, ' ' rew{1} ' -  Accuracy, second session:']);
						squeeze(nanmean(allRuns.cnn.(curr{1}).resp.accTest(:,:,2,:),2))
						disp('---------------------------------------------------------------')
					end
				end
				save(['allRuns_cnn_cvae_3D_beta1_' bound{1}, '_' to{1}, '_' rew{1} '.mat'],'allRuns');
			end
		end
	end

end
function wrapper_cnn_compute_rdms()
	%% WRAPPER_CNN_COMPUTE_RDMS()
	%
	% wrapper function to compute rdms for all tasks and data sets
	%
	% Timo Flesch, 2017


	boundaries = {'cardinal','diagonal'};
	taskorders = {'ns','sn'};

	for b = boundaries		
		for to = taskorders
			disp([b{1},', ',to{1}]);
			load(['allData_cnn_cvae_beta50_' b{1} '_' to{1} '.mat']);
			rdmCollection = cnn_compute_rdms_layers(allData);
			save(['results_rdmCollection_' b{1} '_' to{1} '_cnn_cvae_beta50.mat'],'rdmCollection');
		end
	end

	 

function taus = cnn_correlate_model_layerRDMs(orthogonalize)
	%% CNN_CORRELATE_MODEL_LAYERRDMS()
	%
	% correlates various model rdms with the rdms computed
	% from individual layer activity patterns.
	% note: do this also for choice layer
	%
	% figure structure: barplots with sub-bars for each model, and x ticks for each curriculum
	%
	% Timo Flesch, 2017

	if ~exist('orthogonalize')
		orthogonalize = 0;
	end

	% iterate through conditions 
	curricula  = {'blocked','interleaved'};	
	boundaries =   {'cardinal','diagonal'};
	taskSets   =                  {'both'};
	% layers     = {'layerConv1Test','layerConv2Test','layerfc1Test','layerfc2Test'};
	layers     = {'layerfc1Test','layerfc2Test'};
	taskOrder  = {'ns','sn'};
	numSessions = 2;


	taus = struct();
	 for b = boundaries
	 	for to = taskOrder
			% 1. load layer rdms
			clear rdmCollection layer_rdms choice_rdms
			load(['results_rdmCollection_' b{1} '_' to{1} '_cnn_cvae_beta50.mat']);
            layer_rdms = rdmCollection;
			% 2. load choice rdms ( i want all in one file)
			load(['results_rdmCollection_' b{1} '_' to{1} '_CHOICE_cnn_cvae_beta50.mat']);
            choice_rdms = rdmCollection;
			clear rdmCollection;
			% 3. load unprocessed data and extract reward codes (to apply correct models)
			load(['allData_cnn_cvae_beta50_' b{1} '_' to{1} '.mat']);
			rewCodes = struct();
			rewCodes.blocked = allData.blocked.rewCode;
			rewCodes.interleaved = allData.interleaved.rewCode;
			clear allData;
			% let's get ready to rumble				
			for c = curricula
				for t = taskSets
					for sess = 1:numSessions
						for runID = 1:size(layer_rdms.(c{1}).(layers{1}).(t{1}),1)
							% for each run, compute the specific model rdms, taking into account (a) boundary (b) task order (c) reward code!! This is important as otherwise the orthogonal model might not have the appropriate orientation (and there are subtle differences between aligned and non aligned reward signs)
							rdmSet = compute_modelRDMs(b{1},rewCodes.(c{1}){runID});
							% models: pixel, factorised, interference, linear
							if strcmp(to{1},'ns')
								modelRDMs = rdmSet([1,6,5,8],:,:);
							elseif strcmp(to{1},'sn')
								modelRDMs = rdmSet([2,7,4,8],:,:);
							end
							if orthogonalize % apply recursive gram-schmidt orthogonalisation
								% disp('apply orthogonalisation');
								modelRDMs = orthogonalize_modelRDMs(modelRDMs);
							end
							clear rdmSet;
							
							for modID = 1:size(modelRDMs,1)
								% layer-wise
								for lID = 1:size(layers,2)
									taus.(b{1}).(c{1}).(to{1}).(t{1})(runID,sess,lID,modID) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(layer_rdms.(c{1}).(layers{lID}).(t{1})(runID,sess,:,:))),vectorizeRDM(squeeze(modelRDMs(modID,:,:))));
								end
								% choice 
								taus.(b{1}).(c{1}).(to{1}).(t{1})(runID,sess,size(layers,2)+1,modID) = rankCorr_Kendall_taua(vectorizeRDM(squeeze(choice_rdms.(c{1}).(t{1})(runID,sess,:,:))),vectorizeRDM(squeeze(modelRDMs(modID,:,:))));
							end
						end
					end
				end
			end
	 	end
	 end
end
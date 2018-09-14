function rdmCollection = cnn_compute_rdms_layers(allData)
	%% RDMCOLLECTION = CNN_COMPUTE_RDMS_LAYERS(ALLDATA)
	%
	% computes rdm on layer activation patterns 
	% for all conditions
	%
	% Timo Flesch, 2017

	curricula       = {'blocked','interleaved'};
	% layers          = {'layerConv1Test','layerConv2Test','layerfc1Test','layerfc2Test'};
	layers          = {'layerfc1Test','layerfc2Test'};
	numTestSessions = 2;
	rdmCollection   = struct();
	
	for c = curricula
		for ll = layers 			
			% extract data for both test sessions	
			tmp = [];		
			tmp(1,:,:,:) = allData.(c{1}).resp.(ll{1})(:,1:50,:);
			tmp(2,:,:,:) = allData.(c{1}).resp.(ll{1})(:,51:end,:);
			% iterate through sessions and compute rdms
			for sess = 1:numTestSessions
				for runID = 1:size(tmp,2)
					resp1 = squeeze(tmp(sess,runID,1:25,:));
					resp2 = squeeze(tmp(sess,runID,26:end,:));
					resp3 = [resp1;resp2];
					rdmCollection.(c{1}).(ll{1}).first(runID,sess,:,:)  = squareform(pdist(resp1,'correlation'));
					rdmCollection.(c{1}).(ll{1}).second(runID,sess,:,:) = squareform(pdist(resp2,'correlation'));
					rdmCollection.(c{1}).(ll{1}).both(runID,sess,:,:)   = squareform(pdist(resp3,'correlation'));
				end
			end
		end
	end

end

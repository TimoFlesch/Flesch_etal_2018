function rdmCollection = cnn_compute_rdms_choice(results)
	%% CNN_COMPUTE_RDMS_CHOICE(RESULTS)
	%
	% computes rdms based on choice matrices 
	% returns rdm collection run-sess-dim1-dim2
	%
	% (c) Timo Flesch, 2017



	numTestTrials = 10000;
	numTestSessions = 2;
	inputRegimes = {'blocked','interleaved'};
	dimsIn = {'north','south'};

	for ii_ir = 1:length(inputRegimes) 
		ir = inputRegimes{ii_ir}
		for testSess = 1:numTestSessions
			for taskorder = {'ns','sn'};
				for runID = 1:size(results.(taskorder{1}).(dimsIn{1}).(ir),1)
					if strcmp(taskorder,'ns')					
						task1 = squeeze(results.(taskorder{1}).(dimsIn{1}).(ir)(runID,testSess,:,:));
						task1 = task1(:);
						task2 = squeeze(results.(taskorder{1}).(dimsIn{2}).(ir)(runID,testSess,:,:));
						task2 = task2(:);
						tasks = [task1;task2];
					else
						task1 = squeeze(results.(taskorder{1}).(dimsIn{2}).(ir)(runID,testSess,:,:));
						task1 = task1(:);
						task2 = squeeze(results.(taskorder{1}).(dimsIn{1}).(ir)(runID,testSess,:,:));
						task2 = task2(:);
						tasks = [task1;task2];
					end
					
					rdmCollection.(taskorder{1}).(ir).first(runID,testSess,:,:)  =  squareform(pdist(task1));
					rdmCollection.(taskorder{1}).(ir).second(runID,testSess,:,:) =  squareform(pdist(task2));
					rdmCollection.(taskorder{1}).(ir).both(runID,testSess,:,:)   =  squareform(pdist(tasks));
				end
			end	
		end
	end
end
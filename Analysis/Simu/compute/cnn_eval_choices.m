function results = cnn_eval_choices(allData_ns,allData_sn)
	%% CNN_EVAL_CHOICES()
	%
	% evaluates choice patterns of models for all curricula etc
	%
	% (c) Timo Flesch, 2017
	

	% params 
	numTestTrials   = 10000;
	numTestSessions =     2;

	inputRegimes = {'blocked','interleaved'};

	%% 1. compute matrices	
	results = struct();

	for ii_ir = 1:length(inputRegimes) 
		ir = inputRegimes{ii_ir}		
		results.ns.north.(ir) = helper_compute_choicematrix(allData_ns.(ir), 1,'ns');
		results.ns.south.(ir) = helper_compute_choicematrix(allData_ns.(ir), 2,'ns');

		results.sn.north.(ir) = helper_compute_choicematrix(allData_sn.(ir), 2,'sn');
		results.sn.south.(ir) = helper_compute_choicematrix(allData_sn.(ir), 1,'sn');		
	end
	%% 2. align matrices to pp
	% for ii_ir = 1:length(inputRegimes) 
	% 	ir = inputRegimes{ii_ir}		
	% 	results.ns.north.(ir) = helper_alingMatrices(results.ns.north.(ir),allData_ns.(ir).rewID,'north','ns');		
	% 	results.ns.south.(ir) = helper_alingMatrices(results.ns.south.(ir),allData_ns.(ir).rewID,'south','ns');

	% 	results.sn.north.(ir) = helper_alingMatrices(results.sn.north.(ir),allData_sn.(ir).rewID,'north','sn');		
	% 	results.sn.south.(ir) = helper_alingMatrices(results.sn.south.(ir),allData_sn.(ir).rewID,'south','sn');
	% end

	%% 3. if taskorder ==ns, align tasks, s.t. first == south, second == north
	% for ii_ir = 1:length(inputRegimes) 	
	% 	ir = inputRegimes{ii_ir}	
	% 	results.ns.north.(ir)     = helper_alignTasks(results.ns.north.(ir),1);
	% 	results.ns.south.(ir)     = helper_alignTasks(results.ns.south.(ir),2);
	% 	% results.ns.north.interleaved = helper_alignTasks(results.ns.north.interleaved,1);
	% 	% results.ns.south.interleaved = helper_alignTasks(results.ns.south.interleaved,2);

	% 	results.all.first.(ir)      = cat(1,results.ns.north.(ir),results.sn.south.(ir));
	% 	results.all.second.(ir)     = cat(1,results.ns.south.(ir),results.sn.north.(ir));
	% 	% results.all.first.interleaved  = cat(1,results.ns.south.interleaved,results.sn.south.interleaved);
	% 	% results.all.second.interleaved = cat(1,results.ns.north.interleaved,results.sn.north.interleaved);
	% end

end


function alignedMats = helper_alignTasks(data,taskID)

	switch taskID
	case 1 % first is north, turn it into south
		for ii = 1:size(data,1)
			for jj = 1:size(data,2)
				alignedMats(ii,jj,:,:) = fliplr(rot90(squeeze(data(ii,jj,:,:)),3));
			end
		end
	case 2 % second is south, turn into north
		for ii = 1:size(data,1)
			for jj = 1:size(data,2)
				alignedMats(ii,jj,:,:) = flipud(rot90(squeeze(data(ii,jj,:,:))));
			end
		end
	end
end

function cMats = helper_compute_choicematrix(data, taskID,taskOrder);
	%% HELPER_COMPUTE_CHOICEMATRIX(DATA,TASKID)
	%
	% computes choice matrices 
	% input: 
	%  - data:   struct with exp and resp substructs
	%  - taskID: first=1, second=2
	% 
	% output:
	% run-x-sess-x-dim1-dim2 matrices 

	cMats = [];

	for runID = 1:size(data.resp.choiceProbaTest,1)
		for testSess = 1:size(data.resp.choiceProbaTest,3)
			for dim1 = 1:5
				for dim2 = 1:5 
					if (taskID ==1)
						cMats(runID,testSess,dim1,dim2) = squeeze(nanmean(data.resp.choiceProbaTest(runID,(data.exp.leafinessTest(runID,1:5000)==dim1 & data.exp.branchinessTest(runID,1:5000)==dim2),testSess,1)));
					elseif (taskID ==2)
						cMats(runID,testSess,dim1,dim2) = squeeze(nanmean(data.resp.choiceProbaTest(runID,(data.exp.leafinessTest(runID,5001:end)==dim1 & data.exp.branchinessTest(runID,5001:end)==dim2),testSess,2)));
					end											
				end 
			end 
		end 
	end 
end 



function outMats = helper_alingMatrices(cMats,codes,garden,taskOrder)
	outMats = [];
	for runID = 1:size(cMats,1)
		for sessID = 1:size(cMats,2)
			outMats(runID,sessID,:,:) = helper_alignMatrix(squeeze(cMats(runID,sessID,:,:)),codes(runID),garden,taskOrder);
		end
	end
end

function outMat = helper_alignMatrix(inMat,code,garden,taskOrder)
%% HELPER_ALIGNMATRIX(INMAT,CODE,GARDEN)
%
% aligns all matrices of trees task to have same frame of reference
%
% input:
%	- inMat:   matrix to manipulate
%	- code:    code of reward assignment schema (1 to 8)
% 	- garden: 'north' or 'south'
%
% Timo Flesch, 2017


switch (code)
	case 1
		% cardinal high high
		if strcmp(garden,'north')
			outMat = inMat;
		elseif strcmp(garden,'south')
			outMat = inMat;
		end
	case 2
		% cardinal low low
		if strcmp(garden,'north')
			outMat = flipud(fliplr(inMat));
		elseif strcmp(garden,'south')
			outMat = flipud(fliplr(inMat));
		end
	case 3
		% cardinal low high
		if strcmp(taskOrder,'sn')
			if strcmp(garden,'north')
				outMat = flipud(inMat);
			elseif strcmp(garden,'south')
				outMat = flipud(inMat);
			end
		else 
			if strcmp(garden,'north')
				outMat = fliplr(inMat);
			elseif strcmp(garden,'south')
				outMat = fliplr(inMat);
			end
		end

	case 4
		% cardinal high low
		if strcmp(taskOrder,'sn')
			if strcmp(garden,'north')
				outMat = fliplr(inMat);
			elseif strcmp(garden,'south')
				outMat = fliplr(inMat);
			end
		else 
			if strcmp(garden,'north')
				outMat = flipud(inMat);
			elseif strcmp(garden,'south')
				outMat = flipud(inMat);
			end
		end

	case 5
		% diagonal high high
		if strcmp(garden,'north')
			outMat = inMat;
		elseif strcmp(garden,'south')
			outMat = inMat;
		end
	case 6
		% diagonal low low
		if strcmp(garden,'north')
			outMat = fliplr(flipud(inMat));
		elseif strcmp(garden,'south')
			outMat = fliplr(flipud(inMat));
		end
		
	case 8
		% diagonal low high
		if strcmp(garden,'north')
			outMat = fliplr(rot90(inMat,1));
		elseif strcmp(garden,'south')
			outMat = fliplr(rot90(inMat,1));
		end
	case 7
		% diagonal high low
		if strcmp(garden,'north')
			outMat = flipud(rot90(inMat,1));
		elseif strcmp(garden,'south')
			outMat = flipud(rot90(inMat,1));
		end
	end
end
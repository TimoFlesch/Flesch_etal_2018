function allRuns = cnn_collectSubjects(taskOrder,boundaryCode,rewardCoding)
%% CNN_COLLECTSUBJECTS()
% 
% collects mat files of single runs of all the experimetns and 
% stores them in struct according to input code and network structure
% 
% INPUT:
%  - taskOrder:  'ns' or 'sn' for north-south or south-north
%  - boundaryCode: 'cardinal' or 'diagonal'
%  - rewardCoding: 'pp','mm','pm' or 'mp'
%
% OUTPUT:
% - allRuns: struct with run files for coding specified by inputs 
%
% (c) Timo Flesch, 2017


if ~exist('taskOrder') 
	taskOrder = 'ns'; 
end

if ~exist('boundaryCode') 
	boundaryCode = 'cardinal'; 
end
if ~exist('rewardCoding')
	rewardCoding = 'pp';
end

% params 
numRuns  = 3;
% runIDs   = [0:numRuns-1]; % python indexing
runIDs     = 1:numRuns;

numTestTrials   = 10000;
numTestSessions =    2;
inputRegimes = {'blocked','interleaved'};
netStructure = {'cnn'};

% var initializer
allRuns= struct();

ns = 'cnn';
		
for ii_ir = 1:length(inputRegimes) 
	ir = inputRegimes{ii_ir};
	for rid = runIDs
		if rid == runIDs(1) % if first iter, initialize vars
			
			allRuns.(ns).(ir).exp  = struct();
			allRuns.(ns).(ir).resp = struct();
			allRuns.(ns).(ir).exp    = struct();
			allRuns.(ns).(ir).resp   = struct();

			allRuns.(ns).(ir).exp.taskTrain        = [];
			allRuns.(ns).(ir).exp.rewTrain         = [];
			allRuns.(ns).(ir).exp.catTrain         = [];
			allRuns.(ns).(ir).exp.leafinessTrain   = [];
			allRuns.(ns).(ir).exp.branchinessTrain = [];
			allRuns.(ns).(ir).exp.taskTest         = [];
			allRuns.(ns).(ir).exp.rewTest          = [];
			allRuns.(ns).(ir).exp.catTest          = [];
			allRuns.(ns).(ir).exp.leafinessTest    = [];
			allRuns.(ns).(ir).exp.branchinessTest  = [];			
			allRuns.(ns).(ir).resp.choiceProbaTrain = [];
			allRuns.(ns).(ir).resp.choiceCatTrain   = [];			
			allRuns.(ns).(ir).resp.choiceProbaTest  = [];
			allRuns.(ns).(ir).resp.choiceCatTest    = [];
			% allRuns.(ns).(ir).resp.layerConv1Test   = [];
			% allRuns.(ns).(ir).resp.layerConv2Test   = [];
			allRuns.(ns).(ir).resp.layerfc1Test     = [];
			allRuns.(ns).(ir).resp.layerfc2Test     = [];
			

			


		end
		
		data = load(['log_trainingsess_mod_CNN_CVAE_3D_BETA1_' ir '_' boundaryCode '_' taskOrder '_' rewardCoding '_' num2str(rid)]);

	    allRuns.(ns).(ir).exp.taskTrain(rid,:)        = data.tTrain;
		allRuns.(ns).(ir).exp.taskTest(rid,:)         = data.tTest;
		allRuns.(ns).(ir).exp.rewTrain(rid,:)         = data.rTrain;
		allRuns.(ns).(ir).exp.rewTest(rid,:)          = data.rTest;
		allRuns.(ns).(ir).exp.catTrain(rid,:)         = data.cTrain;
		allRuns.(ns).(ir).exp.catTest(rid,:)          = data.cTest;
		allRuns.(ns).(ir).exp.leafinessTrain(rid,:)   = data.lTrain;
		allRuns.(ns).(ir).exp.branchinessTrain(rid,:) = data.bTrain;
		allRuns.(ns).(ir).exp.leafinessTest(rid,:)    = data.lTest;
		allRuns.(ns).(ir).exp.branchinessTest(rid,:)  = data.bTest;
		
		allRuns.(ns).(ir).resp.choiceProbaTrain(rid,:)   = data.choiceTrain;
		allRuns.(ns).(ir).resp.choiceCatTrain(rid,:)     = data.catTrain;
		% allRuns.(ns).(ir).resp.layerConv1Test(rid,:,:)   = data.conv1Test;
		% allRuns.(ns).(ir).resp.layerConv2Test(rid,:,:)   = data.conv2Test;
		allRuns.(ns).(ir).resp.layerfc1Test(rid,:,:)     = squeeze(data.fcTest);
		allRuns.(ns).(ir).resp.layerfc2Test(rid,:,:)     = squeeze(data.fc2Test);
		
		tmp  = reshape(data.choiceTest,[numTestTrials,numTestSessions]);
		allRuns.(ns).(ir).resp.choiceProbaTest(rid,:,:,1)  = tmp(1:numTestTrials/2,:);
		allRuns.(ns).(ir).resp.choiceProbaTest(rid,:,:,2)  = tmp(numTestTrials/2+1:end,:);
		tmp = reshape(data.catTest,[numTestTrials,numTestSessions]);
		allRuns.(ns).(ir).resp.choiceCatTest(rid,:,:,1)   = tmp(1:numTestTrials/2,:);
		allRuns.(ns).(ir).resp.choiceCatTest(rid,:,:,2)   = tmp(numTestTrials/2+1:end,:);
		

		accTrain_tmp = nan(size(data.choiceTrain));		
		accTrain_tmp = cast((data.catTrain == data.cTrain),'double');
		accTrain_tmp(data.cTrain == 0) = NaN;

		
		tmpcat = [data.cTest(1:numTestTrials/2); data.cTest(numTestTrials/2+1:end)];
		for sess = 1:numTestSessions
			for taskID = 1:2
				accTest_tmp(:,sess,taskID) = cast(squeeze(allRuns.(ns).(ir).resp.choiceCatTest(rid,:,sess,taskID))' == squeeze(tmpcat(taskID,:))','double'); 
				accTest_tmp(squeeze(tmpcat(taskID,:))==0,sess,taskID) = NaN;
			end 
		end

		allRuns.(ns).(ir).resp.accTrain(rid,:)            = accTrain_tmp;
		allRuns.(ns).(ir).resp.accTest(rid,:,:,:)         =  accTest_tmp;


	
	end
end
	



end
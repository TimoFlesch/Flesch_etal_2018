function rsData = data_reshapeData(allData)
%% DATA_RESHAPEDATA(ALLDATA)
%
% reshapes data into more convenient file format
% (c) Timo Flesch, 2016

rsData     = struct();
rsData.code      = [];
rsData.data      = [];
rsData.structure = '';

for subj = 1:size(allData.expt_index,2)

	% set missed responses and corresponding reward to 0

	missingDat =      isnan(allData.resp_category(:,subj));
	timeOuts   = find(allData.resp_reactiontime(:,subj)>5);

	allData.resp_category(missingDat,subj) = 0;
	allData.resp_category(timeOuts,subj)   = 0;
	allData.resp_correct(timeOuts,subj)    = 0;
	allData.resp_reward(missingDat,subj)   = 0;
	allData.resp_reward(timeOuts,subj)     = 0;

	% treat cat bound trials as NaNs in correct vect:
	allData.resp_correct(allData.expt_catIDX(:,subj)==0,subj) = NaN;

	% reshape data into one neat matrix:
	rsData(subj).structure =  'block | sess | context | leaf | branch | cat | rew | resp_choice | resp_correct | resp_rew | resp_rt';
	rsData(subj).code      =          allData.subCodes(:,subj);
	rsData(subj).repnorth  =    allData.subReports(subj).north;
	rsData(subj).repsouth  =    allData.subReports(subj).south;
	rsData(subj).data(:,1) =        allData.expt_block(:,subj);
	rsData(subj).data(:,2) =      allData.expt_sessIDX(:,subj);
	rsData(subj).data(:,3) =   allData.expt_contextIDX(:,subj);
	rsData(subj).data(:,4) =      allData.expt_leafIDX(:,subj);
	rsData(subj).data(:,5) =    allData.expt_branchIDX(:,subj);
	rsData(subj).data(:,6) =       allData.expt_catIDX(:,subj);
	rsData(subj).data(:,7) =    allData.expt_rewardIDX(:,subj);
	rsData(subj).data(:,8) =     allData.resp_category(:,subj);
	rsData(subj).data(:,9) =      allData.resp_correct(:,subj);
	rsData(subj).data(:,10)=       allData.resp_reward(:,subj);
	rsData(subj).data(:,11)= allData.resp_reactiontime(:,subj);
	rsData(subj).id = allData.subTurker{subj};
	rsData(subj).file = allData.subExp{subj};

end

function results = compute_pcorrect_learningCurves(allData,monitor)
%% COMPUTE_PCORRECT_LEARNINGCURVES(SAVEDAT,MONITOR)
%
% computes learning curves in terms of correct classifications
% sets the category boundary trials to NaN
% (c) Timo Flesch, 2016

results = struct();

%% blocked task
% 1. all subjects
subsBlock200 = find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==200);
subsBlock20  =  find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==20);
subsBlock2   =   find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==2);

for subj = 1:length(subsBlock200)
	subID    =                         subsBlock200(subj);
	catZero  =      find(allData.expt_catIDX(:,subID)==0);
	corrAll  =              allData.resp_correct(:,subID);
	corrCat  =                                    corrAll;
	timeOuts = find(allData.resp_reactiontime(:,subID)>5);

	corrCat(timeOuts) =       0;
	corrCat(catZero)  =     NaN;
	pMatBlock(:,subj) = corrCat;
end
results.pMatBlock200     = pMatBlock;

pMatBlock = []
for subj = 1:length(subsBlock20)
	subID    =                         subsBlock20(subj);
	catZero  =      find(allData.expt_catIDX(:,subID)==0);
	corrAll  =              allData.resp_correct(:,subID);
	corrCat  =                                    corrAll;
	timeOuts = find(allData.resp_reactiontime(:,subID)>5);

	corrCat(timeOuts) =       0;
	corrCat(catZero)  =     NaN;
	pMatBlock(:,subj) = corrCat;
end
results.pMatBlock20     = pMatBlock;
pMatBlock = []
for subj = 1:length(subsBlock2)
	subID    =                         subsBlock2(subj);
	catZero  =      find(allData.expt_catIDX(:,subID)==0);
	corrAll  =              allData.resp_correct(:,subID);
	corrCat  =                                    corrAll;
	timeOuts = find(allData.resp_reactiontime(:,subID)>5);

	corrCat(timeOuts) =       0;
	corrCat(catZero)  =     NaN;
	pMatBlock(:,subj) = corrCat;
end
results.pMatBlock2     = pMatBlock;
pMatBlock = []

%% 2. condition 0 0 or 1 1
%subsBlockSame = find(allData.subCodes(1,:) ~= 3 & ...
%	allData.subCodes(2,:) == allData.subCodes(3,:));
%
%for subj = 1:length(subsBlockSame)
%
%	subID    =                        subsBlockSame(subj);
%	catZero  =      find(allData.expt_catIDX(:,subID)==0);
%	corrAll  =              allData.resp_correct(:,subID);
%	corrCat  =                                    corrAll;
%	timeOuts = find(allData.resp_reactiontime(:,subID)>5);
%
%	corrCat(timeOuts)     =       0;
%	corrCat(catZero)      =     NaN;
%	pMatBlockSame(:,subj) = corrCat;
%
%end
%
%results.pMatBlockSame     = pMatBlockSame;
%
%
%% 3. condition 1 0 or 0 1
%subsBlockDiff = find(allData.subCodes(1,:) ~= 3 & ...
%	allData.subCodes(2,:) ~= allData.subCodes(3,:));
%
%for subj = 1:length(subsBlockDiff)
%
%	subID    =                        subsBlockDiff(subj);
%	catZero  =      find(allData.expt_catIDX(:,subID)==0);
%	corrAll  =              allData.resp_correct(:,subID);
%	corrCat  =                                    corrAll;
%	timeOuts = find(allData.resp_reactiontime(:,subID)>5);
%
%	corrCat(timeOuts)     =       0;
%	corrCat(catZero)      =     NaN;
%	pMatBlockDiff(:,subj) = corrCat;
%
%end
%
%results.pMatBlockDiff     = pMatBlockDiff;


%% interleaved task
% 1. all subjects
subsInt = find(allData.subCodes(1,:) == 3);

for subj = 1:length(subsInt)

	subID     =                              subsInt(subj);
	catZero   =      find(allData.expt_catIDX(:,subID)==0);
	corrAll   =              allData.resp_correct(:,subID);
	corrCat   =                                    corrAll;
	timeOuts  = find(allData.resp_reactiontime(:,subID)>5);

	corrCat(timeOuts)     =       0;
	corrCat(catZero)      =     NaN;
	pMatInt(:,subj)       = corrCat;

end

results.pMatInt = pMatInt;



%% 2. condition 0 0 or 1 1
%subsBlockSame = find(allData.subCodes(1,:) == 3 & ...
%	allData.subCodes(2,:) == allData.subCodes(3,:));
%
%for subj = 1:length(subsBlockSame)
%
%	subID    =                        subsBlockSame(subj);
%	catZero  =      find(allData.expt_catIDX(:,subID)==0);
%	corrAll  =              allData.resp_correct(:,subID);
%	corrCat  =                                    corrAll;
%	timeOuts = find(allData.resp_reactiontime(:,subID)>5);
%
%	corrCat(timeOuts)     =       0;
%	corrCat(catZero)      =     NaN;
%	pMatIntSame(:,subj) = corrCat;
%
%end
%
%results.pMatIntSame     = pMatIntSame;
%
%
%% 3. condition 1 0 or 0 1
%subsBlockDiff = find(allData.subCodes(1,:) == 3 & ...
%	allData.subCodes(2,:) ~= allData.subCodes(3,:));
%
%for subj = 1:length(subsBlockDiff)
%
%	subID    =                        subsBlockDiff(subj);
%	catZero  =      find(allData.expt_catIDX(:,subID)==0);
%	corrAll  =              allData.resp_correct(:,subID);
%	corrCat  =                                    corrAll;
%	timeOuts = find(allData.resp_reactiontime(:,subID)>5);
%
%	corrCat(timeOuts)     =       0;
%	corrCat(catZero)      =     NaN;
%	pMatIntDiff(:,subj) = corrCat;
%
%end
%
%results.pMatIntDiff     = pMatIntDiff;


if monitor
% monitor results

end

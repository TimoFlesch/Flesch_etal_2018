function rt_all = compute_rt(allData)
%% COMPUTE_RT()
%
% computes mean reaction time  for training and test, and for switch vs stay at test
%
% (c) Timo Flesch, 2017

%% init data structs
rt_all                   = struct();
rt_all.train             = struct();
rt_all.test              = struct();
rt_all.test_switchVsStay = struct();

%% compute overall during training
rt_all.train.b200  = helper_compute_rt(allData,'train','b200');
rt_all.train.b20  = helper_compute_rt(allData,'train','b20');
rt_all.train.b2  = helper_compute_rt(allData,'train','b2');
rt_all.train.int  = helper_compute_rt(allData,'train','int');

%% compute overall rt at test
rt_all.test.b200  = helper_compute_rt(allData,'test','b200');
rt_all.test.b20  = helper_compute_rt(allData, 'test','b20');
rt_all.test.b2  = helper_compute_rt(allData,  'test','b2');
rt_all.test.int  = helper_compute_rt(allData, 'test','int');

%% compute task switch vs task stay rt
rt_all.test_taskSwitchVsStay.b200 = helper_compute_taskSwitchstayRT(allData,'b200');
rt_all.test_taskSwitchVsStay.b20  = helper_compute_taskSwitchstayRT(allData,'b20' );
rt_all.test_taskSwitchVsStay.b2   = helper_compute_taskSwitchstayRT(allData,'b2'  );
rt_all.test_taskSwitchVsStay.int  = helper_compute_taskSwitchstayRT(allData,'int' );

%% compute response switch vs response stay rt
rt_all.test_responseSwitchVsStay.b200 = helper_compute_responseSwitchStayRT(allData,'b200');
rt_all.test_responseSwitchVsStay.b20  = helper_compute_responseSwitchStayRT(allData,'b20' );
rt_all.test_responseSwitchVsStay.b2   = helper_compute_responseSwitchStayRT(allData,'b2'  );
rt_all.test_responseSwitchVsStay.int  = helper_compute_responseSwitchStayRT(allData,'int' );


%% compute task vs response switch and stay rt (4x4 grid)
rt_all.test_taskAndresponseSwitchVsStay.b200 = helper_compute_taskAndresponseSwitchStayRT(allData,'b200');
rt_all.test_taskAndresponseSwitchVsStay.b20  = helper_compute_taskAndresponseSwitchStayRT(allData,'b20' );
rt_all.test_taskAndresponseSwitchVsStay.b2   = helper_compute_taskAndresponseSwitchStayRT(allData,'b2'  );
rt_all.test_taskAndresponseSwitchVsStay.int  = helper_compute_taskAndresponseSwitchStayRT(allData,'int' );


%% compute first vs second task rt
rt_all.test_firstVsSecond.b200 = helper_compute_firstVsSecondRT(allData,'b200');
rt_all.test_firstVsSecond.b20  = helper_compute_firstVsSecondRT(allData,'b20');
rt_all.test_firstVsSecond.b2   = helper_compute_firstVsSecondRT(allData,'b2');
rt_all.test_firstVsSecond.int  = helper_compute_firstVsSecondRT(allData,'int');

end


function rt_all =  helper_compute_rt(allData,phaseCode,subGroup)

switch subGroup
	case 'int'
		subIDs = find(allData.subCodes(1,:) == 3);
	case 'b200'
		subIDs = find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==200);
	case 'b20'
		subIDs =  find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==20);
	case 'b2'
		subIDs =   find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==2);
end

snum = 1;
for subj = subIDs
	rtAll    =         (allData.resp_reactiontime(:,subj)-0.5).*1000;
	% remove trials with timeouts
	timeOuts = find(allData.resp_reactiontime(:,subj)>5);
	rtAll(timeOuts) =       NaN;


	if strcmp(phaseCode,'train')
		rtVect = rtAll(1:400);
		taskVect = allData.expt_contextIDX(1:400,subj);
	elseif strcmp(phaseCode,'test')
		rtVect = rtAll(401:end);
		taskVect = allData.expt_contextIDX(401:end,subj);
	end

	% extract stay vector
	rt_all(snum,:)= nanmean(rtVect);
	snum = snum+1;

end
% compute reciprocal rt:
%rt_all = 1./rt_all;
end



function rt_all = helper_compute_taskSwitchstayRT(allData,subGroup)

switch subGroup
	case 'int'
		subIDs = find(allData.subCodes(1,:) == 3);
	case 'b200'
		subIDs = find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==200);
	case 'b20'
		subIDs =  find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==20);
	case 'b2'
		subIDs =   find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==2);
end

snum = 1;
for subj = subIDs
	rtAll    =         (allData.resp_reactiontime(:,subj)-0.5).*1000;
	% remove trials with timeouts
	timeOuts = find(allData.resp_reactiontime(:,subj)>5);
	rtAll(timeOuts) =   NaN;
	rtVect = rtAll(401:end);

	taskVect = allData.expt_contextIDX(401:end,subj);

	% obtain switch vs stay vector (predictor)
	x_switchStay = ones(length(taskVect),1);
	x_switchStay(taskVect~=circshift(taskVect,1),1) = -1;  % if t_(n) != t_(n-1), set to -1

	% delete very first trial, as it doesn't have a predecessor
	x_switchStay(1)  = [];
	rtVect(1)        = [];

	% extract stay vector
	rt_all(snum,:,1) = nanmean(rtVect(x_switchStay==1));
	% extract switch vector
	rt_all(snum,:,2) = nanmean(rtVect(x_switchStay==-1));
	snum = snum+1;

end
% compute reciprocal rt
%rt_all = 1./rt_all;
end





function rt_all = helper_compute_responseSwitchStayRT(allData,subGroup)
	%
	% computes rt separately for response switch and response stay trials

	switch subGroup
		case 'int'
			subIDs = find(allData.subCodes(1,:) == 3);
		case 'b200'
			subIDs = find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==200);
		case 'b20'
			subIDs =  find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==20);
		case 'b2'
			subIDs =   find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==2);
	end

	snum = 1;
	for subj = subIDs
		rtAll    =         (allData.resp_reactiontime(:,subj)-0.5).*1000;
		% remove trials with timeouts
		timeOuts = find(allData.resp_reactiontime(:,subj)>5);
		rtAll(timeOuts) =   NaN;
		rtVect = rtAll(401:end);

		% response switches: extract test-phase category indicators (accept vs reject)
		catVect = allData.expt_catIDX(401:end,subj);

		% obtain switch vs stay vector (predictor)
		x_switchStay = ones(length(catVect),1);
		x_switchStay(catVect~=circshift(catVect,1),1) = -1; % if t_(n) != t_(n-1), set to -1
		x_switchStay(catVect==0 | circshift(catVect,1)==0) = NaN; % set zero boundary trials and their successors to nan as there was no correct/incorrect response (and thus response switch is meaningless)
		% delete very first trial, as it doesn't have a predecessor
		x_switchStay(1)  = [];
		rtVect(1) = [];

		% extract task stay vector and average rt, ignore boundary trials
		rt_all(snum,:,1) = nanmean(rtVect(x_switchStay==1));
		% extract task switch vector and average rt
		rt_all(snum,:,2) = nanmean(rtVect(x_switchStay==-1));
		snum = snum+1;

	end
end

function rt_all = helper_compute_taskAndresponseSwitchStayRT(allData,subGroup)
	%
	% computes rt separately for task/response switch/stay trials
	% (4x4 grid)

	switch subGroup
		case 'int'
			subIDs = find(allData.subCodes(1,:) == 3);
		case 'b200'
			subIDs = find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==200);
		case 'b20'
			subIDs =  find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==20);
		case 'b2'
			subIDs =   find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==2);
	end

	snum = 1;
	for subj = subIDs
		rtAll    =         (allData.resp_reactiontime(:,subj)-0.5).*1000;
		% remove trials with timeouts
		timeOuts = find(allData.resp_reactiontime(:,subj)>5);
		rtAll(timeOuts) =   NaN;
		rtVect = rtAll(401:end);

		% response switches: extract test-phase category indicators (accept vs reject)
		catVect = allData.expt_catIDX(401:end,subj);
		% task switches: extract test-phase task indicators  ( north vs south)
		taskVect = allData.expt_contextIDX(401:end,subj);

		% 1. task stay and response stay
		x_taskStayrespStay = zeros(length(catVect),1);
		x_taskStayrespStay(catVect==circshift(catVect,1) & taskVect==circshift(taskVect,1),1) = 1;
		x_taskStayrespStay(catVect==0 | circshift(catVect,1)==0) = NaN; % set zero boundary trials and their successors to nan as there was no correct/incorrect response (and thus response switch is meaningless)
		x_taskStayrespStay(1) = [];

		% 2. task stay and response switch
		x_taskStayrespSwitch = zeros(length(catVect),1);
		x_taskStayrespSwitch(catVect~=circshift(catVect,1) & taskVect==circshift(taskVect,1),1) = 1;
		x_taskStayrespSwitch(catVect==0 | circshift(catVect,1)==0) = NaN; % set zero boundary trials and their successors to nan as there was no correct/incorrect response (and thus response switch is meaningless)
		x_taskStayrespSwitch(1) = [];

		% 3. task switch and response stay
		x_taskSwitchrespStay = zeros(length(catVect),1);
		x_taskSwitchrespStay(catVect==circshift(catVect,1) & taskVect~=circshift(taskVect,1),1) = 1;
		x_taskSwitchrespStay(catVect==0 | circshift(catVect,1)==0) = NaN; % set zero boundary trials and their successors to nan as there was no correct/incorrect response (and thus response switch is meaningless)
		x_taskSwitchrespStay(1) = [];

		% 3. task switch and response switch
		x_taskSwitchrespSwitch = zeros(length(catVect),1);
		x_taskSwitchrespSwitch(catVect~=circshift(catVect,1) & taskVect~=circshift(taskVect,1),1) = 1;
		x_taskSwitchrespSwitch(catVect==0 | circshift(catVect,1)==0) = NaN; % set zero boundary trials and their successors to nan as there was no correct/incorrect response (and thus response switch is meaningless)
		x_taskSwitchrespSwitch(1) = [];


		% delete very first trial, as it doesn't have a predecessor
		rtVect(1) = [];

		% average accuracies
		rt_all(snum,:,1) = nanmean(rtVect(x_taskStayrespStay==1));
		rt_all(snum,:,2) = nanmean(rtVect(x_taskStayrespSwitch==1));
		rt_all(snum,:,3) = nanmean(rtVect(x_taskSwitchrespStay==1));
		rt_all(snum,:,4) = nanmean(rtVect(x_taskSwitchrespSwitch==1));

		snum = snum+1;

	end
end

function rt_all = helper_compute_firstVsSecondRT(allData,subGroup)
	%
	% computes test rt for first and second task in isolation
	% first task: task that was trained first (e.g. on first trial and consecutive ones)
	% second task: guess ..

	switch subGroup
		case 'int'
			subIDs = find(allData.subCodes(1,:) == 3);
		case 'b200'
			subIDs = find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==200);
		case 'b20'
			subIDs =  find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==20);
		case 'b2'
			subIDs =   find(allData.subCodes(1,:) ~= 3 & allData.subCodes(5,:)==2);
	end

	snum = 1;
	for subj = subIDs

		rtAll    =         (allData.resp_reactiontime(:,subj)-0.5).*1000;
		% remove trials with timeouts
		timeOuts = find(allData.resp_reactiontime(:,subj)>5);
		rtAll(timeOuts) =   NaN;
		rtVect = rtAll(401:end);

		firstTask = allData.expt_block(1,subj) == allData.expt_contextIDX(1,subj); % 1 if first task leaf, 0 ow
		if firstTask
			taskVect = allData.expt_contextIDX(401:end,subj);
		else
			% if first task was branch task, switch labels
			tmp = allData.expt_contextIDX(401:end,subj);
			taskVect = tmp;

			taskVect(tmp==1) = 2;
			taskVect(tmp==2) = 1;
		end
		% now, taskVect contains labels for first and second task (instead of being linked to dimensions)
		rt_all(snum,:,1) = nanmean(rtVect(taskVect==1));
		rt_all(snum,:,2) = nanmean(rtVect(taskVect==2));

		snum = snum +1;
	end

end

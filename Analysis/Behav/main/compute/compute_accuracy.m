function acc_all = compute_accuracy(goodData)
	%% ACC_ALL = COMPUTE_ACCURACY(GOODDATA)
	%
	% computes mean accuracy for training and test, and for switch vs stay at test
	%
	% (c) Timo Flesch, 2017

	%% init data structs
	acc_all                   = struct();
	acc_all.train             = struct();
	acc_all.test              = struct();
	acc_all.test_switchVsStay = struct();

	% learning curves
	acc = compute_pcorrect_learningCurves(goodData,0);


	%% compute overall accuracy during training
	acc_all.train.b200  = nanmean(acc.pMatBlock200(1:400,:),1);
	% acc_all.train.b20   = nanmean(acc.pMatBlock20(1:400,:),1);
	% acc_all.train.b2    = nanmean(acc.pMatBlock2(1:400,:),1);
	acc_all.train.int   = nanmean(acc.pMatInt(1:400,:),1);

	%% compute overall accuracy at test
	acc_all.test.b200  = nanmean(acc.pMatBlock200(401:end,:),1);
	% acc_all.test.b20   = nanmean(acc.pMatBlock20(401:end,:),1);
	% acc_all.test.b2    = nanmean(acc.pMatBlock2(401:end,:),1);
	acc_all.test.int   = nanmean(acc.pMatInt(401:end,:),1);

	%% compute task switch vs task stay accuracy
	acc_all.test_taskSwitchVsStay.b200 = helper_compute_taskSwitchStayAcc(goodData,'b200');
	% acc_all.test_taskSwitchVsStay.b20  = helper_compute_taskSwitchStayAcc(goodData,'b20' );
	% acc_all.test_taskSwitchVsStay.b2   = helper_compute_taskSwitchStayAcc(goodData,'b2'  );
	acc_all.test_taskSwitchVsStay.int  = helper_compute_taskSwitchStayAcc(goodData,'int' );

	%%  compute response switch vs response stay accuracy
	acc_all.test_responseSwitchVsStay.b200 = helper_compute_responseSwitchStayAcc(goodData,'b200');
	% acc_all.test_responseSwitchVsStay.b20  = helper_compute_responseSwitchStayAcc(goodData,'b20' );
	% acc_all.test_responseSwitchVsStay.b2   = helper_compute_responseSwitchStayAcc(goodData,'b2'  );
	acc_all.test_responseSwitchVsStay.int  = helper_compute_responseSwitchStayAcc(goodData,'int' );

	%%  compute task vs response switch and stay accuracy (4x4 grid)
	acc_all.test_taskAndresponseSwitchVsStay.b200 = helper_compute_taskAndresponseSwitchStayAcc(goodData,'b200');
	% acc_all.test_taskAndresponseSwitchVsStay.b20  = helper_compute_taskAndresponseSwitchStayAcc(goodData,'b20' );
	% acc_all.test_taskAndresponseSwitchVsStay.b2   = helper_compute_taskAndresponseSwitchStayAcc(goodData,'b2'  );
	acc_all.test_taskAndresponseSwitchVsStay.int  = helper_compute_taskAndresponseSwitchStayAcc(goodData,'int' );

	%% compute first vs second task accuracy
	acc_all.test_firstVsSecond.b200 = helper_compute_firstVsSecondAcc(goodData,'b200');
	% acc_all.test_firstVsSecond.b20  = helper_compute_firstVsSecondAcc(goodData,'b20');
	% acc_all.test_firstVsSecond.b2   = helper_compute_firstVsSecondAcc(goodData,'b2');
	acc_all.test_firstVsSecond.int  = helper_compute_firstVsSecondAcc(goodData,'int');

end



function acc_all = helper_compute_taskSwitchStayAcc(goodData,subGroup)
	%
	% computes accuracy separately for task switch and task stay trials

	switch subGroup
		case 'int'
			subIDs = find(goodData.subCodes(1,:) == 3);
		case 'b200'
			subIDs = find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==200);
		case 'b20'
			subIDs =  find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==20);
		case 'b2'
			subIDs =   find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==2);
	end

	snum = 1;
	for subj = subIDs
		catZero  =      find(goodData.expt_catIDX(:,subj)==0);
		corrAll  =              goodData.resp_correct(:,subj);
		corrCat  =                                   corrAll;
		timeOuts = find(goodData.resp_reactiontime(:,subj)>5);

		% treat time-outs as incorrect trials
		corrCat(timeOuts) =       0;
		% treat boundary trials as missing data ( no correct response possible..)
		corrCat(catZero)  =     NaN;

		% extract test-phase accuracy
		accVect = corrCat(401:end);

		% task switches: extract test-phase task indicators
		taskVect = goodData.expt_contextIDX(401:end,subj);

		% obtain switch vs stay vector (predictor)
		x_switchStay = ones(length(taskVect),1);
		x_switchStay(taskVect~=circshift(taskVect,1),1) = -1; % if t_(n) != t_(n-1), set to -1

		% delete very first trial, as it doesn't have a predecessor
		x_switchStay(1)  = [];
		accVect(1) = [];

		% extract task stay vector and average accuracy
		acc_all(snum,:,1) = nanmean(accVect(x_switchStay==1));
		% extract task switch vector and average accuracy
		acc_all(snum,:,2) = nanmean(accVect(x_switchStay==-1));
		snum = snum+1;

	end
end


function acc_all = helper_compute_responseSwitchStayAcc(goodData,subGroup)
	%
	% computes accuracy separately for response switch and response stay trials

	switch subGroup
		case 'int'
			subIDs = find(goodData.subCodes(1,:) == 3);
		case 'b200'
			subIDs = find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==200);
		case 'b20'
			subIDs =  find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==20);
		case 'b2'
			subIDs =   find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==2);
	end

	snum = 1;
	for subj = subIDs
		catZero  =      find(goodData.expt_catIDX(:,subj)==0);
		corrAll  =              goodData.resp_correct(:,subj);
		corrCat  =                                   corrAll;
		timeOuts = find(goodData.resp_reactiontime(:,subj)>5);

		% treat time-outs as incorrect trials
		corrCat(timeOuts) =       0;
		% treat boundary trials as missing data ( no correct response possible..)
		corrCat(catZero)  =     NaN;

		% extract test-phase accuracy
		accVect = corrCat(401:end);

		% response switches: extract test-phase category indicators (accept vs reject)
		catVect = goodData.expt_catIDX(401:end,subj);

		% obtain switch vs stay vector (predictor)
		x_switchStay = ones(length(catVect),1);
		x_switchStay(catVect~=circshift(catVect,1),1) = -1; % if t_(n) != t_(n-1), set to -1
		x_switchStay(catVect==0 | circshift(catVect,1)==0) = NaN; % set zero boundary trials and their successors to nan as there was no correct/incorrect response (and thus response switch is meaningless)
		% delete very first trial, as it doesn't have a predecessor
		x_switchStay(1)  = [];
		accVect(1) = [];

		% extract task stay vector and average accuracy, ignore boundary trials
		acc_all(snum,:,1) = nanmean(accVect(x_switchStay==1));
		% extract task switch vector and average accuracy
		acc_all(snum,:,2) = nanmean(accVect(x_switchStay==-1));
		snum = snum+1;

	end
end

function acc_all = helper_compute_taskAndresponseSwitchStayAcc(goodData,subGroup)
	%
	% computes accuracy separately for task/response switch/stay trials
	% (4x4 grid)

	switch subGroup
		case 'int'
			subIDs = find(goodData.subCodes(1,:) == 3);
		case 'b200'
			subIDs = find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==200);
		case 'b20'
			subIDs =  find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==20);
		case 'b2'
			subIDs =   find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==2);
	end

	snum = 1;
	for subj = subIDs
		catZero  =      find(goodData.expt_catIDX(:,subj)==0);
		corrAll  =              goodData.resp_correct(:,subj);
		corrCat  =                                   corrAll;
		timeOuts = find(goodData.resp_reactiontime(:,subj)>5);

		% treat time-outs as incorrect trials
		corrCat(timeOuts) =       0;
		% treat boundary trials as missing data ( no correct response possible..)
		corrCat(catZero)  =     NaN;

		% extract test-phase accuracy
		accVect = corrCat(401:end);

		% response switches: extract test-phase category indicators (accept vs reject)
		catVect = goodData.expt_catIDX(401:end,subj);
		% task switches: extract test-phase task indicators  ( north vs south)
		taskVect = goodData.expt_contextIDX(401:end,subj);

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
		accVect(1) = [];

		% average accuracies
		acc_all(snum,:,1) = nanmean(accVect(x_taskStayrespStay==1));
		acc_all(snum,:,2) = nanmean(accVect(x_taskStayrespSwitch==1));
		acc_all(snum,:,3) = nanmean(accVect(x_taskSwitchrespStay==1));
		acc_all(snum,:,4) = nanmean(accVect(x_taskSwitchrespSwitch==1));

		snum = snum+1;

	end
end

function acc_all = helper_compute_firstVsSecondAcc(goodData,subGroup)
	%
	% computes test accuracy for first and second task in isolation
	% first task: task that was trained first (e.g. on first trial and consecutive ones)
	% second task: guess ..

	switch subGroup
		case 'int'
			subIDs = find(goodData.subCodes(1,:) == 3);
		case 'b200'
			subIDs = find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==200);
		case 'b20'
			subIDs =  find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==20);
		case 'b2'
			subIDs =   find(goodData.subCodes(1,:) ~= 3 & goodData.subCodes(5,:)==2);
	end

	snum = 1;
	for subj = subIDs

		catZero  =      find(goodData.expt_catIDX(:,subj)==0);
		corrAll  =              goodData.resp_correct(:,subj);
		corrCat  =                                    corrAll;
		timeOuts = find(goodData.resp_reactiontime(:,subj)>5);

		corrCat(timeOuts) =       0;
		corrCat(catZero)  =     NaN;

		accVect = corrCat(401:end);

		firstTask = goodData.expt_block(1,subj) == goodData.expt_contextIDX(1,subj); % 1 if first task leaf, 0 ow
		if firstTask
			taskVect = goodData.expt_contextIDX(401:end,subj);
		else
			% if first task was branch task, switch labels
			tmp = goodData.expt_contextIDX(401:end,subj);
			taskVect = tmp;

			taskVect(tmp==1) = 2;
			taskVect(tmp==2) = 1;
		end
		% now, taskVect contains labels for first and second task (instead of being linked to dimensions)
		acc_all(snum,:,1) = nanmean(accVect(taskVect==1));
		acc_all(snum,:,2) = nanmean(accVect(taskVect==2));

		snum = snum +1;
	end

end

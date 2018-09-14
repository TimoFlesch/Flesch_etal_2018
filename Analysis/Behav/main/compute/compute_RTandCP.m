function results = compute_RTandCP(rsData)
%% compute_RTandCP(RSDATA)
%
% worst piece of code I've ever written, but it does the trick.
% computes RTs and choice fractions as function of the feature values
%
% (C) Timo Flesch, 2017


results = struct();
idB200  = 1;
idB20   = 1;
idB2    = 1;
idInt   = 1;

rewVals = [-50:25:50];
results = struct();
subj = 0;

for subID = 1:length(rsData)
        % extract data sets
        dataTrain = rsData(subID).data(1:400,:);
        dataTest  = rsData(subID).data(401:600,:);

        % set subject index
        if(rsData(subID).code(1)==3)
            subj = idInt;
            idInt = idInt+1;

            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);
                % RT TRAIN as function of reward in relevant dimension
                results.rt.train.rel.int(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,11));
                % RT TEST as function of reward in relevant dimension
                results.rt.test.rel.int(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,11));
                % Choice TRAIN as function of reward in relevant dimension
                results.choice.train.rel.int(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,8));
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.int(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,8));
            end

            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);
                % RT TRAIN as function of reward in irrelevant dimension
                results.rt.train.irrel.int(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,11));
                % RT TEST as function of reward in irrelevant dimension
                results.rt.test.irrel.int(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,11));
                % Choice TRAIN as function of reward in irrelevant dimension
                results.choice.train.irrel.int(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,8));
                % Choice TEST as function of reward in irrelevant dimension
                results.choice.test.irrel.int(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,8));
            end

         % BOTH DIMENSIONS
	    for leafID = 1:5
		    for branchID = 1:5
			tmp_train_north(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==1 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_train_south(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==2 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_test_north(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==1 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
			tmp_test_south(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==2 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
		    end
	    end
	    results.choicematrix.train.north.int(subj,:,:) = helper_alignMatrices(tmp_train_north,rsData(subID).code(end),'north');
	    results.choicematrix.train.south.int(subj,:,:) = helper_alignMatrices(tmp_train_south,rsData(subID).code(end),'south');
	    results.choicematrix.test.north.int(subj,:,:) = helper_alignMatrices(tmp_test_north,rsData(subID).code(end),'north');
	    results.choicematrix.test.south.int(subj,:,:) = helper_alignMatrices(tmp_test_south,rsData(subID).code(end),'south');

        % single trials
        results.singleTrials.train.north.int.data(subj,:,:) = dataTrain(dataTrain(:,3)==1,[4,5,8,12,14]);
        results.singleTrials.train.north.int.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.train.north.int.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.train.south.int.data(subj,:,:) = dataTrain(dataTrain(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.train.south.int.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.train.south.int.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.north.int.data(subj,:,:) = dataTest(dataTest(:,3)==1,[4,5,8,12,14]);
        results.singleTrials.test.north.int.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.test.north.int.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.south.int.data(subj,:,:) = dataTest(dataTest(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.test.south.int.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.test.south.int.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');



        elseif rsData(subID).code(5)==200
            subj = idB200;
            idB200 = idB200+1;

            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);
                % RT TRAIN as function of reward in relevant dimension
                results.rt.train.rel.b200(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,11));
                % RT TEST as function of reward in relevant dimension
                results.rt.test.rel.b200(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,11));
                % Choice TRAIN as function of reward in relevant dimension
                results.choice.train.rel.b200(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,8));
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.b200(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,8));
            end

            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);
                % RT TRAIN as function of reward in irrelevant dimension
                results.rt.train.irrel.b200(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,11));
                % RT TEST as function of reward in irrelevant dimension
                results.rt.test.irrel.b200(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,11));
                % Choice TRAIN as function of reward in irrelevant dimension
                results.choice.train.irrel.b200(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,8));
                % Choice TEST as function of reward in irrelevant dimension
                results.choice.test.irrel.b200(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,8));
            end

            % BOTH DIMENSIONS
	    for leafID = 1:5
		    for branchID = 1:5
			tmp_train_north(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==1 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_train_south(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==2 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_test_north(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==1 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
			tmp_test_south(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==2 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
		    end
	    end
	    results.choicematrix.train.north.b200(subj,:,:) = helper_alignMatrices(tmp_train_north,rsData(subID).code(end),'north');
	    results.choicematrix.train.south.b200(subj,:,:) = helper_alignMatrices(tmp_train_south,rsData(subID).code(end),'south');
	    results.choicematrix.test.north.b200(subj,:,:) = helper_alignMatrices(tmp_test_north,rsData(subID).code(end),'north');
	    results.choicematrix.test.south.b200(subj,:,:) = helper_alignMatrices(tmp_test_south,rsData(subID).code(end),'south');

        % single trials
       results.singleTrials.train.north.b200.data(subj,:,:) = dataTrain(dataTrain(:,3)==1,[4,5,8,12,14]); %leaf,branch,response,rew_rel,rew_irrel
        results.singleTrials.train.north.b200.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.train.north.b200.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.train.south.b200.data(subj,:,:) = dataTrain(dataTrain(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.train.south.b200.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.train.south.b200.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.north.b200.data(subj,:,:) = dataTest(dataTest(:,3)==1,[4,5,8,12,14]);
        results.singleTrials.test.north.b200.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.test.north.b200.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.south.b200.data(subj,:,:) = dataTest(dataTest(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.test.south.b200.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.test.south.b200.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');


        elseif rsData(subID).code(5)==20
            subj = idB20;
            idB20 = idB20+1;


            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);
                % RT TRAIN as function of reward in relevant dimension
                results.rt.train.rel.b20(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,11));
                % RT TEST as function of reward in relevant dimension
                results.rt.test.rel.b20(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,11));
                % Choice TRAIN as function of reward in relevant dimension
                results.choice.train.rel.b20(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,8));
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.b20(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,8));
            end

            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);
                % RT TRAIN as function of reward in irrelevant dimension
                results.rt.train.irrel.b20(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,11));
                % RT TEST as function of reward in irrelevant dimension
                results.rt.test.irrel.b20(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,11));
                % Choice TRAIN as function of reward in irrelevant dimension
                results.choice.train.irrel.b20(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,8));
                % Choice TEST as function of reward in irrelevant dimension
                results.choice.test.irrel.b20(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,8));
            end

            % BOTH DIMENSIONS
	    for leafID = 1:5
		    for branchID = 1:5
			tmp_train_north(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==1 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_train_south(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==2 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_test_north(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==1 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
			tmp_test_south(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==2 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
		    end
	    end
	    results.choicematrix.train.north.b20(subj,:,:) = helper_alignMatrices(tmp_train_north,rsData(subID).code(end),'north');
	    results.choicematrix.train.south.b20(subj,:,:) = helper_alignMatrices(tmp_train_south,rsData(subID).code(end),'south');
	    results.choicematrix.test.north.b20(subj,:,:) = helper_alignMatrices(tmp_test_north,rsData(subID).code(end),'north');
	    results.choicematrix.test.south.b20(subj,:,:) = helper_alignMatrices(tmp_test_south,rsData(subID).code(end),'south');

        % single trials
        results.singleTrials.train.north.b20.data(subj,:,:) = dataTrain(dataTrain(:,3)==1,[4,5,8,12,14]);
        results.singleTrials.train.north.b20.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.train.north.b20.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.train.south.b20.data(subj,:,:) = dataTrain(dataTrain(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.train.south.b20.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.train.south.b20.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.north.b20.data(subj,:,:) = dataTest(dataTest(:,3)==1,[4,5,8,12,14]);
        results.singleTrials.test.north.b20.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.test.north.b20.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.south.b20.data(subj,:,:) = dataTest(dataTest(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.test.south.b20.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.test.south.b20.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');

        elseif rsData(subID).code(5)==2
            subj = idB2;
            idB2 = idB2+1;

            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);
                % RT TRAIN as function of reward in relevant dimension
                results.rt.train.rel.b2(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,11));
                % RT TEST as function of reward in relevant dimension
                results.rt.test.rel.b2(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,11));
                % Choice TRAIN as function of reward in relevant dimension
                results.choice.train.rel.b2(subj,rewRelID) = nanmean(dataTrain(dataTrain(:,7)==thisRew,8));
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.b2(subj,rewRelID) = nanmean(dataTest(dataTest(:,7)==thisRew,8));
            end

            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);
                % RT TRAIN as function of reward in irrelevant dimension
                results.rt.train.irrel.b2(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,11));
                % RT TEST as function of reward in irrelevant dimension
                results.rt.test.irrel.b2(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,11));
                % Choice TRAIN as function of reward in irrelevant dimension
                results.choice.train.irrel.b2(subj,rewIrrelID) = nanmean(dataTrain(dataTrain(:,14)==thisRew,8));
                % Choice TEST as function of reward in irrelevant dimension
                results.choice.test.irrel.b2(subj,rewIrrelID) = nanmean(dataTest(dataTest(:,14)==thisRew,8));
            end

            % BOTH DIMENSIONS
	    for leafID = 1:5
		    for branchID = 1:5
			tmp_train_north(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==1 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_train_south(leafID,branchID) =  squeeze(nanmean(dataTrain(dataTrain(:,3)==2 & dataTrain(:,4)==leafID & dataTrain(:,5)==branchID,8)));
			tmp_test_north(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==1 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
			tmp_test_south(leafID,branchID) =  squeeze(nanmean(dataTest(dataTest(:,3)==2 & dataTest(:,4)==leafID & dataTest(:,5)==branchID,8)));
		    end
	    end
	    results.choicematrix.train.north.b2(subj,:,:) = helper_alignMatrices(tmp_train_north,rsData(subID).code(end),'north');
	    results.choicematrix.train.south.b2(subj,:,:) = helper_alignMatrices(tmp_train_south,rsData(subID).code(end),'south');
	    results.choicematrix.test.north.b2(subj,:,:) = helper_alignMatrices(tmp_test_north,rsData(subID).code(end),'north');
	    results.choicematrix.test.south.b2(subj,:,:) = helper_alignMatrices(tmp_test_south,rsData(subID).code(end),'south');

        % single trials
        results.singleTrials.train.north.b2.data(subj,:,:) = dataTrain(dataTrain(:,3)==1,[4,5,8,12,14]);
        results.singleTrials.train.north.b2.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.train.north.b2.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.train.south.b2.data(subj,:,:) = dataTrain(dataTrain(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.train.south.b2.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.train.south.b2.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.north.b2.data(subj,:,:) = dataTest(dataTest(:,3)==1,[4,5,8,12,14]);
        results.singleTrials.test.north.b2.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'north');
        results.singleTrials.test.north.b2.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        results.singleTrials.test.south.b2.data(subj,:,:) = dataTest(dataTest(:,3)==2,[4,5,8,12,14]);
        results.singleTrials.test.south.b2.bound(subj)  = helper_setOptimBounds(rsData(subID).code(end),'south');
        results.singleTrials.test.south.b2.diag(subj)  = helper_setOptimBounds(rsData(subID).code(end),'diag');
        end

end

end
function optimBound = helper_setOptimBounds(code,garden)
    optimBound = 0;
    switch code
    case 1
        if strcmp(garden,'north')
            optimBound = 180;
        elseif strcmp(garden,'south')
            optimBound = 90;
        elseif strcmp(garden,'diag')
            optimBound = 135;
        end
    case 2
        if strcmp(garden,'north')
            optimBound = 0;
        elseif strcmp(garden,'south')
            optimBound = 270;
        elseif strcmp(garden,'diag')
            optimBound = 315;
        end
    case 3
        if strcmp(garden,'north')
            optimBound = 0;
        elseif strcmp(garden,'south')
            optimBound = 90;
        elseif strcmp(garden,'diag')
            optimBound = 45;
        end
    case 4
        if strcmp(garden,'north')
            optimBound = 180;
        elseif strcmp(garden,'south')
            optimBound = 270;
        elseif strcmp(garden,'diag')
            optimBound = 225;
        end
    case 5
        if strcmp(garden,'north')
            optimBound = 135;
        elseif strcmp(garden,'south')
            optimBound = 45;
        elseif strcmp(garden,'diag')
            optimBound = 90;
        end
    case 6
        if strcmp(garden,'north')
            optimBound = 315;
        elseif strcmp(garden,'south')
            optimBound = 225;
        elseif strcmp(garden,'diag')
            optimBound = 270;
        end
    case 7
        if strcmp(garden,'north')
            optimBound = 315;
        elseif strcmp(garden,'south')
            optimBound = 45;
        elseif strcmp(garden,'diag')
            optimBound = 0;
        end
    case 8
        if strcmp(garden,'north')
            optimBound = 135;
        elseif strcmp(garden,'south')
            optimBound = 225;
        elseif strcmp(garden,'diag')
            optimBound = 180;
        end
    end


end


function outMat = helper_alignMatrices(inMat,code,garden)
%% HELPER_ALIGNMATRICES(INMAT,CODE,GARDEN)
%
% aligns all matrices of trees task to have same frame of reference
%
% input:
%	- inMat:   matrix to manipulate
%	- code:    code of reward assignment schema (1 to 8)
% 	- garden: 'north' or 'south'
%
% Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, University of Oxford

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
		if strcmp(garden,'north')
			outMat = flipud(inMat);
		elseif strcmp(garden,'south')
			outMat = flipud(inMat);
		end

	case 4
		% cardinal high low
		if strcmp(garden,'north')
			outMat = fliplr(inMat);
		elseif strcmp(garden,'south')
			outMat = fliplr(inMat);
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

	case 7
		% diagonal low high
		if strcmp(garden,'north')
			outMat = fliplr(rot90(inMat,1));
		elseif strcmp(garden,'south')
			outMat = fliplr(rot90(inMat,1));
		end
	case 8
		% diagonal high low
		if strcmp(garden,'north')
			outMat = flipud(rot90(inMat,1));
		elseif strcmp(garden,'south')
			outMat = flipud(rot90(inMat,1));
		end

end

end

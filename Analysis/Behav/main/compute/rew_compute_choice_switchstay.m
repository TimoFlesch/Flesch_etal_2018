function results = rew_compute_choice_switchstay(rsData)
	%% RESULTS = REW_COMPUTE_CHOICE_SWITCHSTAY(RSDATA)
	%
	% computes choice probabilities independently for switch and stay trials
	% distinguishes between task switch and response switch trials
	% slightly redundant code that does the trick
	%
	% Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	results = struct();
	idB200  = 1;
	idB20   = 1;
	idB2    = 1;
	idInt   = 1;

	rewVals = [-50:25:50];	
	subj = 0;

	for subID = 1:length(rsData)

		% whole data vector
        dataTest  = rsData(subID).data(401:600,:);
        % task vector
        taskVect = rsData(subID).data(401:600,3);
        % response vector	
        catVect = rsData(subID).data(401:600,6);

        % switchstay vectors
        task_switchstay = ones(200,1);
        task_switchstay(taskVect~=circshift(taskVect,1)) = -1;
        resp_switchstay = ones(200,1);
        resp_switchstay(catVect~=circshift(catVect,1)) = -1;	        
        dataTest(1,:) = [];
        task_switchstay(1) = [];
        resp_switchstay(1) = [];

        % task stay
        dataTaskStay   =  dataTest(task_switchstay==1,:);
        % task switch
        dataTaskSwitch = dataTest(task_switchstay==-1,:);

        % response stay 
        dataRespStay     =  dataTest(resp_switchstay==1,:);
        % response switch
        dataRespSwitch   = dataTest(resp_switchstay==-1,:);


        % set subject index
        if(rsData(subID).code(1)==3)
            subj = idInt;
            idInt = idInt+1;
        
            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);
            
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.int(subj,1,rewRelID) =      nanmean(dataTaskStay(dataTaskStay(:,7)==thisRew,8));
                results.choice.test.rel.int(subj,2,rewRelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,7)==thisRew,8));
                results.choice.test.rel.int(subj,3,rewRelID) =      nanmean(dataRespStay(dataRespStay(:,7)==thisRew,8));
                results.choice.test.rel.int(subj,4,rewRelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,7)==thisRew,8));
            end
            
            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);
                % Choice TEST as function of reward in irrelevant dimension
               	results.choice.test.irrel.int(subj,1,rewIrrelID) =      nanmean(dataTaskStay(dataTaskStay(:,14)==thisRew,8));
                results.choice.test.irrel.int(subj,2,rewIrrelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,14)==thisRew,8));
                results.choice.test.irrel.int(subj,3,rewIrrelID) =      nanmean(dataRespStay(dataRespStay(:,14)==thisRew,8));
                results.choice.test.irrel.int(subj,4,rewIrrelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,14)==thisRew,8));
            end
           
                
        elseif rsData(subID).code(5)==200
            subj = idB200;
            idB200 = idB200+1;
        
            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.b200(subj,1,rewRelID) =      nanmean(dataTaskStay(dataTaskStay(:,7)==thisRew,8));
                results.choice.test.rel.b200(subj,2,rewRelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,7)==thisRew,8));
                results.choice.test.rel.b200(subj,3,rewRelID) =      nanmean(dataRespStay(dataRespStay(:,7)==thisRew,8));
                results.choice.test.rel.b200(subj,4,rewRelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,7)==thisRew,8));
            end
            
            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);          
                % Choice TEST as function of reward in irrelevant dimension
                results.choice.test.irrel.b200(subj,1,rewIrrelID) =      nanmean(dataTaskStay(dataTaskStay(:,14)==thisRew,8));
                results.choice.test.irrel.b200(subj,2,rewIrrelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,14)==thisRew,8));
                results.choice.test.irrel.b200(subj,3,rewIrrelID) =      nanmean(dataRespStay(dataRespStay(:,14)==thisRew,8));
                results.choice.test.irrel.b200(subj,4,rewIrrelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,14)==thisRew,8));

            end
                        
        elseif rsData(subID).code(5)==20
            subj = idB20;
            idB20 = idB20+1;
        
        
            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);   
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.b20(subj,1,rewRelID) =      nanmean(dataTaskStay(dataTaskStay(:,7)==thisRew,8));
                results.choice.test.rel.b20(subj,2,rewRelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,7)==thisRew,8));
                results.choice.test.rel.b20(subj,3,rewRelID) =      nanmean(dataRespStay(dataRespStay(:,7)==thisRew,8));
                results.choice.test.rel.b20(subj,4,rewRelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,7)==thisRew,8));
            end
            
            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);   
                % Choice TEST as function of reward in irrelevant dimension
                results.choice.test.irrel.b20(subj,1,rewIrrelID) =      nanmean(dataTaskStay(dataTaskStay(:,14)==thisRew,8));
				results.choice.test.irrel.b20(subj,2,rewIrrelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,14)==thisRew,8));
				results.choice.test.irrel.b20(subj,3,rewIrrelID) =      nanmean(dataRespStay(dataRespStay(:,14)==thisRew,8));
				results.choice.test.irrel.b20(subj,4,rewIrrelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,14)==thisRew,8));
            end

        elseif rsData(subID).code(5)==2
            subj = idB2;
            idB2 = idB2+1;
        
            % RELEVANT DIMENSION
            for rewRelID =  1:5
                thisRew = rewVals(rewRelID);   
                % Choice TEST as function of reward in relevant dimension
                results.choice.test.rel.b2(subj,1,rewRelID) =      nanmean(dataTaskStay(dataTaskStay(:,7)==thisRew,8));
                results.choice.test.rel.b2(subj,2,rewRelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,7)==thisRew,8));
                results.choice.test.rel.b2(subj,3,rewRelID) =      nanmean(dataRespStay(dataRespStay(:,7)==thisRew,8));
                results.choice.test.rel.b2(subj,4,rewRelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,7)==thisRew,8));
            end
            
            % IRRELEVANT DIMENSION
            for rewIrrelID = 1:5
                thisRew = rewVals(rewIrrelID);   
                % Choice TEST as function of reward in irrelevant dimension
                results.choice.test.irrel.b2(subj,1,rewIrrelID) =      nanmean(dataTaskStay(dataTaskStay(:,14)==thisRew,8));
				results.choice.test.irrel.b2(subj,2,rewIrrelID) = nanmean(dataTaskSwitch(dataTaskSwitch(:,14)==thisRew,8));
				results.choice.test.irrel.b2(subj,3,rewIrrelID) =      nanmean(dataRespStay(dataRespStay(:,14)==thisRew,8));
				results.choice.test.irrel.b2(subj,4,rewIrrelID) =  nanmean(dataRespSwitch(dataRespSwitch(:,14)==thisRew,8));
            end

        end
        
    end

end
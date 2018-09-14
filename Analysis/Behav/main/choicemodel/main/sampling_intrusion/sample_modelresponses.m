function modelsamples = sample_modelresponses(modelfits,boundaryName)
	%% SAMPLE_MODELRESPONSES(MODELPARAMS,BOUNDARYNAME)
	%
	% for each subject, this function generates synthetic choice data
	% by sampling n trials from a model initialised with the subject-specific
	% best-fitting parameters
	%
	% uses eight-parameter model (twoBoundsAndSigmoids)
	% 
	% INPUTS:
	% - modelfits: struct with best fitting model parameters
	% - boundaryName: 'cardinal' or 'diagonal'
	%
	% OUTPUTS:
	% - results: struct with model choices and reward values (rel/irrel dims)
	%
	% Timo Flesch, 2018
	modelsamples = struct();

	if ~exist('boundaryName')
		boundaryName = 'cardinal';
	end
	groups  = {'b200','b20','b2','int'};	
	results =                  struct();
	numReps =                        40; % x*25 trials


	for gg = 1:length(groups)		
			for sID = 1:length(modelfits.(groups{gg}).slope)
				% create feature vectors and reward matrices
				[branch,leaf] = meshgrid(-2:2,-2:2);
				X = repmat([branch(:),leaf(:)],numReps,1);
				tms = loadTaskMatrix(boundaryName);
				rew_rel_north = repmat(tms.rewMat_leaf(:),numReps,1);
				rew_rel_south = repmat(tms.rewMat_branch(:),numReps,1);
				rew_irrel_north = repmat(tms.rewMat_branch(:),numReps,1);
				rew_irrel_south = repmat(tms.rewMat_leaf(:),numReps,1);
				thetas = [squeeze(modelfits.(groups{gg}).phi(sID,:)),squeeze(modelfits.(groups{gg}).offset(sID,1)),squeeze(modelfits.(groups{gg}).slope(sID,1)),squeeze(modelfits.(groups{gg}).lapse(sID,1)),squeeze(modelfits.(groups{gg}).offset(sID,2)),squeeze(modelfits.(groups{gg}).slope(sID,2)),squeeze(modelfits.(groups{gg}).lapse(sID,2))];

				% obtain model responses for both tasks (north,south)
				y_both = freeBoundaryModelTT(X,thetas,'twoBoundsAndSigmoids');
				% convert into choices
				y_both = y_both > rand(length(y_both),1);

				% split into two tasks
				y_north = y_both(1:length(y_both)/2);
				y_south = y_both(length(y_both)/2+1:end);

				% convert into task-specific data matrix (branch,leaf,response,rew_rel,rew_irrel)
				data_north = [X,y_north,rew_rel_north(:),rew_irrel_north(:)];
				data_south = [X,y_south,rew_rel_south(:),rew_irrel_south(:)];
				modelsamples.(groups{gg}).north(sID,:,:) = data_north;
				modelsamples.(groups{gg}).south(sID,:,:) = data_south;
			end
		
	end


end



function taskMatrices = loadTaskMatrix(matID)
	taskMatrices = struct();
	switch (matID)
	case 'cardinal'
		 % high high - cardinal
		 taskMatrices.rewMat_leaf = [-2,-2,-2,-2,-2;
                                    -1,-1,-1,-1,-1;
                                    0,0,0,0,0;
                                    1,1,1,1,1;
                                    2,2,2,2,2];

		 taskMatrices.catMat_leaf = [-1,-1,-1,-1,-1;
                                    -1,-1,-1,-1,-1;
                                    0,0,0,0,0;
                                    1,1,1,1,1;
                                    1,1,1,1,1];
		
		 taskMatrices.rewMat_branch = [-2,-1,0,1,2;
                                       -2,-1,0,1,2;
                                        -2,-1,0,1,2;
                                        -2,-1,0,1,2;
                                        -2,-1,0,1,2];
		 
		 taskMatrices.catMat_branch = [-1,-1,0,1,1;
                                        -1,-1,0,1,1;
                                        -1,-1,0,1,1;
                                        -1,-1,0,1,1;
                                        -1,-1,0,1,1];		 

	case 'diagonal'
		 % high high - diagonal
		 taskMatrices.rewMat_leaf = [-2,-2,-2,-1,0;
		 			     -2,-2,-1,0,1;
					     -2,-1,0,1,2;
					     -1,0,1,2,2;
					     0,1,2,2,2];

		 taskMatrices.catMat_leaf = [-1,-1,-1,-1,0;
		 			     -1,-1,-1,0,1;
					     -1,-1,0,1,1;
					     -1,0,1,1,1;
					     0,1,1,1,1];
		
		 taskMatrices.rewMat_branch = [0,1,2,2,2;
		 		  	       -1,0,1,2,2;
				  	       -2,-1,0,1,2;
				  	       -2,-2,-1,0,1;
				  	       -2,-2,-2,-1,0];
		 
		 taskMatrices.catMat_branch = [0,1,1,1,1;
		 		  	       -1,0,1,1,1;
				  	       -1,-1,0,1,1;
				  	       -1,-1,-1,0,1;
				  	       -1,-1,-1,-1,0];
   end
			 
	
end
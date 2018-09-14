function rsData = data_add_irrelevantDimensionValues(rsData)
  %% RSDATA = data_ADD_IRRELEVANTDIMENSIONVALUES(RSDATA)
  % didn't include fields 6 and 7 in first experiment (block200vsinterleaved, cardinal),
  % so add them here.
  %
  % Timo Flesch, 2017


for subID = 1:length(rsData)

    	% didn't include fields 6 and 7 in first experiment (block200vsinterleaved, cardinal),
    	% so add them here:
        if isnan(rsData(subID).code(7))
            if rsData(subID).code(2) == 0 & rsData(subID).code(3) == 0
                rsData(subID).code(7) = 1;
            elseif rsData(subID).code(2) == 1 & rsData(subID).code(3) == 1
                rsData(subID).code(7) = 2;
            elseif rsData(subID).code(2) == 1 & rsData(subID).code(3) == 0
                rsData(subID).code(7) = 3;
            elseif rsData(subID).code(2) == 0 & rsData(subID).code(3) == 1
                rsData(subID).code(7) = 4;
            end
        end

        % load corresponding task matrices
        taskMatrices = loadTaskMatrix(rsData(subID).code(7));

        % for all combinations of branchiness and leafiness
        for leafLevel = 1:5
            for branchLevel = 1:5
            % find trials of task north and trials of task south
            northTrials =find(rsData(subID).data(:,3)==1 & rsData(subID).data(:,4)==leafLevel & rsData(subID).data(:,5)==branchLevel);
            southTrials =find(rsData(subID).data(:,3)==2 & rsData(subID).data(:,4)==leafLevel & rsData(subID).data(:,5)==branchLevel);
            % retrieve reward(relevant) and reward(irrelevant)
            leafReward = taskMatrices.rewMat_leaf(leafLevel,branchLevel);
            branchReward = taskMatrices.rewMat_branch(leafLevel,branchLevel);
            leafCat = taskMatrices.catMat_leaf(leafLevel,branchLevel);
            branchCat = taskMatrices.catMat_branch(leafLevel,branchLevel);
            % fill into matrix
            % reward relevant dimension ( this is sanity check):
            rsData(subID).data(northTrials,12) = leafReward;
            rsData(subID).data(southTrials,12) = branchReward;
            % category relevant dimension ( this is sanity check):
            rsData(subID).data(northTrials,13) = leafCat;
            rsData(subID).data(southTrials,13) = branchCat;
            % reward irrelevant dimension ( this is sanity check):
            rsData(subID).data(northTrials,14) = branchReward;
            rsData(subID).data(southTrials,14) = leafReward;
            % category irrelevant dimension ( this is sanity check):
            rsData(subID).data(northTrials,15) = branchCat;
            rsData(subID).data(southTrials,15) = leafCat;
            end
        end

        rsData(subID).structure = 'block | sess | context | leaf | branch | cat | rew | resp_choice | resp_correct | resp_rew | resp_rt | rew_rel | cat_rel | rew_irr | cat_irr';

end
end



function taskMatrices = loadTaskMatrix(matID)
	taskMatrices = struct();
	switch (matID)
		case 1
			 % high high
			 taskMatrices.rewMat_leaf = [-50,-50,-50,-50,-50;
                                        -25,-25,-25,-25,-25;
                                        0,0,0,0,0;
                                        25,25,25,25,25;
                                        50,50,50,50,50];

			 taskMatrices.catMat_leaf = [-1,-1,-1,-1,-1;
                                        -1,-1,-1,-1,-1;
                                        0,0,0,0,0;
                                        1,1,1,1,1;
                                        1,1,1,1,1];

			 taskMatrices.rewMat_branch = [-50,-25,0,25,50;
                                           -50,-25,0,25,50;
                                            -50,-25,0,25,50;
                                            -50,-25,0,25,50;
                                            -50,-25,0,25,50];

			 taskMatrices.catMat_branch = [-1,-1,0,1,1;
                                            -1,-1,0,1,1;
                                            -1,-1,0,1,1;
                                            -1,-1,0,1,1;
                                            -1,-1,0,1,1];

		case 2
			  % low low
			  taskMatrices.rewMat_leaf = [50,50,50,50,50;
			  		 	      25,25,25,25,25;
					 	      0,0,0,0,0;
					 	      -25,-25,-25,-25,-25;
					 	      -50,-50,-50,-50,-50];

			 taskMatrices.catMat_leaf = [1,1,1,1,1;
			 			     1,1,1,1,1;
						     0,0,0,0,0;
						     -1,-1,-1,-1,-1;
						     -1,-1,-1,-1,-1];

			 taskMatrices.rewMat_branch = [50,25,0,-25,-50;
			 		  	       50,25,0,-25,-50;
					  	       50,25,0,-25,-50;
					  	       50,25,0,-25,-50;
					  	       50,25,0,-25,-50];

			 taskMatrices.catMat_branch = [1,1,0,-1,-1;
			 		  	       1,1,0,-1,-1;
					  	       1,1,0,-1,-1;
					  	       1,1,0,-1,-1;
					  	       1,1,0,-1,-1];


		case 3
			  % low high
			  taskMatrices.rewMat_leaf = [50,50,50,50,50;
			  		 	      25,25,25,25,25;
					 	      0,0,0,0,0;
					 	      -25,-25,-25,-25,-25;
					 	      -50,-50,-50,-50,-50];

			 taskMatrices.catMat_leaf = [1,1,1,1,1;
			 			     1,1,1,1,1;
						     0,0,0,0,0;
						     -1,-1,-1,-1,-1;
						     -1,-1,-1,-1,-1];

			 taskMatrices.rewMat_branch = [-50,-25,0,25,50;
			 		  	       -50,-25,0,25,50;
					  	       -50,-25,0,25,50;
					  	       -50,-25,0,25,50;
					  	       -50,-25,0,25,50];

			 taskMatrices.catMat_branch = [-1,-1,0,1,1;
			 		  	       -1,-1,0,1,1;
					  	       -1,-1,0,1,1;
					  	       -1,-1,0,1,1;
					  	       -1,-1,0,1,1];


		case 4
			  % high low
			 taskMatrices.rewMat_leaf = [-50,-50,-50,-50,-50;
			 			     -25,-25,-25,-25,-25;
						     0,0,0,0,0;
						     25,25,25,25,25;
						     50,50,50,50,50];

			 taskMatrices.catMat_leaf = [-1,-1,-1,-1,-1;
			 			     -1,-1,-1,-1,-1;
						     0,0,0,0,0;
						     1,1,1,1,1;
						     1,1,1,1,1];

			 taskMatrices.rewMat_branch = [50,25,0,-25,-50;
			 		  	       50,25,0,-25,-50;
					  	       50,25,0,-25,-50;
					  	       50,25,0,-25,-50;
					  	       50,25,0,-25,-50];

			 taskMatrices.catMat_branch = [1,1,0,-1,-1;
			 		  	       1,1,0,-1,-1;
					  	       1,1,0,-1,-1;
					  	       1,1,0,-1,-1;
					  	       1,1,0,-1,-1];


		case 5
			 % high high
			 taskMatrices.rewMat_leaf = [-50,-50,-50,-25,0;
			 			     -50,-50,-25,0,25;
						     -50,-25,0,25,50;
						     -25,0,25,50,50;
						     0,25,50,50,50];

			 taskMatrices.catMat_leaf = [-1,-1,-1,-1,0;
			 			     -1,-1,-1,0,1;
						     -1,-1,0,1,1;
						     -1,0,1,1,1;
						     0,1,1,1,1];

			 taskMatrices.rewMat_branch = [0,25,50,50,50;
			 		  	       -25,0,25,50,50;
					  	       -50,-25,0,25,50;
					  	       -50,-50,-25,0,25;
					  	       -50,-50,-50,-25,0];

			 taskMatrices.catMat_branch = [0,1,1,1,1;
			 		  	       -1,0,1,1,1;
					  	       -1,-1,0,1,1;
					  	       -1,-1,-1,0,1;
					  	       -1,-1,-1,-1,0];

		case 6
			  % low low
			  taskMatrices.rewMat_leaf = [50,50,50,25,0;
			 			      50,50,25,0,-25;
						      50,25,0,-25,-50;
						      25,0,-25,-50,-50;
						      0,-25,-50,-50,-50];

			 taskMatrices.catMat_leaf = [1,1,1,1,0;
			 			     1,1,1,0,-1;
						     1,1,0,-1,-1;
						     1,0,-1,-1,-1;
						     0,-1,-1,-1,-1];

			 taskMatrices.rewMat_branch = [0,-25,-50,-50,-50;
			 		  	       25,0,-25,-50,-50;
					  	       50,25,0,-25,-50;
					  	       50,50,25,0,-25;
					  	       50,50,50,25,0];

			 taskMatrices.catMat_branch = [0,-1,-1,-1,-1;
			 		  	       1,0,-1,-1,-1;
					  	       1,1,0,-1,-1;
					  	       1,1,1,0,-1;
					  	       1,1,1,1,0];


		case 7
			  % low high
			  taskMatrices.rewMat_leaf = [50,50,50,25,0;
			 			      50,50,25,0,-25;
						      50,25,0,-25,-50;
						      25,0,-25,-50,-50;
						      0,-25,-50,-50,-50];

			 taskMatrices.catMat_leaf = [1,1,1,1,0;
			 			     1,1,1,0,-1;
						     1,1,0,-1,-1;
						     1,0,-1,-1,-1;
						     0,-1,-1,-1,-1];

			 taskMatrices.rewMat_branch = [0,25,50,50,50;
			 		  	       -25,0,25,50,50;
					  	       -50,-25,0,25,50;
					  	       -50,-50,-25,0,25;
					  	       -50,-50,-50,-25,0];

			 taskMatrices.catMat_branch = [0,1,1,1,1;
			 		  	       -1,0,1,1,1;
					  	       -1,-1,0,1,1;
					  	       -1,-1,-1,0,1;
					  	       -1,-1,-1,-1,0];


		case 8
			  % high low
			 taskMatrices.rewMat_leaf = [-50,-50,-50,-25,0;
			 			     -50,-50,-25,0,25;
						     -50,-25,0,25,50;
						     -25,0,25,50,50;
						     0,25,50,50,50];

			 taskMatrices.catMat_leaf = [-1,-1,-1,-1,0;
			 			     -1,-1,-1,0,1;
						     -1,-1,0,1,1;
						     -1,0,1,1,1;
						     0,1,1,1,1];

			 taskMatrices.rewMat_branch = [0,-25,-50,-50,-50;
			 		  	       25,0,-25,-50,-50;
					  	       50,25,0,-25,-50;
					  	       50,50,25,0,-25;
					  	       50,50,50,25,0];

			 taskMatrices.catMat_branch = [0,-1,-1,-1,-1;
			 		  	       1,0,-1,-1,-1;
					  	       1,1,0,-1,-1;
					  	       1,1,1,0,-1;
					  	       1,1,1,1,0];

	end
end

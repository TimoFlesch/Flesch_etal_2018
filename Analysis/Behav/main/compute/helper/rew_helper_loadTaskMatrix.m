function taskMatrices = loadTaskMatrix(matID)
%% LOADTASKMATRIX(MATID)
% 
% loads matrix of reward values that were used for a particular subject
% 
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, University of Oxford

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

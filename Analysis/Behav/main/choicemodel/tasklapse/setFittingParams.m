function fittingparams = setFittingParams(optimBounds)
	% fmincon: initial values and constraints 	

	fittingparams.initVals   = [optimBounds(1),optimBounds(2),0,20,0]; % optimBounds(1) for north, optimBounds(2) for south task, zero offset and lapse, binarized choice probs	
	fittingparams.initVals_twoSigmoids    = [optimBounds(1),optimBounds(2),0,20,0,0,20,0];
	fittingparams.initVals_oneBoundary    =                       [optimBounds(3),0,20,0];
	fittingparams.initVals_tasklapse      =                             [0]; % two sigmoids and task lapse (set to zero)
	fittingparams.constraints_bound_north =         [optimBounds(1)-90,optimBounds(1)+90];
	fittingparams.constraints_bound_south =         [optimBounds(2)-90,optimBounds(2)+90];
	fittingparams.constraints_bound_diag  =         [optimBounds(3)-90,optimBounds(3)+90];
	fittingparams.catBounds               =        optimBounds(1:2); %optimal boundaries, factorised model
	fittingparams.diagBounds              =       [optimBounds(3),optimBounds(3)]; % optimal boundary, composite model

	fittingparams.constraints_offset    =  [-1,1];
	fittingparams.constraints_slope     =  [0,20];
	fittingparams.constraints_lapserate = [0,0.5];
	fittingparams.constraints_tasklapse =   [0,1];
	
	fittingparams.allBounds             = [fittingparams.constraints_bound_north;fittingparams.constraints_bound_south;fittingparams.constraints_offset;fittingparams.constraints_slope;fittingparams.constraints_lapserate];
	fittingparams.allBounds_twoSigmoids = [fittingparams.constraints_bound_north;fittingparams.constraints_bound_south;fittingparams.constraints_offset;fittingparams.constraints_slope;fittingparams.constraints_lapserate;fittingparams.constraints_offset;fittingparams.constraints_slope;fittingparams.constraints_lapserate];
	fittingparams.allBounds_oneBoundary = [fittingparams.constraints_bound_diag;fittingparams.constraints_offset;fittingparams.constraints_slope;fittingparams.constraints_lapserate];
	fittingparams.allBounds_tasklapse   = [fittingparams.constraints_tasklapse];
end
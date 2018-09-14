
function params = main_setFittingParams(boundaryName)
	% sets all params
	%
	% Timo Flesch, 2018
	params = struct();

	% define groups and phases
	if ~exist('boundaryName')
		params.boundaryName =        'cardinal';
	else
		params.boundaryName =       boundaryName;
	end
	params.groupNames   =    {'b200','b20','b2','int'};
	% params.groupNames   =    {'b200','int'};
	params.expPhase     =          {'train'};

	% misc
	params.numObs         = 50; % 25 fields per task (cmat fits)
	% params.numObs           = 200; % 100 trials per task (single-trial fits)


	% fmincon: initial values and constraints
	if strcmp(params.boundaryName,'cardinal')
		params.initVals   = [180,90,0,20,0]; % 180 for north, 90 for south task, zero offset and lapse, binarized choice probs
		params.initVals_twoSigmoids    = [180,90,0,20,0,0,20,0];
		params.initVals_oneBoundary    =    [135,0,20,0];
		params.constraints_bound_north =        [90,270];
		params.constraints_bound_south =         [0,180];
		params.constraints_bound_diag  = [135-90,135+90];
		params.catBounds               =        [180,90]; %optimal boundaries, factorised model
		params.diagBounds              =       [135,135]; % optimal boundary, composite model
	else
		params.initVals                = [135,45,0,20,0];
		params.initVals_twoSigmoids    = [135,45,0,20,0,0,20,0];
		params.initVals_oneBoundary    =     [90,0,20,0];
		params.constraints_bound_north = [135-90,135+90];
		params.constraints_bound_south =   [45-90,45+90];
		params.constraints_bound_diag  =   [90-90,90+90];
		params.catBounds               =        [135,45];
		params.diagBounds              =         [90,90];
	end
	params.constraints_offset    =  [-1,1];
	params.constraints_slope     =  [0,20];
	params.constraints_lapserate = [0,0.5];

	params.allBounds             = [params.constraints_bound_north;params.constraints_bound_south;params.constraints_offset;params.constraints_slope;params.constraints_lapserate];
	params.allBounds_twoSigmoids = [params.constraints_bound_north;params.constraints_bound_south;params.constraints_offset;params.constraints_slope;params.constraints_lapserate;params.constraints_offset;params.constraints_slope;params.constraints_lapserate];
	params.allBounds_oneBoundary = [params.constraints_bound_diag;params.constraints_offset;params.constraints_slope;params.constraints_lapserate];


	params.vbaOptions = struct();
	params.vbaOptions.DisplayWin = 1;
	params.vbaOptions.verbose    = 0;
end

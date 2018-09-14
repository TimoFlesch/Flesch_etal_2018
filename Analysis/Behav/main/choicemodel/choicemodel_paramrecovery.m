function [allParams,synthData,recoveredParams,rhos,p_sr] = choicemodel_paramrecovery(boundaryName)
	%% CHOICEMODEL_PARAMRECOVERY()
	% parfor subjects (e.g. 10)
	% 	for range of bias, lapse and slope parameters,
	%		- calculate for each bxl combi ~1k choices (y>rnd)
	% 		- fit model to this data
	%	 	- compute corr of estimated parameters with true parameters
	%
	% Timo Flesch, 1017
	% Summerfield Lab, Experimental Psychology Department

	mypool = gcp('nocreate');
	if isempty(mypool)
		numWorkers = 0;
	else
		numWorkers = mypool.NumWorkers;
	end


	% set parameters
	numIters    =  100;
	numSubjects =   50;

	taskDim    = {'north','south'};
	paramNames = {'orientation','offset','slope','lapse'};

	if ~exist('boundaryName')
		boundaryName = 'cardinal';
	end


	%% DEFINE TRUE PARAMETERS (one value per "subject")
	if strcmp(boundaryName,'cardinal')
		initVals   = [180,0,10,0;90,0,10,0]; % 180 for north, 90 for south task, zero offset and lapse, binarized choice probs
		params_bound_north = linspace(90,270,numSubjects);
		params_bound_south = linspace(0,180,numSubjects);
	else
		initVals   = [135,0,10,0;45,0,10,0]; % 180 for north, 90 for south task, zero offset and lapse, binarized choice probs
		params_bound_north = linspace(135-90,135+90,numSubjects);
		params_bound_south = linspace(45-90,45+90,numSubjects);
	end
	params_offset    =  linspace(-1,1,numSubjects);
	params_slope     =  linspace(0,10,numSubjects);
	params_lapserate = linspace(0,0.5,numSubjects);

	allParams_north = [params_bound_north;params_offset;params_slope;params_lapserate];
	allParams_south = [params_bound_south;params_offset;params_slope;params_lapserate];

	%% GENERATE SYNTHETIC DATA
	% for each parameter and for each subject, generate choices for full 5x5 mat on 1k interations
	synthData = struct();
	for td = taskDim
		if strcmp(td{1},'north')
			initParams = initVals(1,:);
			allParams = allParams_north;
		else
			initParams = initVals(2,:);
			allParams = allParams_south;
		end
		defaultParams = initParams;
		for ii_param = 1:size(allParams,1) % for each param
			tmp1 = zeros(numSubjects,numIters,25);
			parfor(ii_sub = 1:numSubjects, numWorkers) % for each subject (==param value)
				for ii_iter = 1:numIters % for several iterations
					% compute model output for this particular parameter (=subject)
					inputParams = defaultParams;
					inputParams(ii_param) = allParams(ii_param,ii_sub);
					y = boundaryModel(inputParams);
					% compute synthetic choices
					tmp1(ii_sub,ii_iter,:) = y > rand(size(y));
				end
			end
			%synthData.param.task = tmp1
			synthData.(paramNames{ii_param}).(td{1}) = tmp1;
		end
	end
	save(['synthData_' boundaryName '.mat'],'synthData');
	allParams = struct();
	allParams.north = allParams_north';
	allParams.south = allParams_south';
	save(['allParams_' boundaryName '.mat'],'allParams');
	%% FMINCON - PARAMETER RECOVERY
	% perform fmincon on synthetic data (e.g. each paramName struct)

	if strcmp(boundaryName,'cardinal')
		initVals   = [180,0,10,0;90,0,10,0]; % 180 for north, 90 for south task, zero offset and lapse, binarized choice probs
		constraints_bound_north = [90,270];
		constraints_bound_south = [0,180];
	else
		initVals   = [135,0,10,0;45,0,10,0]; % 180 for north, 90 for south task, zero offset and lapse, binarized choice probs
		constraints_bound_north = [135-90,135+90];
		constraints_bound_south = [45-90,45+90];
	end
	constraints_offset    =  [-1,1];
	constraints_slope     =  [0,10];
	constraints_lapserate = [0,0.5];
	allBounds_north = [constraints_bound_north;constraints_offset;constraints_slope;constraints_lapserate];
	allBounds_south = [constraints_bound_south;constraints_offset;constraints_slope;constraints_lapserate];

	results = struct();

	%% 1. grid search of choice pattern model parameters
	[x,y] = meshgrid(-2:2,-2:2);
	X = [x(:),y(:)];

	recoveredParams = struct();
	for td = taskDim
		for prm = paramNames
			choiceMats = squeeze(mean(synthData.(prm{1}).(td{1}),2)); %average across iters to obtain probability matrices
			tmp1 = zeros(size(choiceMats,1),size(initVals,2));
			% parallelize across participants
			parfor(ii = 1:size(choiceMats,1),numWorkers)
				% fit model
				choiceMatVect = squeeze(choiceMats(ii,:));
				if strcmp(td{1},'north')
					initParams = initVals(1,:);
					allBounds = allBounds_north;
				else
					initParams = initVals(2,:);
					allBounds = allBounds_south;
				end
				% estimate parameters
				tmp1(ii,:) = fitBoundaryModel(X,choiceMatVect,initParams,allBounds(:,1),allBounds(:,2));
			end
			recoveredParams.(prm{1}).(td{1}) = tmp1;
		end

	end
	save(['recoveredParams_' boundaryName '.mat'],'recoveredParams');

	%% PARAMETER RECOVERY EVALUATION
	% compute correlation between true parameters and recovered (== estimated) parameters and perform signed rank test

	rhos = struct();
	for td = taskDim
		for ii = 1:4
			[rhos.corrs.(paramNames{ii}).(td{1}),rhos.pvals.(paramNames{ii}).(td{1})] = corrcoef(squeeze(recoveredParams.(paramNames{ii}).(td{1})(:,ii)),squeeze(allParams.(td{1})(:,ii)));
			p_sr = signrank(squeeze(recoveredParams.(paramNames{ii}).(td{1})(:,ii)),squeeze(allParams.(td{1})(:,ii)));
		end
	end
	save(['rhos_' boundaryName '.mat'],'rhos');
	save(['p_sr_' boundaryName '.mat'],'p_sr');


end

function betas = fitBoundaryModel(x,y,initParams,lb,ub)

	loss = @(initParams)-sum(log(1-abs(y(:)-boundaryModel(initParams))+1e-10));
	betas = fmincon(loss,initParams,[],[],[],[],lb,ub);
end


function y_out = boundaryModel(b)
		y_out = choicemodel_boundarymodel([],b(1),b(2),b(3),b(4));
		% y_out = rew_regress_helper_boundarymodel(x,b(1),b(2),4);
		y_out = y_out(:);
end

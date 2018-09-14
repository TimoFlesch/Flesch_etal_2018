function [betas,minloss] = fitBoundaryModelTT(x,y_north,y_south,initParams,lb,ub,modelID,boundValue)
	%
	% fits our psychophysical model ("boundary model") to the participant choices 
	% optimisation procedure is carried out for *both* tasks simultaneously
	% using fmincon (depending on context, different scalar projection is applied)
	%
	% INPUTS:
	% x:	inputs  (tuples of branchiness & leafiness)
	% y: 	targets (participant choices)
	% initParams: 	initial parameter values 
	% lb:			lower bounds (constraints on minimum values)
	% ub:			upper bounds (constraints on maximum values)
	% modelID:		'freeTwoBounds', 'freeOneBound', 'fixedTwoBounds', 'fixedOneBound'
	% boundValue: 	if above is fixedTask or fixedDiag, provide value for optim boundary
	%
	% OUTPUTS:
	% betas:	estimated parameters
	% minloss	NLL of optimal set of parameters
	%
	% Timo Flesch, 2018

	y = [y_north(:);y_south(:)];
	switch modelID
		case 'fullyParametrised'
			loss = @(initParams)-sum(log(1-abs(y(:)-freeBoundaryModelTT(x,initParams,'twoBoundsAndSigmoids'))+1e-10));						
		case 'freeTwoBounds'			
			loss = @(initParams)-sum(log(1-abs(y(:)-freeBoundaryModelTT(x,initParams,'twoBounds'))+1e-10));
		case 'freeOneBound'
			loss = @(initParams)-sum(log(1-abs(y(:)-freeBoundaryModelTT(x,initParams,'oneBound'))+1e-10));
		case 'fixedTwoBounds'
			loss = @(initParams)-sum(log(1-abs(y(:)-fixedBoundaryModelTT(x,initParams,boundValue))+1e-10));
		case 'fixedOneBound' %same as above, but with different boundary angles (same for both tasks)
			loss = @(initParams)-sum(log(1-abs(y(:)-fixedBoundaryModelTT(x,initParams,boundValue))+1e-10));
			% loss = @(initParams) sum(-y(:).*log(fixedBoundaryModel(x,initParams,boundValue))-(1-y(:)).*log(1-fixedBoundaryModel(x,initParams,boundValue)));
	end		
	[betas,minloss] = fmincon(loss,initParams,[],[],[],[],lb,ub,[],optimoptions('fmincon','Display','off'));
end
function Y_HAT = freeBoundaryModelTT(X,theta,numBounds)	
	% 
	% psychophysical model with free boundary parameter, one for each task
	% INPUTS:
	% - X:     Matrix with tree coordinates, centered around zero (branchiness_si,leafiness_si)-3 
	% - THETA: Model parameters, with following components:	
	%	 - PHI:   Angles of category boundary (deg) for north AND south task
	%	 - OFFSET: Shift of boundary along x-axis 
	%	 - SLOPE: Slope of sigmoidal squashing function ( for choice probabilities)
	%	 - LAPSERATE: [0,0.5] moves shrinks y-range. 0.5== flat line, corresponds to random error trials 
	% - NUMBOUNDS: 'one' or 'two'
	%
	% OUTPUTS:
	% - Y: estimated choice probabilities for (X,THETA)
	% 
	% Timo Flesch, 2018
	
	%% Step 1: Project each point onto subspace orthogonal to bound  (= distance to bound)
	% (1a)  compute line orthogonal to decision boundary:
	s_proj = [];
	switch numBounds
		case 'twoBoundsAndSigmoids'
			X1    = scalarproj(X,theta(1));
			Y1    = transducer(X1,theta(3),theta(4),theta(5));
			X2    = scalarproj(X,theta(2));
			Y2    = transducer(X2,theta(6),theta(7),theta(8));
			Y_HAT = [Y1;Y2];

		case 'twoBounds'
			X1    = scalarproj(X,theta(1));
			X2    = scalarproj(X,theta(2));			
			Y_HAT = transducer([X1;X2],theta(3),theta(4),theta(5));

		case 'oneBound'
			X1    = scalarproj(X,theta(1));
			X2    = scalarproj(X,theta(1));
			Y_HAT = transducer([X1;X2],theta(2),theta(3),theta(4));
	end
	
end

function Y = scalarproj(X,phi)
	phi_bound =                  deg2rad(phi);	
	phi_ort   =         phi_bound-deg2rad(90);
	Y         = X*[cos(phi_ort);sin(phi_ort)];	
end

function y = transducer(x,offset,slope,lapse)
	% helper function, implements sigmoidal transducer with three parameters
	y = lapse + (1-lapse*2)./(1+exp(-slope*(x-offset)));
	% y = 1./(1+exp(-slope*(x-offset)));
end



function Y_HAT = tasklapseModel_singletrials(X,theta,phi)	
	%% Y_HAT = TASKLAPSEMODEL_SINGLETRIALS(X,THETA,PHI)
	%
	% fixed-boundary model with task lapse parameter.
	% epsilon is bounded between 0 and 1 and determines accidental task switch probability. That is,
	% if it is greater than a uniform sample, the trial is treated as if it belonged to the opposite task.
	% The orientation of the boundaries are fixed to optimal values (=ground truth) phi_north and phi_south
	% The sigmoid-parameters slope, offset and lapse are free. 
	%
	% INPUTS:
	% - X: vector of single-trial context-x-branchiness-x-leafiness tuples
	% - THETA: sigmoid parameters for north and south task, and task switch probability
	% - PHI: true boundaries for north and south task	
	% 
	% OUTPUTS:
	% Y_HAT: vector of single-trial responses

	% Timo Flesch, 2018
	% 
	for ii = 1:size(X,1) % for each trial
		if X(ii,1)==1 % if north task
			% flip a coin
			taskswitch = theta(end) > rand;
			if taskswitch
				% feed through irrel dim
				X_PROJ(ii) = scalarproj(X(ii,2:3),phi(2));
				Y_HAT(ii,1) = transducer(X_PROJ(ii),0,20,0);
			else
				% feed through rel dim
				X_PROJ(ii) = scalarproj(X(ii,2:3),phi(1));
				Y_HAT(ii,1) = transducer(X_PROJ(ii),0,20,0);
			end
		else % if south task
			% flip a coin
			taskswitch = theta(end) > rand;
			if taskswitch
				% feed through irrel dim
				X_PROJ(ii) = scalarproj(X(ii,2:3),phi(1));
				Y_HAT(ii,1) = transducer(X_PROJ(ii),0,20,0);				
			else
				% feed through rel dim
				X_PROJ(ii) = scalarproj(X(ii,2:3),phi(2));
				Y_HAT(ii,1) = transducer(X_PROJ(ii),0,20,0);				
			end
		end
	end
end	




function Y = scalarproj(X,phi)
	phi_bound =                  deg2rad(phi);	
	phi_ort   =         phi_bound-deg2rad(90);
	Y         = X*[cos(phi_ort);sin(phi_ort)];	
end

function y = transducer(x,offset,slope,lapse)
	% helper function, implements sigmoidal transducer with three parameters
	y = 0 + (1-0*2)./(1+exp(-20*(x-0)));
end
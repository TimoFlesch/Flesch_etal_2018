function Y_HAT = fixedBoundaryModel_singletrials(X_north,X_south,theta,phi)	
	X1    = scalarproj(X_north,phi(1));
	X2    = scalarproj(X_south,phi(1));
	Y_HAT = transducer([X1;X2],theta(1),theta(2),theta(3));
end	


function Y = scalarproj(X,phi)
	phi_bound =                  deg2rad(phi);	
	phi_ort   =         phi_bound-deg2rad(90);
	Y         = X*[cos(phi_ort);sin(phi_ort)];	
end

function y = transducer(x,offset,slope,lapse)
	% helper function, implements sigmoidal transducer with three parameters
	y = lapse + (1-lapse*2)./(1+exp(-slope*(x-offset)));
end
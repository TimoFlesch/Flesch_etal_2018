
function modelfits = main_fitAllModels_singletrials(data,params)
% fit the models!
%
% Timo Flesch, 2018
	modelfits = struct();
	for ep = params.expPhase %train,test		
		for g = params.groupNames %b200, int etc
			% placeholders for estimated parameter values (subs-x-numparams) and losses (subs-x-1)			
				
			for(i_subj = 1:size(data.singleTrials.(ep{1}).north.(g{1}).data,1)) % north and south of course same #subs
				
				% update boundary params (as single trial data is in different reference frames, in contrast to old choice-matrix data)
				optimBounds = [data.singleTrials.(ep{1}).north.(g{1}).bound(i_subj),data.singleTrials.(ep{1}).south.(g{1}).bound(i_subj),data.singleTrials.(ep{1}).north.(g{1}).diag(i_subj)];
				fittingparams = setFittingParams(optimBounds);

				% set inputs				
				X_north = squeeze(data.singleTrials.(ep{1}).north.(g{1}).data(i_subj,:,[2,1]))-3; % branchiness, leafiness; north task, centered around zero
				X_south = squeeze(data.singleTrials.(ep{1}).south.(g{1}).data(i_subj,:,[2,1]))-3; % branchiness, leafiness; south task, centered around zero
				% 2. obtain response vectors (binary choices, 0,1)
				Y_north = squeeze(data.singleTrials.(ep{1}).north.(g{1}).data(i_subj,:,3));	
				Y_south = squeeze(data.singleTrials.(ep{1}).south.(g{1}).data(i_subj,:,3));						
				
				% 3. estimate parameters
				% eight parameter model: two boundaries, two sigmoids (phi_A,phi_B,slope_A,offset_A,lapse_A,slope_B,offset_B,lapse_B)				
				[theta_hat_free_twoBoundsAndSigmoids(i_subj,:,:),negLL_free_twoBoundsAndSigmoids(i_subj,:)] = fitBoundaryModel_singletrials(X_north,X_south,Y_north,Y_south,fittingparams.initVals_twoSigmoids,fittingparams.allBounds_twoSigmoids(:,1),fittingparams.allBounds_twoSigmoids(:,2),'fullyParametrised',fittingparams.catBounds);	

				% five parameter model: two boundaries, one sigmoid (phi_A,phi_B,slope,offset,lapse)
				[theta_hat_free_twoBounds(i_subj,:,:),negLL_free_twoBounds(i_subj,:)] = fitBoundaryModel_singletrials(X_north,X_south,Y_north,Y_south,fittingparams.initVals,fittingparams.allBounds(:,1),fittingparams.allBounds(:,2),'freeTwoBounds',fittingparams.catBounds);				
				% four-parameter model: one boundary, one sigmoid (phi, slope, offset, lapse)
				[theta_hat_free_oneBound(i_subj,:,:),negLL_free_oneBound(i_subj,:)] = fitBoundaryModel_singletrials(X_north,X_south,Y_north,Y_south,fittingparams.initVals_oneBoundary,fittingparams.allBounds_oneBoundary(:,1),fittingparams.allBounds_oneBoundary(:,2),'freeOneBound',fittingparams.diagBounds);	

				% seven parameter model: fixed boundaries, two sigmoids, task lapse 				
				[theta_hat_fixed_taskLapse(i_subj,:,:),negLL_fixed_taskLapse(i_subj,:)] = fitBoundaryModel_singletrials(X_north,X_south,Y_north,Y_south,fittingparams.initVals_tasklapse,fittingparams.allBounds_tasklapse(:,1),fittingparams.allBounds_tasklapse(:,2),'tasklapse',fittingparams.catBounds);	
				phis_fixed_taskLapse(i_subj,:) = fittingparams.catBounds;
			
				% 4. convert boundary estimates into distance to optimal boundary d(phi_hat,phi_true)
				bias_free_twoBounds(i_subj,1) = compute_boundaryBias(squeeze(theta_hat_free_twoBounds(i_subj,:,1)),fittingparams.catBounds(1),'north');
				bias_free_twoBounds(i_subj,2) = compute_boundaryBias(squeeze(theta_hat_free_twoBounds(i_subj,:,2)),fittingparams.catBounds(2),'south');

				bias_free_twoBoundsAndSigmoids(i_subj,1) = compute_boundaryBias(squeeze(theta_hat_free_twoBoundsAndSigmoids(i_subj,:,1)),fittingparams.catBounds(1),'north');
				bias_free_twoBoundsAndSigmoids(i_subj,2) = compute_boundaryBias(squeeze(theta_hat_free_twoBoundsAndSigmoids(i_subj,:,2)),fittingparams.catBounds(2),'south');

		
			
				% 5. convert nLL into LL and compute [A/B]IC
				bic_free_twoBounds(i_subj) = compute_BIC(-negLL_free_twoBounds(i_subj,:),size(theta_hat_free_twoBounds,3),params.numObs);
				bic_free_twoBoundsAndSigmoids(i_subj) = compute_BIC(-negLL_free_twoBoundsAndSigmoids(i_subj,:),size(theta_hat_free_twoBoundsAndSigmoids,3),params.numObs);
				bic_free_oneBound(i_subj) = compute_BIC(-negLL_free_oneBound(i_subj,:),size(theta_hat_free_oneBound,3),params.numObs);
				bic_fixed_taskLapse(i_subj) = compute_BIC(-negLL_fixed_taskLapse(i_subj,:),size(theta_hat_fixed_taskLapse,3),params.numObs);
			
			end		 
			% 6. store all results
			% eight parameter model
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).slope  = squeeze(mean(theta_hat_free_twoBoundsAndSigmoids(:,:,[4,7]),3));
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).offset = squeeze(mean(theta_hat_free_twoBoundsAndSigmoids(:,:,[3,6]),3));
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).lapse  = squeeze(mean(theta_hat_free_twoBoundsAndSigmoids(:,:,[5,8]),3));
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).bias   = squeeze(mean(bias_free_twoBoundsAndSigmoids,2));	
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).phi   = squeeze(theta_hat_free_twoBoundsAndSigmoids(:,1:2));
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).nll    = negLL_free_twoBoundsAndSigmoids;			
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).gof    =   bic_free_twoBoundsAndSigmoids; % goodness of fit 


			% five parameter model (phi_A,phi_B,slope,offset,lapse)			
			modelfits.free_twoBounds.(ep{1}).(g{1}).slope  = squeeze(theta_hat_free_twoBounds(:,:,4));
			modelfits.free_twoBounds.(ep{1}).(g{1}).offset = squeeze(theta_hat_free_twoBounds(:,:,3));
			modelfits.free_twoBounds.(ep{1}).(g{1}).lapse  = squeeze(theta_hat_free_twoBounds(:,:,5));
			modelfits.free_twoBounds.(ep{1}).(g{1}).bias   = squeeze(mean(bias_free_twoBounds,2));	
			modelfits.free_twoBounds.(ep{1}).(g{1}).phi   = squeeze(theta_hat_free_twoBounds(:,1:2));
			modelfits.free_twoBounds.(ep{1}).(g{1}).nll    = negLL_free_twoBounds;			
			modelfits.free_twoBounds.(ep{1}).(g{1}).gof    =   bic_free_twoBounds; % goodness of fit 

			% four-parameter model (phi, slope, offset, lapse)
			modelfits.free_oneBound.(ep{1}).(g{1}).slope  = squeeze(theta_hat_free_oneBound(:,:,3));
			modelfits.free_oneBound.(ep{1}).(g{1}).offset = squeeze(theta_hat_free_oneBound(:,:,2));
			modelfits.free_oneBound.(ep{1}).(g{1}).lapse  = squeeze(theta_hat_free_oneBound(:,:,4));
			modelfits.free_oneBound.(ep{1}).(g{1}).phi   = squeeze(theta_hat_free_oneBound(:,1));
			modelfits.free_oneBound.(ep{1}).(g{1}).nll    = negLL_free_oneBound;
			modelfits.free_oneBound.(ep{1}).(g{1}).gof    =   bic_free_oneBound; 

			% seven parameter model (task lapse)
			% modelfits.fixed_taskLapse.(ep{1}).(g{1}).slope      = squeeze(mean(theta_hat_fixed_taskLapse(:,:,[2,5]),3));
			% modelfits.fixed_taskLapse.(ep{1}).(g{1}).offset     = squeeze(mean(theta_hat_fixed_taskLapse(:,:,[1,4]),3));
			% modelfits.fixed_taskLapse.(ep{1}).(g{1}).lapse      = squeeze(mean(theta_hat_fixed_taskLapse(:,:,[3,6]),3));					
			modelfits.fixed_taskLapse.(ep{1}).(g{1}).tasklapse  =             squeeze(theta_hat_fixed_taskLapse(:,:,end));
			modelfits.fixed_taskLapse.(ep{1}).(g{1}).phi        =                                  phis_fixed_taskLapse;
			modelfits.fixed_taskLapse.(ep{1}).(g{1}).nll        =                                 negLL_fixed_taskLapse;			
			modelfits.fixed_taskLapse.(ep{1}).(g{1}).gof        =                                   bic_fixed_taskLapse; % goodness of fit

		
			clearvars -except data fittingparams modelfits ep g params;
		end		
	end
	modelfits.free_twoBoundsAndSigmoids.numParams = 8;
	modelfits.free_twoBounds.numParams            = 5;
	modelfits.free_oneBound.numParams             = 4;
	modelfits.fixed_taskLapse.numParams           = 7;

end
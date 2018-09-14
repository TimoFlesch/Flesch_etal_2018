
function modelfits = main_fitAllModels_cmats(cmats,params)
% fit the models!
%
% Timo Flesch, 2018
	modelfits = struct();
	for ep = params.expPhase %train,test
		for g = params.groupNames %b200, int etc
			% placeholders for estimated parameter values (subs-x-numparams) and losses (subs-x-1)

			for(ii = 1:size(cmats.(ep{1}).north.(g{1}),1)) % north and south of course same #subs

				% 1. define inputs
				[a,b] = meshgrid(-2:2,-2:2);
				X     = [a(:),b(:)];
				% 2. obtain response matrix (choice proportions for task,phase,group and subject)
				Y_north = squeeze(cmats.(ep{1}).north.(g{1})(ii,:,:));
				Y_south = squeeze(cmats.(ep{1}).south.(g{1})(ii,:,:));

				% 3. estimate parameters
				% eight parameter model: two boundaries, two sigmoids (phi_A,phi_B,slope_A,offset_A,lapse_A,slope_B,offset_B,lapse_B)
				[theta_hat_free_twoBoundsAndSigmoids(ii,:,:),negLL_free_twoBoundsAndSigmoids(ii,:)] = fitBoundaryModelTT(X,Y_north,Y_south,params.initVals_twoSigmoids,params.allBounds_twoSigmoids(:,1),params.allBounds_twoSigmoids(:,2),'fullyParametrised',params.catBounds);

				% five parameter model: two boundaries, one sigmoid (phi_A,phi_B,slope,offset,lapse)
				[theta_hat_free_twoBounds(ii,:,:),negLL_free_twoBounds(ii,:)] = fitBoundaryModelTT(X,Y_north,Y_south,params.initVals,params.allBounds(:,1),params.allBounds(:,2),'freeTwoBounds',params.catBounds);
				% four-parameter model: one boundary, one sigmoid (phi, slope, offset, lapse)
				[theta_hat_free_oneBound(ii,:,:),negLL_free_oneBound(ii,:)] = fitBoundaryModelTT(X,Y_north,Y_south,params.initVals_oneBoundary,params.allBounds_oneBoundary(:,1),params.allBounds_oneBoundary(:,2),'freeOneBound',params.diagBounds);
				% % three parameter model, optimal boundaries, one sigmoid (slope, offset, lapse)
				% [theta_hat_fixed_twoBounds(ii,:,:),negLL_fixed_twoBounds(ii,:)] = fitBoundaryModelTT(X,Y_north,Y_south,params.initVals(3:end),params.allBounds(3:end,1),params.allBounds(3:end,2),'fixedTwoBounds',params.catBounds);
				% % three-parameter model, diagonal boundary, one sigmoid (slope, offset, lapse)
				% [theta_hat_fixed_oneBound(ii,:,:),negLL_fixed_oneBound(ii,:)] = fitBoundaryModelTT(X,Y_north,Y_south,params.initVals(3:end),params.allBounds(3:end,1),params.allBounds(3:end,2),'fixedOneBound',params.diagBounds);

				% 4. convert boundary estimates into distance to optimal boundary d(phi_hat,phi_true)
				bias_free_twoBounds(ii,1) = compute_boundaryBias(squeeze(theta_hat_free_twoBounds(ii,:,1)),params.catBounds(1),'north');
				bias_free_twoBounds(ii,2) = compute_boundaryBias(squeeze(theta_hat_free_twoBounds(ii,:,2)),params.catBounds(2),'south');

				bias_free_twoBoundsAndSigmoids(ii,1) = compute_boundaryBias(squeeze(theta_hat_free_twoBoundsAndSigmoids(ii,:,1)),params.catBounds(1),'north');
				bias_free_twoBoundsAndSigmoids(ii,2) = compute_boundaryBias(squeeze(theta_hat_free_twoBoundsAndSigmoids(ii,:,2)),params.catBounds(2),'south');



				% 5. convert nLL into LL and compute [A/B]IC
				bic_free_twoBounds(ii) = compute_BIC(-negLL_free_twoBounds(ii,:),size(theta_hat_free_twoBounds,3),params.numObs);
				bic_free_twoBoundsAndSigmoids(ii) = compute_BIC(-negLL_free_twoBoundsAndSigmoids(ii,:),size(theta_hat_free_twoBoundsAndSigmoids,3),params.numObs);
				bic_free_oneBound(ii) = compute_BIC(-negLL_free_oneBound(ii,:),size(theta_hat_free_oneBound,3),params.numObs);
				% bic_fixed_twoBounds(ii) = compute_BIC(-negLL_fixed_twoBounds(ii,:),size(theta_hat_fixed_twoBounds,3),params.numObs);
				% bic_fixed_oneBound(ii) = compute_BIC(-negLL_fixed_oneBound(ii,:),size(theta_hat_fixed_oneBound,3),params.numObs);
				% bic_fixed(ii) = compute_BIC(-negLL_fixed(ii,:),size(theta_hat_fixed,3),params.numObs);

			end
			% 6. store all results
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).slope  = squeeze(mean(theta_hat_free_twoBoundsAndSigmoids(:,:,[4,7]),3));
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).offset = squeeze(mean(theta_hat_free_twoBoundsAndSigmoids(:,:,[3,6]),3));
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).lapse  = squeeze(mean(theta_hat_free_twoBoundsAndSigmoids(:,:,[5,8]),3));
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).bias   = mean(squeeze(bias_free_twoBoundsAndSigmoids),2);	
			modelfits.free_twoBoundsAndSigmoids.(ep{1}).(g{1}).phi   = mean(squeeze(theta_hat_free_twoBoundsAndSigmoids(:,1:2)),2);
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

			% three parameter model, optimal boundaries (slope, offset, lapse)
			% modelfits.fixed_twoBounds.(ep{1}).(g{1}).slope  = squeeze(theta_hat_fixed_twoBounds(:,:,2));
			% modelfits.fixed_twoBounds.(ep{1}).(g{1}).offset = squeeze(theta_hat_fixed_twoBounds(:,:,1));
			% modelfits.fixed_twoBounds.(ep{1}).(g{1}).lapse  = squeeze(theta_hat_fixed_twoBounds(:,:,3));
			% modelfits.fixed_twoBounds.(ep{1}).(g{1}).phi    = []; % wasn't free parameter
			% modelfits.fixed_twoBounds.(ep{1}).(g{1}).nll    = negLL_fixed_twoBounds;
			% modelfits.fixed_twoBounds.(ep{1}).(g{1}).gof    =   bic_fixed_twoBounds;

			% % three-parameter model, diagonal boundary (slope, offset, lapse)
			% modelfits.fixed_oneBound.(ep{1}).(g{1}).slope  = squeeze(theta_hat_fixed_oneBound(:,:,2));
			% modelfits.fixed_oneBound.(ep{1}).(g{1}).offset = squeeze(theta_hat_fixed_oneBound(:,:,1));
			% modelfits.fixed_oneBound.(ep{1}).(g{1}).lapse  = squeeze(theta_hat_fixed_oneBound(:,:,3));
			% modelfits.fixed_oneBound.(ep{1}).(g{1}).phi    = []; % wasn't free parameter
			% modelfits.fixed_oneBound.(ep{1}).(g{1}).nll    = negLL_fixed_oneBound;
			% modelfits.fixed_oneBound.(ep{1}).(g{1}).gof    =   bic_fixed_oneBound;

			clearvars -except cmats params modelfits ep g;
		end
	end
	modelfits.free_twoBoundsAndSigmoids.numParams = 8;
	modelfits.free_twoBounds.numParams            = 5;
	modelfits.free_oneBound.numParams             = 4;
	% modelfits.fixed_twoBounds.numParams           = 3;
	% modelfits.fixed_oneBound.numParams            = 3;
end

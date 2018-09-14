function rew_corr_arena_main()
	%% REW_CORR_ARENA_MAIN()
	%
    % tries to correlate perceptual prior on gridiness with 
    % various measures from the main:
    % - accuracy
    % - slope of irrelevant dimension
    % - choice model correlations
    % The guiding hypothesis is that participants 
    % with a strong prior on the two pricipal dimensions 
    % should perform better at time of main (especially under cardinal boundary)
    % This makes the strong assumption of a linear relationship between said measures
    %
    	%
	% (C) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% Univerity of Oxford

	corrs           =                     struct();	
	curricula       = {'Blocked200','Interleaved'};
	boundary_groups =      {'cardinal','diagonal'};
	acc_curric      =               {'b200','int'};

	

	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			
			% load modelcorrs - Pre
			load(['tauas_features_modelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' 'pre' '_premainpost_allindia.mat']);
			taus_pre = tauas_features;
			x = squeeze(taus_pre(:,3)); % grid taus
			
			%% 1. ACCURACY
			% predictions:
			% the stronger the prior, the better the performance. why? easier to learn tasks
						
			% load accuracies
			load(['acc_all_premainpost_allindia_' boundary_groups{bIDX} '.mat']);
			y = acc_all.test.(acc_curric{cIDX})';
			% compute correlations
			[r,p,cl,cu] = corrcoef(x,y);
            corrs.acc.rho(bIDX,cIDX) = squeeze(r(1,2));
            corrs.acc.p(bIDX,cIDX)   = squeeze(p(1,2));
            corrs.acc.cl_l(bIDX,cIDX) = squeeze(cl(1,2));
            corrs.acc.cl_u(bIDX,cIDX) = squeeze(cu(1,2));			


			%% 2. ROBUSTNESS against intrusion of irrelevant dimension
			% predictions:
			% the stronger the prior, the shallower the slope (= less intrusion). why? less likely to confuse tasks
			
			% load slopes 
			load(['slopes_premainpost_' boundary_groups{bIDX} '_allindia.mat']);
			y = squeeze(results.sigm_params.test.(acc_curric{cIDX}).irrel.sigma(:,1));
			% compute correlations
			[r,p,cl,cu] = corrcoef(x,y);
            corrs.irrel.rho(bIDX,cIDX) = squeeze(r(1,2));
            corrs.irrel.p(bIDX,cIDX)   = squeeze(p(1,2));
            corrs.irrel.cl_u(bIDX,cIDX) = squeeze(cu(1,2));
            corrs.irrel.cl_l(bIDX,cIDX) = squeeze(cl(1,2));



			% %% 3. CHOICE MODEL correlations
			% % predictions
			% % the stronger the prior, the stronger the correlations with the task models, the weaker the correlations with the 
			% % opposite task models and orthogonal models
			
			% %  load choice model corrs
			% load(['taus_modelcorrs_premainpost_' boundary_groups{bIDX} '_allindia.mat']);
			% taus_le = taus.test.(acc_curric{cIDX}).le;
			% taus_br = taus.test.(acc_curric{cIDX}).br;

			% % compute correlations for all task models
			% for mid = 1:size(taus_le,2)
			% 	y_le = squeeze(taus_le(:,mid));
			% 	y_br = squeeze(taus_br(:,mid));

			% 	% leaf 
			% 	[r,p,cl,cu] = corrcoef(x,y_le);
	  %           corrs.model.rho(bIDX,cIDX,mid,1) = squeeze(r(1,2));
	  %           corrs.model.p(bIDX,cIDX,mid,1)   = squeeze(p(1,2));
	  %           corrs.model.cl_u(bIDX,cIDX,mid,1) = squeeze(cu(1,2));
	  %           corrs.model.cl_l(bIDX,cIDX,mid,1) = squeeze(cl(1,2));				

	  %           % branch
	  %           [r,p,cl,cu] = corrcoef(x,y_br);
	  %           corrs.model.rho(bIDX,cIDX,mid,2) = squeeze(r(1,2));
	  %           corrs.model.p(bIDX,cIDX,mid,2)   = squeeze(p(1,2));
	  %           corrs.model.cl_u(bIDX,cIDX,mid,2) = squeeze(cu(1,2));
	  %           corrs.model.cl_l(bIDX,cIDX,mid,2) = squeeze(cl(1,2));				
			% end



			%% 4. DECISION BOUNDARY BIAS
			% predictions:
			% the stronger the prior, the better the task-separability, the closer is this bound to the ground-truth boundary
			% -> the higher the prior, the lower the bias

			% load db orientation
			load(['results_biases_fminconresults_withlapse_premainpost_' boundary_groups{bIDX} '_allindia.mat']);			
			y = abs(results.test.(acc_curric{cIDX}).bias);
			% compute correlations
			[r,p,cl,cu] = corrcoef(x,y);
            corrs.decisionbound.rho(bIDX,cIDX) = squeeze(r(1,2));
            corrs.decisionbound.p(bIDX,cIDX)   = squeeze(p(1,2));
            corrs.decisionbound.cl_u(bIDX,cIDX) = squeeze(cu(1,2));
            corrs.decisionbound.cl_l(bIDX,cIDX) = squeeze(cl(1,2));

		end
	end

	save('results_corr_arena_withlapse_accuracy.mat','corrs');


	% % Now, assess whether the correlations differ significantly
	% corrDiffs = [];
	% rhos = corrs.rho(:);
	% tmp_dataLengths = tmp_dataLengths(:);
	% for ii= 1:4
	% 	for jj= 1:4
	% 		if (ii < jj)
	% 			% note: this function is dodgy!!
	% 			corrDiffs = [corrDiffs, compare_correlation_coefficients(rhos(ii),rhos(jj),tmp_dataLengths(ii),tmp_dataLengths(jj))];
	% 		end
	% 	end
	% end

	% save('results_corrDiffs_arena_accuracy.mat','corrDiffs');

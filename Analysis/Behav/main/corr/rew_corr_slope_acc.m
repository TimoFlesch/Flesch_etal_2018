function corrs = rew_corr_slope_acc()
	%% REW_CORR_SLOPE_ACC()
	%
	% computes correlation between slopes and accuracy
	% for training, test and all groups
	% 
	%  OUTPUT
	% - corrs: struct with correlation coefficients, p-values as well as CIs 
	% 
	% Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	%% 1. define fieldnames
	corrs           =                     struct();	
	curricula       =    {'b200','b20','b2','int'};
	exp_phases      =             {'train','test'};
	boundary_groups =      {'cardinal','diagonal'};
	

	%% 2. iterate through and compute 
	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			for ep = exp_phases
				% accuracy 
				load(['acc/acc_all_' boundary_groups{bIDX} '.mat']);
				accs = acc_all.(ep{1}).(curricula{cIDX})';
				% slopes
				load(['slopes_and_bounds/slopes_' boundary_groups{bIDX} '_all.mat']);
				slopes = squeeze(sigmas.sigm_params.(ep{1}).(curricula{cIDX}).irrel.sigma(:,1));

				[r,p,cl,cu] = corrcoef(slopes,accs);
	            corrs.(ep{1}).rho(bIDX,cIDX)  =  squeeze(r(1,2));
	            corrs.(ep{1}).p(bIDX,cIDX)    =  squeeze(p(1,2));
	            corrs.(ep{1}).cl_l(bIDX,cIDX) = squeeze(cl(1,2));
	            corrs.(ep{1}).cl_u(bIDX,cIDX) = squeeze(cu(1,2));	

			end
		end
	end

	save('slopes_and_bounds/results_corr_acc_irrelslope_all.mat','corrs');

end

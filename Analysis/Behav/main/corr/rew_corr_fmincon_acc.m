function corrs = rew_corr_fmincon_acc()
	%% REW_CORR_FMINCON_ACC()
	%
	% computes partial correlation between fmincon model parameters and accuracy
	% for training, test and all groups
	% 
	%  OUTPUT
	% - corrs: struct with correlation coefficients, p-values as well as CIs, one field for each parameter
	% 
	% Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	%% 1. define fieldnames
	corrs           =                          struct();	
	% curricula       =         {'b200','b20','b2','int'};
	curricula       =        			 {'b200','int'};
	exp_phases      =                  {'train','test'};
	boundary_groups =           {'cardinal','diagonal'};
	parameters      = {'bias','slope','offset','lapse'};
	gridID          =                    {'low','high'};
	

	%% 2. iterate through and compute 
	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			load(['acc_all_highVSlowGridiness_' boundary_groups{bIDX} '_allindia.mat']);
			for gid = 1:length(gridID)
				load(['results_biases_fminconresults_withlapse_' gridID{gid} 'Gridiness_' boundary_groups{bIDX} '_allindia.mat']);
				for ep = exp_phases
					for parm = parameters
						% accuracy 
						accs = acc_all.(['accuracy_' gridID{gid}]).(ep{1}).(curricula{cIDX})';
						% param_estimates
						param_estimates = squeeze(results.(ep{1}).(curricula{cIDX}).(parm{1}));

						[r,p,cl,cu] = corrcoef(param_estimates,accs);
			            corrs.(gridID{gid}).(ep{1}).(parm{1}).rho(bIDX,cIDX)  =  squeeze(r(1,2));
			            corrs.(gridID{gid}).(ep{1}).(parm{1}).p(bIDX,cIDX)    =  squeeze(p(1,2));
			            corrs.(gridID{gid}).(ep{1}).(parm{1}).cl_l(bIDX,cIDX) = squeeze(cl(1,2));
			            corrs.(gridID{gid}).(ep{1}).(parm{1}).cl_u(bIDX,cIDX) = squeeze(cu(1,2));	
		            end
				end
			end
		end
	end

	save('results_corr_acc_fmincon_lowVShighGridiness_allindia.mat','corrs');

end

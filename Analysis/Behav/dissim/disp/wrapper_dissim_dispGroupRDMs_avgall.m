function wrapper_dissim_dispGroupRDMs_avgall()
	%% WRAPPER_DISSIM_DISPGROUPRDMS_AVGALL()
	%
	% wrapper function to plot group level rdms of all 
	% curriculum groups, boundary groups and phases
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	curricula       = {'Blocked200','Interleaved'};
	exp_phases      =               {'pre','post'};
	boundary_groups =      {'cardinal','diagonal'};

	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			for eIDX = 1:length(exp_phases)
				% load data
				load(['dissimData_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '_premainpost_allindia.mat']);
				load(['rdmSet_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '_premainpost_allindia.mat']);
				titleStr = [curricula{cIDX} ', ' boundary_groups{bIDX}  ', ' upper(exp_phases{eIDX})];
				% render and save image
				dissim_dispGroupRDMs_avgall(rdmSet,dissimData,titleStr);
			end
		end
	end

end

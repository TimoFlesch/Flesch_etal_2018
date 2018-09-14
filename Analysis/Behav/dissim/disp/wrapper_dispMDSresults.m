function wrapper_dispMDSresults()
	%% WRAPPER_DISPMDSRESULTS()
	%
	% wrapper to display group level MDS plots of all 
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
				% perform MDS
				mdsSet = dissim_performMDS(rdmSet);
				% render and save image
				dissim_dispMDSresults(mdsSet,dissimData,titleStr);
			end
		end
	end
end
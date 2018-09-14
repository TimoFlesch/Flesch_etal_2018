function wrapper_dissim_disp_RDMdendrogram()
	%% WRAPPER_DISSIM_DISP_RDMDENDROGRAM()
	%
	% wrapper for dendrogram function
	% loops through ALL the data
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
				load(['rdmSet_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '_premainpost_allindia.mat']);
				titleStr = [curricula{cIDX} ', ' boundary_groups{bIDX}  ', ' upper(exp_phases{eIDX})];
				rdm = squeeze(mean(mean(rdmSet,2),1));
				dissim_disp_RDMdendrogram(rdm,titleStr);
			end
		end
	end

end
function wrapper_computePixelRDMs()
	%% WRAPPER_COMPUTEPIXELRDMS()
	%
	% wrapper function to compute RDMs based
	% on pixel-wise similarity of raw trial-specific stimulus files
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	curricula       = {'B200','INT'};
	exp_phases      =               {'pre','post'};
	boundary_groups =      {'cardinal','diagonal'};

	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			for eIDX = 1:length(exp_phases)
				load(['dissimData_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat']);
				rdmSet = dissim_computePixelRDMs(dissimData);
				save(['rdmSet_pixelRDMs_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat'],'rdmSet');

			end
		end
	end

end

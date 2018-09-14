function wrapper_dispSsArrangements_allGroups()
%% WRAPPER_DISPSSARRANGEMENTS_ALLGROUPS()
%
% creates figures of single subject dissim arrangements, one per 
% subject and phase, with subplots for each trial
% 
% iterates through different curriculum groups, phases and boundary groups
%
% (c) Timo Flesch, 2017

% curricula       = {'Blocked200','Interleaved'};
exp_phases      =               {'pre','post'};
boundary_groups =      {'cardinal','diagonal'};

% for cIDX = 1:length(curricula)
	for bIDX = 1:length(boundary_groups)
		for eIDX = 1:length(exp_phases)
			% load data
			% load(['dissimData_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '_premainpost_FULL.mat']);
			load(['dissimData_' boundary_groups{bIDX}  '_allSubs_' exp_phases{eIDX} '_premainpost_allindia.mat']);
			% titleStr = ['arrangementIMG_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX}];
			titleStr = ['arrangementIMG_' boundary_groups{bIDX}  '_allSubs_' exp_phases{eIDX}];

			% render and save image
			dissim_dispSsArrangements(dissimData,titleStr,1);
		end
	end
% end





end 

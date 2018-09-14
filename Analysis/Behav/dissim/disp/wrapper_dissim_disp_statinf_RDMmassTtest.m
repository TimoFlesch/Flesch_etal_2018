function wrapper_dissim_disp_statinf_RDMmassTtest()
	%% WRAPPER_DISSIM_DISP_STATINF_RDMMASSTTEST()
	%
	% Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford
    %(data,pvals,prepostID)


    expPhases = {'pre','post'};

	% load data
	load('pvals_diffBetweenGroupRDMs_statinf_premainpost_allindia.mat');
	load('dissimData_cardinal_groupBlocked200_post_premainpost_allindia.mat');
    for ii = 1%1:2%length(expPhases)

    	% plot stuff
    	dissim_disp_statinf_RDMmassTtest(dissimData,pvals,ii);
    	
    end
function dissim_disp_PrePostRDMCorrelations()
	%% DISSIM_DISP_PREPOSTRDMCORRELATIONS()
	%
	% plots results of pre post rdm correlations
	% for all groups
	% 
	% (c) Timo Flesch , 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford


	% 1. get data
	curricula       = {'Blocked200','Interleaved'};	
	boundary_groups =      {'cardinal','diagonal'};	
	gNames = {};
	allCorrs_mu = [];
	allCorrs_e = [];
	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			% load taus
			load(['tauas_PrePostRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_premainpost_ARENAONLY_goodsubs.mat']);
			allCorrs_mu = [allCorrs_mu, squeeze(mean(tauas',1))];
			allCorrs_e = [allCorrs_e,squeeze(std(tauas',0,1))./sqrt(size(tauas',1))];
			gNames = cat(2,gNames,[curricula{cIDX},', ', boundary_groups{bIDX}]);
			

		end		
	end
	allCorrs_mu
	allCorrs_e
	% 2. plot!
	figure();set(gcf,'Color','w');
	barwitherr(allCorrs_e,allCorrs_mu);
	set(gca,'XTickLabel',gNames);
	set(gca,'XTicklabelRotation',25);
	title('RDM Correlations between Pre and Post');
	ylabel('Kendall''s \tau_{a}');
	set(gcf,'Position',[403,134,808,532]);
	saveas(gcf,'tauas_prepost_IMG_premainpost_ARENAONLY_goodsubs.png');
	close all;

end

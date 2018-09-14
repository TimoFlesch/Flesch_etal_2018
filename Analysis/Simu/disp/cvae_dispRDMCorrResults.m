function cvae_dispRDMCorrResults(tauas)
	%% CVAE_DISPRDMCORRRESULTS(TAUAS)
	%
	% displays results of rdm model correlations
	%  branch, leaf, grid, branch-cluster, leaf-cluster models
	%
	% Timo Flesch, 2017

	betas = {'\beta = 1','\beta = 2','\beta = 6','\beta = 10','\beta = 50','\beta = 100'};

	figure(); set(gcf,'Color','w');
	b = bar(tauas);
	set(gca,'XTickLabel',{'Branch','Leaf','Branch-x-Leaf','BranchCluster-x-Leaf','Branch-x-LeafCluster'});
	set(gca,'XTickLabelRotation',25);
	hold on;
	ylabel('Kendall''s \tau_{a}');
	ylim([0,0.6]);
	legend(betas,'Location','NorthWest');
	title('RDM Model Correlations, \beta - CVAE Encoder Output');

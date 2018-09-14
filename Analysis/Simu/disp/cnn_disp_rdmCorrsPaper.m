function cnn_disp_rdmCorrsPaper(taus,boundName)
	%% CNN_DISP_RDMCORRSPAPPER(TAUS)
	%
	% displays rdm model correlations
	% - separately for both task orders
	% - and averaged across both
	% as bar plots with x ticks per layer and sub-bars per model
	%
	% Timo Flesch, 2017

	if ~exist('boundName')
		boundName = 'cardinal';
	end

	%% PARAMS
	curricula  = {'blocked','interleaved'};
	layerNames = {'Conv1','Conv2','FC1','FC2','Output'};
	% layerNames = {'FC1','FC2','Output'};
	modelNames = {'pixel model','factorised model','interference model','linear model'};


	%% MAIN

	% Both:

	tmp = cat(1,squeeze(taus.(boundName).blocked.ns.both(:,2,:,:)),squeeze(taus.(boundName).blocked.sn.both(:,2,:,:)));
	% tmp = squeeze(taus.(boundName).blocked.sn.both(:,2,:,:));
	data_blocked_mu = squeeze(mean(tmp,1));
	data_blocked_e = squeeze(std(tmp,0,1))./sqrt(size(tmp,1));
	f = helper_plot_corrs(data_blocked_mu,data_blocked_e,layerNames,modelNames)


end

function f = helper_plot_corrs(mu,e,layerNames,modelNames)
	figure();whitebg([1 1 1]);set(gcf,'Color','w');
	hb = barwitherr(e,mu,'LineWidth',1.5);
	colvals = linspace(0.15,0.8,length(hb));
	for ii = 1:length(hb)
		hb(ii).FaceColor = [1,1,1].*colvals(ii);
		hb(ii).EdgeColor = 'none';
	end
	ylim([0,0.8]);
	xlabel('Layer','FontName','Arial','FontSize',10);
	ylabel('Kendall''s \tau_{a}','FontName','Arial','FontSize',10);
	set(gca,'XTickLabel',layerNames,'FontName','Arial','FontSize',8,'FontWeight','bold');
	legend(hb,modelNames,'Box','Off','Location','NorthEast');
	set(gca,'TickDir','out')
	set(gca,'LineWidth',1)
	set(gca,'Box','off')
	set(gca,'YMinorTick','off');
	set(gca,'YGrid','off')
	set(gcf,'Position',[403,378,847,288]);
	f = gcf;
end

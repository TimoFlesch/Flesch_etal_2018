function cnn_disp_rdmCorrsPaper_vanillaVSpretrained(boundID,modID)
	%
	% displays rdm model correlations for factorised and interference model
	% - one plot per combination of boundary and model
	% - x ticks for layers, sub-bars for without and with prior (vanilla vs pretrained)
	%
	% Timo Flesch, 2017

	if ~exist('boundID')
		% a = cardinal
		% b = diagonal
		boundID = 'a';
		boundName = 'cardinal';
	end

	if (strcmp(boundID,'a'))
		boundName = 'cardinal';
	elseif (strcmp(boundID,'b'))
		boundName = 'diagonal';
	end

	if ~exist('modID')
		modID = 1;
	end

	%% PARAMS
		curricula  = {'blocked'};
	layerNames = {'FC1','FC2','Output'};
	modelNames = {'factorised model','interference model'};


	%% MAIN
	% load vanilla model taus and compute statistics for fact and interf model
	load(['taus_rsa_exp3ab.mat']);
	tmp = cat(1,squeeze(taus.(boundName).blocked.ns.both(:,2,3:5,2:3)),squeeze(taus.(boundName).blocked.sn.both(:,2,3:5,2:3)));
	data_vanilla_mu = squeeze(mean(tmp,1));
	data_vanilla_e = squeeze(std(tmp,0,1))./sqrt(size(tmp,1));

	% load pretrained model taus amd compute statistics for fact and interf model
	load(['taus_rsa_exp4b.mat']);
	tmp = cat(1,squeeze(taus.(boundName).blocked.ns.both(:,2,:,2:3)),squeeze(taus.(boundName).blocked.sn.both(:,2,:,2:3)));
	data_pretrained_mu = squeeze(mean(tmp,1));
	data_pretrained_e = squeeze(std(tmp,0,1))./sqrt(size(tmp,1));

	f = helper_plot_corrcomparison([data_vanilla_mu(:,modID),data_pretrained_mu(:,modID)],[data_vanilla_e(:,modID),data_pretrained_e(:,modID)],layerNames,boundName,modelNames{modID});

end

function f = helper_plot_corrcomparison(mu,e,layerNames,boundName,modelName)
	figure();set(gcf,'Color','w');
	hb = barwitherr(e,mu,'LineWidth',1.5);
	colvls = [.5,.8];
	for ii = 1:length(colvls)
		hb(ii).FaceColor = [1,1,1].*colvls(ii);
		hb(ii).EdgeColor     = 'none';
	end
	% hb(1).FaceColor = [242,83,83]./255;
	% hb(2).FaceColor = [144,255,127]./255;
	% ylim([0,0.8]);
	xlabel('Layer','FontName','Arial','FontSize',10);
	ylabel({['Correlation with ' modelName ' ModelRDM (\tau_{a})']; [boundName ' bound']},'FontName','Arial','FontSize',10);
	set(gca,'XTickLabel',layerNames,'FontName','Arial','FontSize',8,'FontWeight','bold');
	legend(hb,{'No Prior', 'Prior'},'Box','Off','Location','NorthEastOutside');
	set(gca,'TickDir','out')
	set(gca,'LineWidth',1)
	set(gca,'Box','off')
	set(gca,'YMinorTick','off');
	set(gca,'YGrid','off')
	% set(gcf,'Position',[871,490,406,238]);
	f = gcf;
end

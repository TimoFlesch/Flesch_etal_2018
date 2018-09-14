function disp_choicemodel_paramrecovery()
	%% DISP_CHOICEMODEL_PARAMRECOVERY()
	% plot true parameters vs recovered parameters
	% (title: name, corrcoef, p-value)
	% for all choicemodel parameters
	%
	% Timo Flesch, 2017

	boundaryCodes = {'cardinal','diagonal'}
	taskDim    = {'north','south'};
	paramNames = {'orientation','offset','slope','lapse'};

	% loop through boundaries
	for (ii_bnd = 1:length(boundaryCodes))
		% load data
		load(['allParams_' boundaryCodes{ii_bnd}]);
		load(['recoveredParams_' boundaryCodes{ii_bnd}]);
		load(['rhos_' boundaryCodes{ii_bnd}]);
		figure();set(gcf,'Color','w');
		% loop through parameters
		for (ii_prm = 1:length(paramNames))
			recov_prm = [squeeze(recoveredParams.(paramNames{ii_prm}).north(:,ii_prm)),squeeze(recoveredParams.(paramNames{ii_prm}).south(:,ii_prm))];
			true_prm = [squeeze(allParams.north(:,ii_prm)),squeeze(allParams.south(:,ii_prm))];
			subplot(2,4,ii_prm);
			scatter(true_prm(:,1),recov_prm(:,1),40,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[.2 .2 .2],'LineWidth',2);
			xlim([min(true_prm(:,1)),max(true_prm(:,1))]);
			ylim([min(true_prm(:,1)),max(true_prm(:,1))]);
			hold on; plot([min(true_prm(:,2)),max(true_prm(:,2))],[min(true_prm(:,2)),max(true_prm(:,2))],'k-');
			title([ paramNames{ii_prm} ' north task, \rho = ' num2str(round(10000*rhos.corrs.(paramNames{ii_prm}).north(2,1))/10000)]);
			xlabel('true parameter');
			ylabel('recovered parameter');
			axis square;

			subplot(2,4,ii_prm+4);
			scatter(true_prm(:,2),recov_prm(:,2),40,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[.7 .7 .7],'LineWidth',2);
			xlim([min(true_prm(:,2)),max(true_prm(:,2))]);
			ylim([min(true_prm(:,2)),max(true_prm(:,2))]);
			hold on; plot([min(true_prm(:,2)),max(true_prm(:,2))],[min(true_prm(:,2)),max(true_prm(:,2))],'k-');
			title([ paramNames{ii_prm} ' south task, \rho = ' num2str(round(10000*rhos.corrs.(paramNames{ii_prm}).south(2,1))/10000) ]);
			xlabel('true parameter');
			ylabel('recovered parameter');
			axis square;

		end
	end


end

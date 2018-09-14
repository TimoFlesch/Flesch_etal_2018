function disp_gridprior_taus(taus)
	%% DISP_GRIDPRIOR_TAUS(TAUS)
	%
	% modelcorr median split high vs low prior
	%
	% Timo Flesch, 2017



	figure();whitebg([1 1 1]);set(gcf,'Color','w');
	y = [mean(taus.modelcorrs_low.test.b200(:,1)),mean(taus.modelcorrs_low.test.int(:,1));mean(taus.modelcorrs_high.test.b200(:,1)),mean(taus.modelcorrs_high.test.int(:,1))]';
	e = [std(taus.modelcorrs_low.test.b200(:,1),0,1)./sqrt(length(taus.modelcorrs_low.test.b200(:,1))),std(taus.modelcorrs_low.test.int(:,1),0,1)./sqrt(length(taus.modelcorrs_low.test.int(:,1)));std(taus.modelcorrs_high.test.b200(:,1),0,1)./sqrt(length(taus.modelcorrs_high.test.b200(:,1))),std(taus.modelcorrs_high.test.int(:,1),0,1)./sqrt(length(taus.modelcorrs_high.test.int(:,1)))]';
	hb = barwitherr(e,y,'LineWidth',1.5);
	hb(1).FaceColor = [1 1 1].*0.5; % low prior
	% hb(1).FaceColor = [242, 83, 83]./255;
	hb(2).FaceColor = [1 1 1].*0.8; % high prior
	% hb(2).FaceColor = [144, 255, 127]./255;
	hb(1).EdgeColor = 'none';
	hb(2).EdgeColor = 'none';

	xlabel('\bf Group', 'FontName', 'Arial', 'FontSize',10);
	% ylabel({'\bf Accuracy (%)'}, 'FontName', 'Arial', 'FontSize',10);
	set(gca,'XTicklabel',{'B200', 'INT'},'FontName', 'Arial', 'FontSize',10,'FontWeight','normal');
	ylabel({'\bf RDM Correlation (Kendall''s \tau_{a})'}, 'FontName', 'Arial', 'FontSize',10);
	ylim([0,.4])
	set(gca,'YTick',0:0.1:0.4);
	legend([hb(1),hb(2)],{'Low Prior','High Prior'},'Location','NorthEastOutside','Box','off');

	set(gca,'YMinorTick','off');
	set(gca,'XMinorTick','off');
	set(gca,'TickDir','out');
	set(gca,'YGrid','off');
	set(gca,'LineWidth',1);


	set(gca,'Box','off');

end

function disp_gridprior_accuracy(acc_all)
	%% DISP_GRIDPRIOR_ACCURACY(ACC_ALL)
	%
	% accuracy median split high vs low prior
	%
	% Timo Flesch, 2017



	figure();whitebg([1 1 1]);set(gcf,'Color','w');
	y = [mean(acc_all.accuracy_low.test.b200),mean(acc_all.accuracy_low.test.int);mean(acc_all.accuracy_high.test.b200),mean(acc_all.accuracy_high.test.int)]';
	e = [std(acc_all.accuracy_low.test.b200,0,2)./sqrt(length(acc_all.accuracy_low.test.b200)),std(acc_all.accuracy_low.test.int,0,2)./sqrt(length(acc_all.accuracy_low.test.int));std(acc_all.accuracy_high.test.b200,0,2)./sqrt(length(acc_all.accuracy_high.test.b200)),std(acc_all.accuracy_high.test.int,0,2)./sqrt(length(acc_all.accuracy_high.test.int))]';
	hb = barwitherr(e,y,'LineWidth',2.5);
	hb(1).FaceColor = [1 1 1].*0.5; % low prior
	% hb(1).FaceColor = [242, 83, 83]./255;
	hb(2).FaceColor = [1 1 1].*0.8; % high prior
	% hb(2).FaceColor = [144, 255, 127]./255;
	hb(1).EdgeColor = 'none';
	hb(2).EdgeColor = 'none';

	xlabel('\rm Group', 'FontName', 'Arial', 'FontSize',10);
	ylabel({'\rm Accuracy (%)'}, 'FontName', 'Arial', 'FontSize',10);
	set(gca,'XTicklabel',{'B200', 'INT'},'FontName', 'Arial', 'FontSize',10,'FontWeight','normal');
	% ylabel({'\bf RDM Correlation (Kendall''s \tau_{a})'}, 'FontName', 'Arial', 'FontSize',10);
	ylim([.5,1]);
	set(gca,'YTick',[.5:.1:1])
	set(gca,'YTicklabel',get(gca,'YTick')*100,'FontName', 'Arial', 'FontSize',10,'FontWeight','normal');
	legend([hb(1),hb(2)],{'Low Prior','High Prior'},'Location','NorthEastOutside','Box','off');

	set(gca,'YMinorTick','off');
	set(gca,'XMinorTick','off');
	set(gca,'TickDir','out');
	set(gca,'YGrid','off');
	set(gca,'LineWidth',1);


	set(gca,'Box','off');

end

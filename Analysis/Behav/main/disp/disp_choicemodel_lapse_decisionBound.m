function disp_choicemodel_lapse_decisionBound(results,subGroup)
	 %% DISP_CHOICEMODEL_LAPSE_DECISIONBOUND(ANGLES,SUBGROUPS)
	 %
	 % plots errorbarplots of mean lapse parameter of decision boundary to category boundary for all groups
	 %
	 % Timo Flesch, 2017
	 % Summerfield Lab, Experimental Psychology Department,
	 % University of Oxford

	% Lapse - Training
	% helper_barplots_lapse(results.train,'Training',subGroup);

	% Lapse - Test
	helper_barplots_lapse(results.test,'Test',subGroup);

end

function helper_barplots_lapse(results,sessionCode,subGroup)
	%
	% plots bar plot for the different groups
	angleFields = fieldnames(results);
	colvals = linspace(0.2,0.8,length(angleFields));

	for ii = 1:length(angleFields)
		results.(angleFields{ii}) = results.(angleFields{ii}).lapse;
	end
	if strcmp(subGroup,'exp1')
		 meanVals_results = [mean(results.b200),mean(results.b20),mean(results.b2),mean(results.int)];
		errVals_results = [std(results.b200,0,1)./sqrt(length(results.b200)),std(results.b20,0,1)./sqrt(length(results.b20)),std(results.b2,0,1)./sqrt(length(results.b2)),std(results.int,0,1)./sqrt(length(results.int))];
	else
		meanVals_results = [mean(results.b200),mean(results.int)];
		errVals_results = [std(results.b200,0,1)./sqrt(length(results.b200)),std(results.int,0,1)./sqrt(length(results.int))];
	end

	figure();whitebg([1 1 1]);set(gcf,'Color','w');
	b1 = bar(1,meanVals_results(1),'LineWidth',1.5);
	b1.FaceColor = [1,1,1].*colvals(1);
	hold on;
	if strcmp(subGroup,'exp1')
		b2 = bar(2,meanVals_results(2),'LineWidth',1.5,'EdgeColor','none');
		b2.FaceColor = [1 1 1].*colvals(2);
		b3 = bar(3,meanVals_results(3),'LineWidth',1.5,'EdgeColor','none');
		b3.FaceColor = [1,1,1].*colvals(3);
		b4 = bar(4,meanVals_results(4),'LineWidth',1.5,'EdgeColor','none');
		b4.FaceColor = [1,1,1].*colvals(4);
	else
		b4 = bar(2,meanVals_results(2),'LineWidth',1.5,'EdgeColor','none');
		b4.FaceColor = [1,1,1].*colvals(2);
	end
	hold on;

	errorbar(meanVals_results,errVals_results,'LineStyle','none','Color','k','LineWidth',2.5);
	xlabel('\bf Group', 'FontName', 'Arial', 'FontSize',10);
	ylabel({'\bf Lapse (%)'}, 'FontName', 'Arial', 'FontSize',10);

	if strcmp(subGroup,'exp1')
		set(gca,'XTick',1:4);

		set(gca,'XTicklabel',{'B200', 'B20', 'B2', 'INT'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');

	else
		set(gca,'XTick',1:2);
		set(gca,'XTicklabel',{'B200', 'INT'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');

	end
	ylim([0,.1]);
	set(gca,'YTick',[0:.02:.1])
	set(gca,'YTickLabel',get(gca,'YTick').*100,'FontName','Arial', 'FontSize',8,'FontWeight','bold');


	set(gca,'YMinorTick','off');
	set(gca,'XMinorTick','off');
	set(gca,'TickDir','out');
	set(gca,'YGrid','off');

	set(gca,'LineWidth',1);
	set(gca,'Box','off');
	set(gcf,'Position',[403,277,734,389]);

end

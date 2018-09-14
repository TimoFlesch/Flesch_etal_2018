function disp_choicemodel_slopes_decisionBound(results,boundaryCode,subGroup)
	 %% DISP_CHOICEMODEL_SLOPES_DECISIONBOUND(ANGLES,BOUNDARYCODE)
	 %
	 % plots errorbarplots of mean slopes of sigmoidal transducer for all groups
	 %
	 % Timo Flesch, 2017
	 % Summerfield Lab, Experimental Psychology Department,
	 % University of Oxford

	% Slopes - Training
	% helper_barplots_slope(results.train,'Training',boundaryCode,subGroup);

	% Slopes - Test
	helper_barplots_slope(results.test,'Test',boundaryCode,subGroup);

end

function helper_barplots_slope(results,sessionCode,boundaryCode,subGroup)
	%
	% plots bar plot for the different groups
	angleFields = fieldnames(results);
	colvals = linspace(0.2,0.8,length(angleFields));


	for ii = 1:length(angleFields)
		results.(angleFields{ii}) = results.(angleFields{ii}).slope;
	end


	if strcmp(subGroup,'exp1')

		 meanVals_results = [mean(results.b200),mean(results.b20),mean(results.b2),mean(results.int)];
		errVals_results = [std(results.b200,0,1)./sqrt(length(results.b200)),std(results.b20,0,1)./sqrt(length(results.b20)),std(results.b2,0,1)./sqrt(length(results.b2)),std(results.int,0,1)./sqrt(length(results.int))];
	else
		meanVals_results = [mean(results.b200),mean(results.int)];
		errVals_results = [std(results.b200,0,1)./sqrt(length(results.b200)),std(results.int,0,1)./sqrt(length(results.int))];
	end

	figure();whitebg([.97 .97 .97]);set(gcf,'Color','w');

	b1 = bar(1,meanVals_results(1),'LineWidth',1.5,'EdgeColor','none');
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

	errorbar(meanVals_results,errVals_results,'LineStyle','none','Color','k');


	xlabel('\bf Group');
	ylabel({'\bf Mean Slope'; '\rm [a.u.]'});

	if strcmp(subGroup,'exp1')
		set(gca,'XTick',1:4);
		set(gca,'XTicklabel',{'B200', 'B20', 'B2', 'INT'});
	else
		set(gca,'XTick',1:2);
		set(gca,'XTicklabel',{'B200', 'INT'});
	end
	%set(gca,'YTicklabel',get(gca,'YTick')*100);
	title({['\bf Mean Slope of Sigmoidal Choice Function - ' sessionCode]; ['\rm' boundaryCode ' boundary']});
	 ylim([0.0,18]);
	set(gca,'Box','off');
	set(gcf,'Position',[403,277,734,389]);


end

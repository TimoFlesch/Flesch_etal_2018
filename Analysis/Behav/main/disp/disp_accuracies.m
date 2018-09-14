function disp_accuracies(acc_all)
%
% plot barplots for mean accuracies of train, test and test switch vs stay
%
% Timo Flesch, 2017

	% Accuracy - Training
	%helper_barplots_acc(acc_all.train,'Training');

	% Accuracy - Test
	% helper_barplots_acc(acc_all.test,'Test');

	% Accuracy - Test Task Switch vs Stay
	helper_barplots_switchvsstay(acc_all.test_taskSwitchVsStay,'asd');
	% % Accuracy - Test task/response switch/stay
	% helper_barplots_switchvsstay(acc_all.test_taskAndresponseSwitchVsStay,'Test: Stay vs Switch Trials ');

	% % Accuracy - Test
	% helper_barplots_firstVsSecond(acc_all.test_firstVsSecond,'Test: First vs Second Task ');

	% % Accuracy - Test, Only Stay Trials
	% helper_barplots_onlyStay(acc_all.test_switchVsStay,'Test: Only Stay ');

end

function helper_barplots_acc(acc,sessionCode)
%
% plots a bar plot of the four different groups

	groupNames = fieldnames(acc);
	colvals = linspace(0.2,0.8,length(groupNames));


	meanVals_acc = [mean(acc.b200),mean(acc.b20),mean(acc.b2),mean(acc.int)];
	errVals_acc = [std(acc.b200,0,2)./sqrt(length(acc.b200)),std(acc.b20,0,2)./sqrt(length(acc.b20)),std(acc.b2,0,2)./sqrt(length(acc.b2)),std(acc.int,0,2)./sqrt(length(acc.int))];
	% meanVals_acc = [mean(acc.b200),mean(acc.int)];
	% errVals_acc = [std(acc.b200,0,2)./sqrt(length(acc.b200)),std(acc.int,0,2)./sqrt(length(acc.int))];

	% figure();whitebg([.97 .97 .97]);set(gcf,'Color','w');
	figure();set(gcf,'Color','w');

	b1 = bar(1,meanVals_acc(1),'LineWidth',1.5,'EdgeColor','none');
	b1.FaceColor = [1,1,1].*colvals(1);
	hold on;
	b2 = bar(2,meanVals_acc(2),'LineWidth',1.5,'EdgeColor','none');
	b2.FaceColor = [1,1,1].*colvals(2);
	b3 = bar(3,meanVals_acc(3),'LineWidth',1.5,'EdgeColor','none');
	b3.FaceColor = [1,1,1].*colvals(3);
	b4 = bar(4,meanVals_acc(4),'LineWidth',1.5,'EdgeColor','none');
	b4.FaceColor = [1,1,1].*colvals(4);

	hold on;

	errorbar(meanVals_acc,errVals_acc,'LineStyle','none','Color','k','MarkerSize',5,'LineWidth',1.5);

	ylim([0.4 1]);
	xlabel('\bf Group', 'FontName', 'Arial', 'FontSize',10);
	ylabel({'\bf Test Accuracy (%)'}, 'FontName', 'Arial', 'FontSize',10);

	box off;
	ylim([.5,1]);
	set(gca,'YTick',[.5:.1:1])
	set(gca,'XTick',1:4);
	set(gca,'YTickLabel',get(gca,'YTick').*100,'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	% set(gca,'XTick',1:2);

	set(gca,'XTicklabel',{'B200', 'B20', 'B2', 'Interleaved'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	% set(gca,'XTicklabel',{'B200', 'Interleaved'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	set(gca,'YMinorTick','off');
	set(gca,'XMinorTick','off');
	set(gca,'TickDir','out');
	set(gca,'YGrid','off');
	set(gca,'LineWidth',1);


	% title({['\bf Mean Accuracy - ' sessionCode]; ['\rm' ' Boundary']});

	set(gca,'Box','off');
end


function helper_barplots_switchvsstay(acc,sessionCode)

	figure();%whitebg([.97 .97 .97]);
	set(gcf,'Color','w');

	accB200 = squeeze(acc.b200);
	accB20 = squeeze(acc.b20);
	accB2 = squeeze(acc.b2);
	accInt = squeeze(acc.int);

	% plot error bars
	meanIn = mean(accInt,1);
	errIn = std(accInt,0,1)./sqrt(size(accInt,1));

	meanBl2 = mean(accB2,1);
	errBl2 = std(accB2,0,1)./sqrt(size(accB2,1));

	meanBl20 = mean(accB20,1);
	errBl20 = std(accB20,0,1)./sqrt(size(accB20,1));

	meanBl200 = mean(accB200,1);
	errBl200 = std(accB200,0,1)./sqrt(size(accB200,1));


	[hb,eb] = barwitherr([errBl200;errBl20;errBl2;errIn],[meanBl200;meanBl20;meanBl2;meanIn],'LineWidth',1.5);
	% hb = barwitherr([errBl200;errIn],[meanBl200;meanIn]);

	hb(1).FaceColor = [0.0 0.8 0];
	hb(2).FaceColor = [0.8 0.0 0];
	hb(1).EdgeColor = 'none';
	hb(2).EdgeColor = 'none';

	ylim([0.4 1]);
	xlabel('\bf Group', 'FontName', 'Arial', 'FontSize',10);
	ylabel({'\bf Test Accuracy (%)'}, 'FontName', 'Arial', 'FontSize',10);

	box off;
	ylim([.5,1]);
	set(gca,'YTick',[.5:.1:1])
	set(gca,'XTick',1:4);
	set(gca,'YTickLabel',get(gca,'YTick').*100,'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	% set(gca,'XTick',1:2);
	set(gca,'XTicklabel',{'B200', 'B20', 'B2', 'Interleaved'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	% set(gca,'XTicklabel',{'B200', 'Interleaved'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	set(gca,'YMinorTick','off');
	set(gca,'XMinorTick','off');
	set(gca,'TickDir','out');
	set(gca,'YGrid','off');
	set(gca,'LineWidth',1);
	legend([hb(1),hb(2)],{'task stay','task switch'},'Box','off','Location','NorthEastOutside');
	% legend([hb(1),hb(2),hb(3),hb(4)],{'Task Stay, Response Stay','Task Stay, Response Switch', 'Task Switch, Response Stay','Task Switch, Response Switch'});
	% set(gca,'Box','off');
end



function helper_barplots_onlyStay(acc,sessionCode)
%
% plots a bar plot of the four different groups

	meanVals_acc = [squeeze(mean(acc.b200(:,:,1),1)),squeeze(mean(acc.b20(:,:,1),1)),squeeze(mean(acc.b2(:,:,1),1)),squeeze(mean(acc.int(:,:,1),1))];
	errVals_acc = [std(squeeze(acc.b200(:,:,1)),0,1)./sqrt(length(acc.b200(:,:,1))),std(squeeze(acc.b20(:,:,1)),0,1)./sqrt(length(acc.b20(:,:,1))),std(squeeze(acc.b2(:,:,1)),0,1)./sqrt(length(acc.b2(:,:,1))),std(squeeze(acc.int(:,:,1)),0,1)./sqrt(length(acc.int(:,:,1)))];

	figure();whitebg([.97 .97 .97]);set(gcf,'Color','w');

	b1 = bar(1,meanVals_acc(1),'EdgeColor','none');
	b1.FaceColor = [1,1,1].*colvals(1);
	hold on;
	b2 = bar(2,meanVals_acc(2),'EdgeColor','none');
	b2.FaceColor = [1,1,1].*colvals(2);

	b3 = bar(3,meanVals_acc(3),'EdgeColor','none');
	b3.FaceColor = [1,1,1].*colvals(3);
	b4 = bar(2,meanVals_acc(2),'EdgeColor','none');
	b4.FaceColor = [1,1,1].*colvals(4);

	hold on;

	errorbar(meanVals_acc,errVals_acc,'LineStyle','none','Color','k');

	ylim([0.4 1]);
	xlabel('\bf Group');
	ylabel({'\bf Mean Accuracy'; '\rm [%]'});

	set(gca,'XTick',1:4);
	set(gca,'XTicklabel',{'Blocked 200', 'Blocked 20', 'Blocked 2', 'Interleaved'});
	set(gca,'YTicklabel',get(gca,'YTick')*100);
	title({['\bf Mean Accuracy - ' sessionCode]; ['\rm' ' Boundary']});

	set(gca,'Box','off');
end



function helper_barplots_firstVsSecond(acc,sessionCode)


	figure();%whitebg([.97 .97 .97]);
	set(gcf,'Color','w');
	accB200 = squeeze(acc.b200);
	accB20  = squeeze(acc.b20);
	accB2   = squeeze(acc.b2);
	accInt  = squeeze(acc.int);


	% plot error bars
	meanIn = mean(accInt,1);
	errIn = std(accInt,0,1)./sqrt(size(accInt,1));

	meanBl2 = mean(accB2,1);
	errBl2 = std(accB2,0,1)./sqrt(size(accB2,1));

	meanBl20 = mean(accB20,1);
	errBl20 = std(accB20,0,1)./sqrt(size(accB20,1));

	meanBl200 = mean(accB200,1);
	errBl200 = std(accB200,0,1)./sqrt(size(accB200,1));

	hb = barwitherr([errBl200;errBl20;errBl2;errIn],[meanBl200;meanBl20;meanBl2;meanIn]);
	% hb = barwitherr([errBl200;errIn],[meanBl200;meanIn]);


	hb(1).FaceColor = [1 1 1].*0.8;
	hb(2).FaceColor = [1 1 1].*0.5;
	hb(1).EdgeColor = 'none';
	hb(2).EdgeColor = 'none';

	xlabel('\bf Group', 'FontName', 'Arial', 'FontSize',10);
	ylabel({'\bf Test Accuracy (%)'}, 'FontName', 'Arial', 'FontSize',10);

	box off;
	ylim([.5,1]);
	set(gca,'YTick',[.5:.1:1])
	set(gca,'XTick',1:4);
	set(gca,'YTickLabel',get(gca,'YTick').*100,'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	% set(gca,'XTick',1:2);
	set(gca,'XTicklabel',{'B200', 'B20', 'B2', 'Interleaved'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	% set(gca,'XTicklabel',{'B200', 'Interleaved'},'FontName','Arial', 'FontSize',8,'FontWeight','bold');
	set(gca,'YMinorTick','off');
	set(gca,'XMinorTick','off');
	set(gca,'TickDir','out');
	set(gca,'YGrid','off');
	set(gca,'LineWidth',1);
	legend([hb(1),hb(2)],{'First Task','Second Task'},'Box','off','Location','NorthEastOutside');

	set(gca,'Box','off');
end

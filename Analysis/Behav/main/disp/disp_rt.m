function disp_rt(rt_all,boundaryCode)
%
% plot barplots for nanmean rturacies of train, test and test switch vs stay

	% Accuracy - Training
	%helper_barplots_rt(rt_all.train,'Training',boundaryCode);
	% Accuracy - Training - Only Correct
	helper_barplots_rt(rt_all.train,'Training',boundaryCode);

	% Accuracy - Test
	%helper_barplots_rt(rt_all.test,'Test',boundaryCode);
	% Accuracy - Test
	helper_barplots_rt(rt_all.test,'Test',boundaryCode);



	% Accuracy - Test correct Trials Only
	helper_barplots_switchvsstay(rt_all.test_taskAndresponseSwitchVsStay,'Test: Stay vs Switch Trials ',boundaryCode);

end

function helper_barplots_rt(rt,sessionCode,boundaryCode)
%
% plots a bar plot of the four different groups

	nanmeanVals_rt = [nanmean(rt.b200),nanmean(rt.b20),nanmean(rt.b2),nanmean(rt.int)];
	% nanmeanVals_rt = [nanmean(rt.b200),nanmean(rt.int)];
	errVals_rt = [nanstd(rt.b200,0,1)./sqrt(length(rt.b200)),nanstd(rt.b20,0,1)./sqrt(length(rt.b20)),nanstd(rt.b2,0,1)./sqrt(length(rt.b2)),nanstd(rt.int,0,1)./sqrt(length(rt.int))]
	% errVals_rt = [nanstd(rt.b200,0,1)./sqrt(length(rt.b200)),nanstd(rt.int,0,1)./sqrt(length(rt.int))];

	figure();whitebg([.97 .97 .97]);set(gcf,'Color','w');
	b1 = bar(1,nanmeanVals_rt(1));
	b1.FaceColor = [0 0 0.8];
	hold on;
	b2 = bar(2,nanmeanVals_rt(2));
	b2.FaceColor = [0 0 0.5];
	b3 = bar(3,nanmeanVals_rt(3));
	b3.FaceColor = [0 0 0.2];
	b4 = bar(4,nanmeanVals_rt(4));
	b4.FaceColor = [0 0.5 0.5];
	hold on;

	errorbar(nanmeanVals_rt,errVals_rt,'LineStyle','none','Color','k');

	ylim([500 1300]);
	xlabel('\bf Group');
	ylabel({'\bf Mean RT'; '\rm [ms]'});

	set(gca,'XTick',1:2);
	set(gca,'XTicklabel',{'Blocked 200', 'Blocked 20', 'Blocked 2', 'Interleaved'});
	% set(gca,'XTicklabel',{'Blocked 200','Interleaved'});
	title({['\bf Mean Reaction Time - ' sessionCode]; ['\rm' boundaryCode ' Boundary']});

	set(gca,'Box','off');
end

function helper_barplots_switchvsstay(rt,sessionCode,boundaryCode)

	figure();whitebg([.97 .97 .97]);set(gcf,'Color','w');
	rtB200 = squeeze(rt.b200);
	rtB20 = squeeze(rt.b20);
	rtB2 = squeeze(rt.b2);
	rtInt = squeeze(rt.int);

	% plot error bars
	nanmeanIn = nanmean(rtInt,1);
	errIn = nanstd(rtInt,0,1)./sqrt(size(rtInt,1));

	nanmeanBl2 = nanmean(rtB2,1);
	errBl2 = nanstd(rtB2,0,1)./sqrt(size(rtB2,1));

	nanmeanBl20 = nanmean(rtB20,1);
	errBl20 = nanstd(rtB20,0,1)./sqrt(size(rtB20,1));

	nanmeanBl200 = nanmean(rtB200,1);
	errBl200 = nanstd(rtB200,0,1)./sqrt(size(rtB200,1));

	hb = barwitherr([errBl200;errBl20;errBl2;errIn],[nanmeanBl200;nanmeanBl20;nanmeanBl2;nanmeanIn]);
	% hb = barwitherr([errBl200;errIn],[nanmeanBl200;nanmeanIn]);

	% hb(1).FaceColor = [0.1 0.5 0];
	% hb(2).FaceColor = [0.5 0.1 0];
	ylim([500 1300]);
	xlabel('\bf Group');
	ylabel({'\bf Mean RT'; '\rm [ms]'});

	set(gca,'XTick',1:4);
	set(gca,'XTicklabel',{'Blocked 200', 'Blocked 20', 'Blocked 2', 'Interleaved'});
	% set(gca,'XTicklabel',{'Blocked 200','Interleaved'});
	title({['\bf Mean Reaction Time - ' sessionCode]; ['\rm' boundaryCode ' Boundary']});
	% legend([hb(1),hb(2)],{'Stay Trials','Switch Trials'});
	legend([hb(1),hb(2),hb(3),hb(4)],{'Task Stay, Response Stay','Task Stay, Response Switch', 'Task Switch, Response Stay','Task Switch, Response Switch'});
	set(gca,'Box','off');
end

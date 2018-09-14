function disp_logrt(rt_all,boundaryCode)
%
% plot barplots for mean rturacies of train, test and test switch vs stay

	% Accuracy - Training
	%helper_barplots_rt(rt_all.train,'Training',boundaryCode);
	% Accuracy - Training - Only Correct
	groupNames = fieldnames(rt_all.train);
	for ii = 1:4
		rt_all.train.(groupNames{ii}) = log(rt_all.train.(groupNames{ii}));
		rt_all.test.(groupNames{ii})  = log(rt_all.test.(groupNames{ii}));
		rt_all.test_switchVsStay.(groupNames{ii}) = log(rt_all.test_switchVsStay.(groupNames{ii}));
	end
	helper_barplots_rt(rt_all.train,'Training - Only Correct',boundaryCode);
	savefig(gcf,['logrt_' boundaryCode '_allavg_train_onlyCorrect.fig']);
	saveas(gcf,['logrt_' boundaryCode '_allavg_train_onlyCorrect.svg'],'svg');
	% Accuracy - Test
	%helper_barplots_rt(rt_all.test,'Test',boundaryCode);
	% Accuracy - Test
	helper_barplots_rt(rt_all.test,'Test - Only Correct',boundaryCode);
	savefig(gcf,['logrt_' boundaryCode '_allavg_test_onlyCorrect.fig']);
	saveas(gcf,['logrt_' boundaryCode '_allavg_test_onlyCorrect.svg'],'svg');


	% Accuracy - Test Stay Trials Only
	helper_barplots_switchvsstay(rt_all.test_switchVsStay,'Test - Only Correct: Stay vs Switch Trials ',boundaryCode);
	savefig(gcf,['logrt_' boundaryCode '_allavg_test_switchVsStay_onlyCorrect.fig']);
	saveas(gcf,['logrt_' boundaryCode '_allavg_test_switchVsStay_onlyCorrect.svg'],'svg');
end

function helper_barplots_rt(rt,sessionCode,boundaryCode)
%
% plots a bar plot of the four different groups

	meanVals_rt = [mean(rt.b200),mean(rt.b20),mean(rt.b2),mean(rt.int)]
	errVals_rt = [std(rt.b200,0,1)./sqrt(length(rt.b200)),std(rt.b20,0,1)./sqrt(length(rt.b20)),std(rt.b2,0,1)./sqrt(length(rt.b2)),std(rt.int,0,1)./sqrt(length(rt.int))]

	figure();whitebg([.97 .97 .97]);set(gcf,'Color','w');
	b1 = bar(1,meanVals_rt(1));
	b1.FaceColor = [0 0 0.8];
	hold on;
	b2 = bar(2,meanVals_rt(2));
	b2.FaceColor = [0 0 0.5];

	b3 = bar(3,meanVals_rt(3));
	b3.FaceColor = [0 0 0.2];
	b4 = bar(4,meanVals_rt(4));
	b4.FaceColor = [0 0.5 0.5];
	hold on;

	errorbar(meanVals_rt,errVals_rt,'LineStyle','none','Color','k');


	xlabel('\bf Group');
	ylabel({'\bf Log-RT'; '\rm [log ms]'});
	ylim([6,7.5])
	set(gca,'XTick',1:4);
	set(gca,'XTicklabel',{'Blocked 200', 'Blocked 20', 'Blocked 2', 'Interleaved'});
	title({['\bf Mean Log-RT - ' sessionCode]; ['\rm' boundaryCode ' Boundary']});

	set(gca,'Box','off');
end

function helper_barplots_switchvsstay(rt,sessionCode,boundaryCode)

	figure();whitebg([.97 .97 .97]);set(gcf,'Color','w');
	rtB200 = squeeze(rt.b200);
	rtB20 = squeeze(rt.b20);
	rtB2 = squeeze(rt.b2);
	rtInt = squeeze(rt.int);

	% plot error bars
	meanIn = mean(rtInt,1);
	errIn = std(rtInt,0,1)./sqrt(size(rtInt,1));

	meanBl2 = mean(rtB2,1);
	errBl2 = std(rtB2,0,1)./sqrt(size(rtB2,1));

	meanBl20 = mean(rtB20,1);
	errBl20 = std(rtB20,0,1)./sqrt(size(rtB20,1));

	meanBl200 = mean(rtB200,1);
	errBl200 = std(rtB200,0,1)./sqrt(size(rtB200,1));

	hb = barwitherr([errBl200;errBl20;errBl2;errIn],[meanBl200;meanBl20;meanBl2;meanIn]);

	hb(1).FaceColor = [0.1 0.5 0];
	hb(2).FaceColor = [0.5 0.1 0];

	xlabel('\bf Group');
	ylabel({'\bf Log-RT'; '\rm [log ms]'});
	ylim([6,7.5]);
	set(gca,'XTick',1:4);
	set(gca,'XTicklabel',{'Blocked 200', 'Blocked 20', 'Blocked 2', 'Interleaved'});
	title({['\bf Mean Log-RT - ' sessionCode]; ['\rm' boundaryCode ' Boundary']});
	legend([hb(1),hb(2)],{'Stay Trials','Switch Trials'});
	set(gca,'Box','off');
end

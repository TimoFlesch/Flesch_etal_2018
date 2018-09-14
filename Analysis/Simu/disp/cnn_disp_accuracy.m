function cnn_disp_accuracy(results)
%% CNN_DISP_ACCURACY()
% 
% plots learning curves and mean accuracies 
% for all models, codes, regimes 

if ~exist('lrID') 
	lrID = ''; 
else 
	lrID = [num2str(lrID)];
end

if ~exist('taskOrder') 
	taskOrder = 'ns'; 
end

% numRuns  = 5;
% runIDs   = [0:numRuns-1]; % python indexing

% numTestTrials = 10;
% numTestSessions = 2;
inputRegimes = {'blocked','interleaved'};
dimsIn = {'north','south'};

fID = 1;

					
% % learning curves:
lc_blocked     =     results.lcurves.blocked;
lc_interleaved = results.lcurves.interleaved;
helper_plot_learnincurves(lc_blocked,lc_interleaved, ['cnn, cardinal'],fID);
%savefig(['learningcurves_acc_cnn_cardinal_cnn_cvae_3D_beta1.fig'])
%saveas(gcf,['learningcurves_acc_cnn_cardinal_cnn_cvae_3D_beta1.svg'],'svg')
%saveas(gcf,['learningcurves_acc_cnn_cardinal_cnn_cvae_3D_beta1.png'],'png')


% mean accuracies, blocked:
accBoth = results.accuracies.mean.test.both.blocked;
errBoth = results.accuracies.std.test.both.blocked./sqrt(size(results.lcurves.blocked,1));

accNorth = results.accuracies.mean.test.first.blocked;
errNorth = results.accuracies.std.test.first.blocked./sqrt(size(results.lcurves.blocked,1));

accSouth = results.accuracies.mean.test.second.blocked;
errSouth = results.accuracies.std.test.second.blocked./sqrt(size(results.lcurves.blocked,1));


helper_plot_meanaccuracies([accBoth,accNorth,accSouth],[errBoth,errNorth,errSouth], ['blocked training, cnn, cardinal'],fID*10);
%savefig(['meanaccuracies_blocked_cnn_cardinal_cnn_cvae_3D_beta1.fig'])
%saveas(gcf,['meanaccuracies_blocked_cnn_cardinal_cnn_cvae_3D_beta1.svg'],'svg')
%saveas(gcf,['meanaccuracies_blocked_cnn_cardinal_cnn_cvae_3D_beta1.png'],'png')

% mean accuracies, interleaved:
accBoth = results.accuracies.mean.test.both.interleaved;
errBoth = results.accuracies.std.test.both.interleaved./sqrt(size(results.lcurves.interleaved,1));

accNorth = results.accuracies.mean.test.first.interleaved;
errNorth = results.accuracies.std.test.first.interleaved./sqrt(size(results.lcurves.interleaved,1));

accSouth = results.accuracies.mean.test.second.interleaved;
errSouth = results.accuracies.std.test.second.interleaved./sqrt(size(results.lcurves.interleaved,1));


helper_plot_meanaccuracies([accBoth,accNorth,accSouth],[errBoth,errNorth,errSouth], ['interleaved training, cnn, cardinal'],fID*100);
%savefig(['meanaccuracies_interleaved_cnn_cardinal_cnn_cvae_3D_beta1.fig'])
%saveas(gcf,['meanaccuracies_interleaved_cnn_cardinal_cnn_cvae_3D_beta1.svg'],'svg')
%saveas(gcf,['meanaccuracies_interleaved_cnn_cardinal_cnn_cvae_3D_beta1.png'],'png')


end 


function helper_plot_learnincurves(lc_blocked,lc_interleaved,titleStr,fID);
%% HELPER_PLOT_LEARNINGCURVES
% helpler function to plot learning curves 

if(~exist('fID')) 
	fID = 1111;
end 
addpath(genpath('/home/timo/Documents/MATLAB/Toolboxes/auxiliar/'))

figure(fID);whitebg([.97 .97 .97]); set(gcf,'Color','w'); 

pHandle1 = plot_timeSeriesWithSEM(lc_blocked,[0 0 0.8],fID);
hold on;
pHandle2 = plot_timeSeriesWithSEM(lc_interleaved,[0 0.5 0.5],fID);

title({['\bf Learning Curves - Accuracy']; ['\rm' titleStr]},'FontWeight','normal','FontSize',14);
ylabel({'\bf Accuracy'; '\rm [%]'});
xlabel({'\bf Trial';'\rm (total)'});
set(gca,'TickDir', 'out');
set(gca,'YGrid','on');

set(gca,'Box','off');
set(gca,'YMinorTick','off');
set(gca,'XMinorTick','on');
ylim([0.4 1]);
set(gca,'YTick',0.4:0.1:1);
set(gca,'YTickLabel',get(gca,'YTick')*100);

% plot(get(gca,'XLim'),[0.5 0.5],'k-');

plot([10 10],get(gca,'YLim'),'LineStyle','-.','Color',0.*[.7 .7 .7]);
% plot([2500 2500],get(gca,'YLim'),'LineStyle','-.','Color',0.*[.7 .7 .7]);
% plot([3750 3750],get(gca,'YLim'),'LineStyle','-.','Color',0.*[.7 .7 .7]);
plot(get(gca,'XLim'),[0.5 0.5],'k-');

text(3000,0.45,'\bf Training Phase 1');
text(13000,0.45,'\bf Training Phase 2');
% text(2800,0.45,'\bf Training Phase 3');
% text(4000,0.45,'\bf Training Phase 4');

legend([pHandle1{1},pHandle2{1}],{'Blocked','Interleaved'},'Location','East');
xlim([1,19900]);
set(gcf,'Position',[-1473,382,581*1.5,389]);

end


function helper_plot_meanaccuracies(meanAcc,errAcc,titleStr,fID)
%% HELPER_PLOT_MEANACCURACIES(MEANACC,ERRACC,TITLESTR,FID)
% helper function that plots mean accuracies of test blocks for both tasks 

if(~exist('fID')) 
	fID = 1111;
end 
addpath(genpath('/home/timo/Documents/MATLAB/Toolboxes/auxiliar/'))

figure(fID);whitebg([.97 .97 .97]); set(gcf,'Color','w'); 

bh = barwitherr(errAcc,meanAcc)
bh(1).FaceColor = [.6 .6 .6];
bh(2).FaceColor = [0 .1 .5];
bh(3).FaceColor = [0 .5 .1];
hold on;
plot(get(gca,'XLim'),[0.5 0.5],'k-.');
ylabel({'\bf Accuracy'; '\rm [%]'});
xlabel('\bf Test Session');
ylim([0.4 1]);
set(gca,'YTick',0.4:0.1:1);
set(gca,'YTickLabel',get(gca,'YTick')*100);
box off;
set(gca,'XTick',1:2)
set(gca,'XTickLabel',1:2)

legend([bh(1),bh(2),bh(3)],{'Both Tasks','First Task','Second Task'},'Location','NorthEastOutside');
title({'\bf Mean Accuracies, Test Sessions';['\rm' titleStr]},'FontSize',14);
set(gcf,'Position',[403,264,849,402]);
end
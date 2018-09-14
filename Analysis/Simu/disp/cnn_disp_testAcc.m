function cnn_disp_testAcc(results)
%% CNN_DISP_TESTACC()
%
% plots mean accuracies for both training regimes and test phases
% Timo Flesch, 2017

% mean accuracies, blocked:
accFirst_b = results.accuracies.mean.test.first.blocked;
errFirst_b = results.accuracies.std.test.first.blocked./sqrt(size(results.lcurves.blocked,1));
accSecond_b = results.accuracies.mean.test.second.blocked;
errSecond_b = results.accuracies.std.test.second.blocked./sqrt(size(results.lcurves.blocked,1));

accFirst_i = results.accuracies.mean.test.first.interleaved;
errFirst_i = results.accuracies.std.test.first.interleaved./sqrt(size(results.lcurves.interleaved,1));
accSecond_i= results.accuracies.mean.test.second.interleaved;
errSecond_i= results.accuracies.std.test.second.interleaved./sqrt(size(results.lcurves.interleaved,1));


helper_plot_meanaccuracies([accFirst_b(1),accSecond_b(1);accFirst_i(1),accSecond_i(1);accFirst_b(2),accSecond_b(2);accFirst_i(2),accSecond_i(2)],[errFirst_b(1),errSecond_b(1);errFirst_i(1),errSecond_i(1);errFirst_b(2),errSecond_b(2);errFirst_i(2),errSecond_i(2)]);

end


function helper_plot_meanaccuracies(meanAcc,errAcc)
%% HELPER_PLOT_MEANACCURACIES(MEANACC,ERRACC)
% helper function that plots mean accuracies of test blocks for both tasks


figure();whitebg([1 1 1]); set(gcf,'Color','w');

bh = barwitherr(errAcc,meanAcc,'LineWidth',1.5)
% bh(1).FaceColor = [255, 192, 125]./255;
bh(1).FaceColor = [1,1,1].*0.5;
bh(1).EdgeColor = 'none';
% bh(2).FaceColor = [95, 175, 201]./255;
bh(2).FaceColor = [1 1 1].*0.8;
bh(2).EdgeColor = 'none';
hold on; plot([2.5,2.5],get(gca,'YLim'),'k-')
plot(get(gca,'XLim'),[0.5 0.5],'k--');
% ylabel({'\bf Test Accuracy %'},'FontName','Arial','FontWeight','bold','FontSize',10);
% xlabel('\bf Test Session','FontName','Arial','FontWeight','bold','FontSize',8);

set(gca,'XTick',1:4)
set(gca,'XTickLabel',{'Blocked','INT','Blocked','INT'},'FontName','Arial','FontWeight','bold','FontSize',8);


ylabel({'\bf Test Accuracy (%)'}, 'FontName', 'Arial', 'FontSize',10);
ylim([.4,1]);
set(gca,'YTick',[.4:.1:1])
set(gca,'YTickLabel',get(gca,'YTick').*100,'FontName','Arial', 'FontSize',8,'FontWeight','bold');
set(gca,'YMinorTick','off');
set(gca,'TickDir','out');
set(gca,'YGrid','off');

set(gca,'LineWidth',1);
box off;
legend([bh(1),bh(2)],{'First Task','Second Task'},'Location','NorthEastOutside','Box','off');
set(gcf,'Position',[407,413,815,253]);

end

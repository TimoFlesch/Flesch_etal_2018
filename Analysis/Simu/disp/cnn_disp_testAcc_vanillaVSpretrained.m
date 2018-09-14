function cnn_disp_testAcc_vanillaVSpretrained(boundID)
	%% CNN_DISP_TESTACC_VANILLAVSPRETRAINED(BOUNDID)
	%
	% compares accuracy on first task after training on second task
	% between vanilla CNN and priorCNN
	%
	% Timo Flesch, 2018
	% Human Information Processing Lab
	% Experimental Psychology Department
	% University of Oxford

	if ~exist('boundID')
		% a = cardinal
		% b = diagonal
		boundID = 'a';
		boundName = 'cardinal';
	end

	if (strcmp(boundID,'a'))
		boundName = 'cardinal';
	elseif (strcmp(boundID,'b'))
		boundName = 'diagonal';
	end

	% load data
	load(['accuracy_exp3' boundID '.mat']);
	accSecond_vanilla = results.accuracies.mean.test.first.blocked(2,:);
	errSecond_vanilla = results.accuracies.std.test.first.blocked(2,:)./sqrt(size(results.lcurves.blocked,1));

	load(['accuracy_exp4b_' boundName '.mat']);
	accSecond_pretrained = results.accuracies.mean.test.first.blocked(2,:);
	errSecond_pretrained = results.accuracies.std.test.first.blocked(2,:)./sqrt(size(results.lcurves.blocked,1));

	helper_plot_accdiff([accSecond_vanilla,accSecond_pretrained],[errSecond_vanilla,errSecond_pretrained]);

end


function helper_plot_accdiff(meanAcc,errAcc)
%% HELPER_PLOT_ACCDIFF(MEANACC,ERRACC)
% helper function that plots performance of first task at test

if(~exist('fID'))
	fID = 1111;
end

figure(fID);whitebg([1 1 1]); set(gcf,'Color','w');

bh = bar(1,meanAcc(1),'LineWidth',1.5)
hold on;
% bh.FaceColor = [242,83,83]./255;
bh.FaceColor = [1,1,1].*0.5;
bh.EdgeColor = 'none';
errorbar(1,meanAcc(1),errAcc(1),'LineWidth',1.5,'Color','k');
bh = bar(2,meanAcc(2),'LineWidth',1.5)
% bh.FaceColor = [144,255,127]./255;
bh.FaceColor = [1,1,1].*0.8;
bh.EdgeColor = 'none';
errorbar(2,meanAcc(2),errAcc(2),'LineWidth',1.5,'Color','k');


hold on;
plot(get(gca,'XLim'),[0.5 0.5],'k--');

set(gca,'XTick',1:2)
set(gca,'XTickLabel',{'No Prior','Prior'},'FontName','Arial','FontWeight','bold','FontSize',8);


ylabel({'\bf Retained accuracy on first task (%)';'diagonal bounds'}, 'FontName', 'Arial', 'FontSize',10);
ylim([.4,1]);
set(gca,'YTick',[.4:.1:1])
set(gca,'YTickLabel',get(gca,'YTick').*100,'FontName','Arial', 'FontSize',8,'FontWeight','bold');
set(gca,'YMinorTick','off');
set(gca,'TickDir','out');
set(gca,'YGrid','off');

set(gca,'LineWidth',1);
box off;
set(gcf,'Position',[407,409,291,257]);

end

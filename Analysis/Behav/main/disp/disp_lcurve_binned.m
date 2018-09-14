function lc_binned = disp_lcurve_binned(allData)
%% DISP_LCURVE_BINNED(ALLDATA)
%
% displays binned accuracy as scatter plot with error bars
%
% Timo Flesch, 2017



lc = compute_pcorrect_learningCurves(allData,0)
bins_start =      1:50:400;
bins_stop  = bins_start+49;

bins_start_test =         401:200:600;
bins_stop_test  = bins_start_test+199;

lc_binned  = struct();
for ff = fieldnames(lc)'
	% training phase
	tmp = [];
	for subj = 1:size(lc.(ff{1}),2)
		for ii = 1:length(bins_start)
			tmp(ii,subj) = nanmean(lc.(ff{1})(bins_start(ii):bins_stop(ii),subj),1);
		end
	end
	lc_binned.(ff{1}).mu = nanmean(tmp,2);
	lc_binned.(ff{1}).e = std(tmp,0,2,'omitnan')./sqrt(size(tmp,2));
	% test phase:
	tmp = [];
	for subj =1:size(lc.(ff{1}),2)
		for ii = 1:length(bins_start_test)
			tmp(ii,subj) = nanmean(lc.(ff{1})(bins_start_test(ii):bins_stop_test(ii),subj),1);
		end
	end
	lc_binned.(ff{1}).mu  = [lc_binned.(ff{1}).mu; nanmean(tmp,2)];
	lc_binned.(ff{1}).e  = [lc_binned.(ff{1}).e; std(tmp,0,2,'omitnan')./sqrt(size(tmp,2))];

end
colvals = linspace(0.2,0.8,length(fieldnames(lc)'));

figure();set(gcf,'Color','w');
hb(1) = errorbar((1:50:200)+25,lc_binned.pMatBlock200.mu(1:4),lc_binned.pMatBlock200.e(1:4),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(1),'MarkerFaceColor',[1,1,1].*colvals(1),'LineWidth',1);
hb(1).Color = [1,1,1].*colvals(1);
hold on
hb(1) = errorbar((201:50:400)+25,lc_binned.pMatBlock200.mu(5:8),lc_binned.pMatBlock200.e(5:8),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(1),'MarkerFaceColor',[1,1,1].*colvals(1),'LineWidth',1);
hb(1).Color = [1,1,1].*colvals(1);
% hb(1) = errorbar((401:200:600)+25,lc_binned.pMatBlock200.mu(9:end),lc_binned.pMatBlock200.e(9:end),'o-','MarkerSize',5,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1,1,1].*colvals(1),'LineWidth',1);
% hb(1).Color = [1,1,1].*colvals(1);


hb(2) = errorbar((1:50:400)+25,lc_binned.pMatBlock20.mu(1:8),lc_binned.pMatBlock20.e(1:8),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(2),'MarkerFaceColor',[1,1,1].*colvals(2),'LineWidth',1);
hb(2).Color = [1,1,1].*colvals(2);
% hb(2) = errorbar((401:200:600)+25,lc_binned.pMatBlock20.mu(9:end),lc_binned.pMatBlock20.e(9:end),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(2),'MarkerFaceColor',[1,1,1].*colvals(2),'LineWidth',1);
% hb(2).Color = [1,1,1].*colvals(2);

hb(3) = errorbar((1:50:400)+25,lc_binned.pMatBlock2.mu(1:8),lc_binned.pMatBlock2.e(1:8),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(3),'MarkerFaceColor',[1,1,1].*colvals(3),'LineWidth',1);
hb(3).Color = [1,1,1].*colvals(3);
% hb(3) = errorbar((401:200:600)+25,lc_binned.pMatBlock2.mu(9:end),lc_binned.pMatBlock2.e(9:end),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(3),'MarkerFaceColor',[1,1,1].*colvals(3),'LineWidth',1);
% hb(3).Color = [1,1,1].*colvals(3);

hb(4) = errorbar((1:50:400)+25,lc_binned.pMatInt.mu(1:8),lc_binned.pMatInt.e(1:8),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(4),'MarkerFaceColor',[1,1,1].*colvals(4),'LineWidth',1);
hb(4).Color = [1,1,1].*colvals(4);

% hb(4) = errorbar((401:200:600)+25,lc_binned.pMatInt.mu(9:end),lc_binned.pMatInt.e(9:end),'o-','MarkerSize',5,'MarkerEdgeColor',[1,1,1].*colvals(4),'MarkerFaceColor',[1,1,1].*colvals(4),'LineWidth',1);
% hb(4).Color = [1,1,1].*colvals(4);
x = 450:40:580;
groupNames = fieldnames(lc_binned);
for ii = 1:length(groupNames)
	b = bar(x(ii),lc_binned.(groupNames{ii}).mu(9),35);
	b.FaceColor = [1,1,1].*colvals(ii);
	b.EdgeColor = 'none';

	errorbar(x(ii),lc_binned.(groupNames{ii}).mu(9),lc_binned.(groupNames{ii}).e(9),'Color',[0 0 0],'LineWidth',1.5);
end


box off;
ylim([.5,1]);
set(gca,'YTick',[.5:.1:1])
% set(gca,'YTick',[.5,.75,1]);
set(gca,'YTickLabel',get(gca,'YTick').*100,'FontName','Arial', 'FontSize',8,'FontWeight','bold');
set(gca,'XTick',0:100:400);
set(gca,'YMinorTick','off');
set(gca,'XMinorTick','off');
set(gca,'TickDir','out');
% set(gca,'YGrid','on');
set(gca,'LineWidth',1);
plot([400,400],get(gca,'YLim'),'k-');
% title(titleStr);
ylabel({'\bf Accuracy (%)'}, 'FontName', 'Arial', 'FontSize',10);
xlabel({'\bf Training Phase (Trial) '}, 'FontName', 'Arial', 'FontSize',10);
% text(125,0.55,'\rm Training Phase');
% text(450,0.55,'\rm Test Phase');

% legend([hb(1),hb(2),hb(3),hb(4)],{'F200','F20','F2','Interleaved'},'Location','East','Box','off','FontSize',8);
% legend([hb(1),hb(4)],{'F200','Interleaved'},'Location','East');
%set(gcf,'Position',[403,246,609,420]);
%set(legend,'Position',[0.7074,0.3494,0.1768,0.1560]);
% set(legend,'Position',[0.6843,0.6763,0.2030,0.1560]);
end

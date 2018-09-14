function pHandle = disp_lcurve_smooth(lcurves,fID,col,titleStr)
%% DISP_ACC_LCURVES(LCURVES,FID)
%
% (c) Timo Flesch, 2016

if(~exist('fID'))
	fID = 1111;
end
addpath(genpath('/home/timo/Documents/MATLAB/Toolboxes/auxiliar/'))

figure(fID);whitebg([.97 .97 .97]); set(gcf,'Color','w');

pHandle = plot_timeSeriesWithSEM(smoothMean(lcurves,10),col,fID);
hold on;

title(titleStr,'FontWeight','normal','FontSize',14);
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

plot([201 201],get(gca,'YLim'),'LineStyle','-.','Color',0.*[.7 .7 .7]);
plot([401 401],get(gca,'YLim'),'LineStyle','-.','Color',0.*[.7 .7 .7]);
plot(get(gca,'XLim'),[0.5 0.5],'k-');

text(50,0.45,'\bf Training Phase 1');
text(250,0.45,'\bf Training Phase 2');
text(450,0.45,'\bf Test Phase');

set(gcf,'Position',[400,40,890,580]);

end

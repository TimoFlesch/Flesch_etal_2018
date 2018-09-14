function [hb,he] = disp_choicemodel_RFXBMSresults(modelcomps)
%% DISP_CHOICEMODEL_RFXBMSresults(MODELCOMPS)
%
% displays results of random effects bayesian model comparison,
% In terms of exceedance probabilities and estimated model frequencies
%
% Timo Flesch, 2018
% Human Information Processing Lab,
% Experimental Psychology Department
% University of Oxford

%% estimated model frequencies
figure();%
whitebg([1 1 1]);
set(gcf,'Color','w');
efIn    =   modelcomps.groups.int.posterior.r';
efBl2   =     modelcomps.groups.b2.posterior.r';
efBl20  =   modelcomps.groups.b20.posterior.r';
efBl200 = modelcomps.groups.b200.posterior.r';

% plot error bars
meanIn = mean(efIn,1);
errIn = std(efIn,0,1)./sqrt(size(efIn,1));

meanBl2 = mean(efBl2,1);
errBl2 = std(efBl2,0,1)./sqrt(size(efBl2,1));

meanBl20 = mean(efBl20,1);
errBl20 = std(efBl20,0,1)./sqrt(size(efBl20,1));

meanBl200 = mean(efBl200,1);
errBl200 = std(efBl200,0,1)./sqrt(size(efBl200,1));

[hb,he] = barwitherr([errBl200;errBl20;errBl2;errIn],[meanBl200;meanBl20;meanBl2;meanIn],'LineWidth',3);
% hb = barwitherr([errBl200;errIn],[meanBl200;meanIn]);

hb(1).FaceColor = [1 1 1].*0.8;
hb(2).FaceColor = [1 1 1].*0.5;
hb(1).EdgeColor = 'none';
hb(2).EdgeColor = 'none';

xlabel('\rm Group', 'FontName', 'Arial');%, 'FontSize',10);
ylabel({'\rm Estimated Model Frequencies (%)'}, 'FontName', 'Arial');%, 'FontSize',10);

ylim([0,1])
set(gca,'XTick',1:4);
% set(gca,'XTick',1:2);
set(gca,'YTick',0:0.25:1);
set(gca,'YTickLabel',get(gca,'YTick').*100,'FontWeight','normal');

set(gca,'XTicklabel',{'B200', 'B20', 'B2', 'INT'},'FontName','Arial', 'FontSize',8,'FontWeight','normal');
% set(gca,'XTicklabel',{'B200', 'INT'},'FontName','Arial', 'FontWeight','normal');
set(gca,'YMinorTick','off');
set(gca,'XMinorTick','off');
set(gca,'TickDir','out');
set(gca,'YGrid','off');
set(gca,'LineWidth',1);


set(gca,'Box','off');

legend([hb(1),hb(2)],{'Unconstrained Model','Constrained Model'},'Box','off','Location','NorthEastOutside');

set(gcf,'Position',[1038, 501, 623, 238]);
end

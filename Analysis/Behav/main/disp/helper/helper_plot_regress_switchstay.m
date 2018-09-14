function helper_plot_regress_switchstay()
%
% plot barplots for switch vs stay analysis

% RT- cardinal boundary
load('betas_switchVsStay_cardinal_all.mat');
helper_barplots_switchstay(betas_all,'Cardinal');

% RT- diagonal boundary
load('betas_switchVsStay_diagonal_all.mat');
helper_barplots_switchstay(betas_all,'Diagonal');


end

function helper_barplots_switchstay(betas,boundaryCode)

meanVals_rt = [mean(betas.rt.b200),mean(betas.rt.b20),mean(betas.rt.b2),mean(betas.rt.int)];
errVals_rt = [std(betas.rt.b200,0,1)./sqrt(length(betas.rt.b200)),std(betas.rt.b20,0,1)./sqrt(length(betas.rt.b20)),std(betas.rt.b2,0,1)./sqrt(length(betas.rt.b2)),std(betas.rt.int,0,1)./sqrt(length(betas.rt.int))];

figure(); set(gcf,'Color','w');
b1 = bar(1,meanVals_rt(1));
b1.FaceColor = [0 0 0.8]
hold on;
b2 = bar(2,meanVals_rt(2));
b2.FaceColor = [0 0 0.5]

b3 = bar(3,meanVals_rt(3));
b3.FaceColor = [0 0 0.2]
b4 = bar(4,meanVals_rt(4));
b4.FaceColor = [0 0.5 0.5]
hold on;

errorbar(meanVals_rt,errVals_rt,'LineStyle','none','Color','k');

xlabel('\bf Group');
ylabel({'\bf Parameter Estimate'; '\rm [a.u.]'});

set(gca,'XTick',1:4);
set(gca,'XTicklabel',{'Blocked 200', 'Blocked 20', 'Blocked 2', 'Interleaved'},'XTickLabelRotation',20);

title({'\bf Linear Regression of Reciprocal RT on (Switch,Stay)'; ['\rm' boundaryCode ' Boundary']});	



end

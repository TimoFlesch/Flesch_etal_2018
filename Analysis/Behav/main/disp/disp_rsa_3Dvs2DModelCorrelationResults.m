function disp_rsa_3Dvs2DModelCorrelationResults(taus)
%% DISP_RSA_3DVS2DMODELCORRELATIONRESULTS(taus)
%
% displays correlation coefficients for orthogonalized
% model RDMs
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, University of Oxford

%% Both Tasks, Test
figure();whitebg([1,1,1]);set(gcf,'Color','w');
tausIn    =   taus.test.int.both;
tausBl2   =     taus.test.b2.both;
tausBl20  =   taus.test.b20.both;
tausBl200 = taus.test.b200.both;


% plot error bars
meanIn = mean(tausIn,1);
errIn = std(tausIn,0,1)./sqrt(size(tausIn,1));

meanBl2 = mean(tausBl2,1);
errBl2 = std(tausBl2,0,1)./sqrt(size(tausBl2,1));

meanBl20 = mean(tausBl20,1);
errBl20 = std(tausBl20,0,1)./sqrt(size(tausBl20,1));

meanBl200 = mean(tausBl200,1);
errBl200 = std(tausBl200,0,1)./sqrt(size(tausBl200,1));

hb = barwitherr([errBl200;errBl20;errBl2;errIn],[meanBl200;meanBl20;meanBl2;meanIn],'LineWidth',1.5);
% hb = barwitherr([errBl200;errIn],[meanBl200;meanIn]);

hb(1).FaceColor = [1 1 1].*0.8;
hb(2).FaceColor = [1 1 1].*0.5;
hb(1).EdgeColor = 'none';
hb(2).EdgeColor = 'none';
xlabel('\rm Group', 'FontName', 'Arial', 'FontSize',10);
ylabel({'\rm RDM Correlation (Kendall''s \tau_{a})'}, 'FontName', 'Arial', 'FontSize',10);

ylim([0,.8])
set(gca,'XTick',1:4);
set(gca,'YTick',0:.2:.8)

set(gca,'XTicklabel',{'B200', 'B20', 'B2', 'INT'},'FontName','Arial', 'FontSize',8,'FontWeight','normal');

set(gca,'YMinorTick','off');
set(gca,'XMinorTick','off');
set(gca,'TickDir','out');
set(gca,'YGrid','off');
set(gca,'LineWidth',1);
set(gca,'Box','off');

% set(gcf,'Position',[675,726,374,229]);

legend([hb(1),hb(2)],{'Factorised Model','Linear Model'},'Box','off','Location','NorthWest');
end

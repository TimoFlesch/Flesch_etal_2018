function helper_plotChoiceParamRDM(modRDM,s1,s2)

rdmLabels = {'b1l1','b2l1','b3l1','b4l1','b5l1','b1l2','b2l2','b3l2','b4l2','b5l2','b1l3','b2l3','b3l3','b4l3','b5l3','b1l4','b2l4','b3l4','b4l4','b5l4','b1l5','b2l5','b3l5','b4l5','b5l5'};
image(scale01(modRDM),'CDataMapping','scaled');
set(gca,'CLim',[0 1],'CLimMode','manual');
%colormap(gca,RDMcolormap);
xlabel('\bf Exemplars','FontSize',9);
ylabel('\bf Exemplars','FontSize',9);
set(gca,'XTick',1:25);
set(gca,'YTick',1:25);
set(gca,'XTickLabel',rdmLabels,'FontSize',7);
set(gca,'YTickLabel',rdmLabels,'FontSize',7);
axis('square');
cb = colorbar();
set(cb,'XTick',0:0.2:1);
ylabel(cb,'\bf Dissimilarity','FontSize',9);
set(gca,'XTickLabelRotation',70);
title({'\bf RDM';['\rm Slope L :' num2str(s1) ', Slope R: ' num2str(s2)]},'FontSize',11);
end

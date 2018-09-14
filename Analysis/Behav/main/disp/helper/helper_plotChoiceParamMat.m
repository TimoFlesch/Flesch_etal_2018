function helper_plotChoiceParamMat(choiceMat,s1,s2)

imagesc(flipud(choiceMat));
set(gca,'XTick',1:5);
set(gca,'YTick',1:5);
set(gca,'XTickLabel',-50:25:50,'FontSize',9);
set(gca,'YTickLabel',50:-25:-50,'FontSize',9);
xlabel({'\bf Reward ', '\rm leaf dimension'},'FontSize',9);
ylabel({'\bf Reward ', '\rm branch dimension'},'FontSize',9);
colormap('parula');
axis('square');
cb = colorbar();
set(cb,'XTick',0:0.2:1);
ylabel(cb,'\bf P(Plant Tree) \rm','FontSize',9);
title({'\bf Choice Probabilties';['\rm Slope L: ' num2str(s1) ', Slope R: ' num2str(s2)]},'FontSize',11);
end 


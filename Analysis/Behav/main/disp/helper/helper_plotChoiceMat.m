function helper_plotChoiceMat(choiceMat,modIDX)

imagesc((choiceMat));
set(gca,'XTick',1:5);
set(gca,'YTick',1:5);
set(gca,'XTickLabel',1:5);
set(gca,'YTickLabel',1:5);
xlabel({'\bf Feature Value ', '\rm branch dimension'},'FontSize',9);
ylabel({'\bf Feature Value ', '\rm leaf dimension'},'FontSize',9);
colormap('parula');
axis('square');
cb = colorbar();
set(cb,'XTick',0:0.2:1);
ylabel(cb,'\bf P(Plant Tree) \rm','FontSize',9);
title({'\bf Choice Probabilties';['\rm Model' num2str(modIDX)]},'FontSize',11);
end 


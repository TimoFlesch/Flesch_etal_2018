function cnn_disp_choicematrices(cMats)
%% cnn_DISP_CHOICEMATRICES(CMATS)
% 
% plots choice matrices of nnet simulations
%
% (c) Timo Flesch, 2017
% Summerfield lab, Experimental Psychology Department,
% University of Oxford 

if ~exist('lrID') 
    lrID = ''; 
else 
    lrID = [num2str(lrID)];
end

if ~exist('taskOrder') 
    taskOrder = ''; 
end

numTestTrials = 10000;
numTestSessions = 2;
inputRegimes = {'blocked','interleaved'};


results = struct();
				
for ii_ir = 1:length(inputRegimes) 
	
	ir = inputRegimes{ii_ir};
	figure();set(gcf,'Color','w');	
	cMatSetNorth = squeeze(mean(cMats.all.first.(ir)(:,:,:,:),1));
	cMatSetSouth = squeeze(mean(cMats.all.second.(ir)(:,:,:,:),1));
	helper_disp_choicematrices(cMatSetNorth,cMatSetSouth,{[ir ' training'];[' ' taskOrder]});
	set(gcf,'Position',[ -1785         191        843         667]);
	% save figures
	savefig(['choicemats_cnn_diagonal_' ir '_cnn_cvae_beta50.fig']);
	saveas(gcf,['choicemats_cnn_diagonal_' ir  '_cnn_cvae_beta50.svg'],'svg');
	saveas(gcf,['choicemats_cnn_diagonal_' ir '_cnn_cvae_beta50.png'],'png');
end


end


function helper_disp_choicematrices(cMatSetNorth,cMatSetSouth,titleStr);

	numSess = size(cMatSetSouth,1);
	for sessTest = 1:numSess
		subplot(2,numSess,sessTest);
		helper_plot_cmat(squeeze(cMatSetNorth(sessTest,:,:)),3);
		title({['\bf First Task, TestSess' num2str(sessTest)]; ['\rm' titleStr{1}];titleStr{2}});

		subplot(2,numSess,sessTest+numSess);
		helper_plot_cmat(squeeze(cMatSetSouth(sessTest,:,:)),4);
		title({['\bf Second Task, TestSess' num2str(sessTest)]; ['\rm' titleStr{1}];titleStr{2}});

	end 


end

function helper_plot_cmat(cMat,labelIDX)

imagesc((cMat));
set(gca,'XTick',1:5);
set(gca,'YTick',1:5);
set(gca,'XTickLabel',1:5);
set(gca,'YTickLabel',1:5);
xlabel({'\bf Feature Value ', '\rm dimension 2'},'FontSize',10);
ylabel({'\bf Feature Value ', '\rm dimension 1'},'FontSize',10);
colormap('parula');
axis('square');

switch labelIDX
    case 1 % blocked north
        text(0.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(5,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        
        
        
    case 2 % blocked south
        text(0.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,1, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,1,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,2, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,2,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,2,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,3,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,3,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,3, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,3,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,3,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,4,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,4,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,4, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,5,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,5, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,5,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        
    case 4 % Cardinal north
                text(0.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,1,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(5.00,1,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,2,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.00,2,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,2,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,3,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,3,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,3,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,3,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,4,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2,4,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,4,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.00,5,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,5,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        
    case 3 % Cardinal south
        text(0.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,5,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(5.00,5,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,4,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,4,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,4,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.00,4,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,3,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,3,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,3,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,3,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2,2,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,2,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,2,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,2,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.00,1,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
end 
cb = colorbar();
ylabel(cb,'\bf P(Plant Tree) \rm');
set(cb,'YTick',0:0.2:1);
ylim(cb,[0,1]);
end


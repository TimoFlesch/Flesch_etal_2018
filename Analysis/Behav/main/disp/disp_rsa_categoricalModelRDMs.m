function disp_rsa_categoricalModelRDMs()
%% disp_rsa_categoricalModelRDMs()
%
% computes and displays choice matrices and corresponding
% model RDMs
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, University of Oxford


rdmLabels = {'b1l1','b2l1','b3l1','b4l1','b5l1','b1l2','b2l2','b3l2','b4l2','b5l2','b1l3','b2l3','b3l3','b4l3','b5l3','b1l4','b2l4','b3l4','b4l4','b5l4','b1l5','b2l5','b3l5','b4l5','b5l5'};

figure();set(gcf,'Color','w');
for modIDX = 1:4

	myModel = genCategoricalModelRDM(modIDX);
	subplot(2,4,modIDX);
	helper_plotChoiceMat(myModel.choiceMat,modIDX);
	subplot(2,4,modIDX+4);
	helper_plotChoiceRDM(myModel.choiceRDM,modIDX);
end
set(gcf,'Position',[22,33,1303,633]);



end

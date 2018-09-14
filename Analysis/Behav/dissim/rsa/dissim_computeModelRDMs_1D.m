function modelSet = dissim_computeModelRDMs_1D(monitor)
	%% RDMSET = DISSIM_COMPUTEMODELRDMS_1D()
	% 
	% computes model rdms based on 
	% - first dimension
	% - second dimension
	% - "diagonal" dimensions
	% in one dimension
	% assuming linear spacing of categorical arrangement
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford
	if ~exist('monitor')
		monitor = 0;
	end
	%% MAIN
	modelSet = struct();
	rdmSet = [];
	coordSet = [];

	%% 1D Models - linear -----------------------------------------------------
	[branch,leaf] = meshgrid(1:5,1:5);
	branch = branch(:);
	leaf   =   leaf(:);
	% branch model
	coordSet(1,:) = branch;
	rdmSet(1,:,:) = squareform(pdist(branch));
	% leaf model
	coordSet(2,:) = leaf;
	rdmSet(2,:,:) = squareform(pdist(leaf));
	% diag 1 model (++, or --)
	tmp = genParametrizedModelRDM(1,1,0); % function in rew folder
	coordSet(3,:) = tmp.choiceMat(:);
	rdmSet(3,:,:) = tmp.choiceRDM;

	% diag 2 model (+-, or -+)
	cm3 = flipud(tmp.choiceMat);
	coordSet(4,:) = cm3(:);
	rdmSet(4,:,:) = squareform(pdist(cm3(:)));

	%% 1D Models - categorical (even) -----------------------------------------
	[branch,leaf] = meshgrid([1,1,3,5,5],[1,1,3,5,5]);
	branch = branch(:);
	leaf   =   leaf(:);	
	% branch model
	coordSet(5,:) = branch;
	rdmSet(5,:,:) = squareform(pdist(branch));
	% leaf model
	coordSet(6,:) = leaf;
	rdmSet(6,:,:) = squareform(pdist(leaf));
	% diag 1 model (++, or --)
	tmp = genParametrizedModelRDM(10,10,0); % function in rew folder
	coordSet(7,:) = tmp.choiceMat(:);
	rdmSet(7,:,:) = tmp.choiceRDM;
	% diag 2 model (+-, or -+)
	cm3 = flipud(tmp.choiceMat);
	coordSet(8,:) = cm3(:);
	rdmSet(8,:,:) = squareform(pdist(cm3(:)));

	%% 1D Models - categorical (more high) ------------------------------------
	[branch,leaf] = meshgrid([1,1,5,5,5],[1,1,5,5,5]);
	branch = branch(:);
	leaf   =   leaf(:);	
	% branch model
	coordSet(9,:) = branch;
	rdmSet(9,:,:) = squareform(pdist(branch));
	% leaf model
	coordSet(10,:) = leaf;
	rdmSet(10,:,:) = squareform(pdist(leaf));
	% diag 1 model (++, or --)
	tmp = genParametrizedModelRDM(10,10,0); % function in rew folder
	tmp.choiceMat(5:4:end-4) = 1;
	coordSet(11,:) = tmp.choiceMat(:);
	rdmSet(11,:,:) = squareform(pdist(tmp.choiceMat(:)));
	% diag 2 model (+-, or -+)
	cm3 = flipud(tmp.choiceMat);
	coordSet(12,:) = cm3(:);
	rdmSet(12,:,:) = squareform(pdist(cm3(:)));

	%% 1D Models - categorical (more low) -------------------------------------
	[branch,leaf] = meshgrid([1,1,1,5,5],[1,1,1,5,5]);
	branch = branch(:);
	leaf   =   leaf(:);	
	% branch model
	coordSet(13,:) = branch;
	rdmSet(13,:,:) = squareform(pdist(branch));
	% leaf model
	coordSet(14,:) = leaf;
	rdmSet(14,:,:) = squareform(pdist(leaf));
	% diag 1 model (++, or --)
	tmp = genParametrizedModelRDM(10,10,0); % function in rew folder
	tmp.choiceMat(5:4:end-4) = 0;
	coordSet(15,:) = tmp.choiceMat(:);
	rdmSet(15,:,:) = squareform(pdist(tmp.choiceMat(:)));
	% diag 2 model (+-, or -+)
	cm3 = flipud(tmp.choiceMat);
	coordSet(16,:) = cm3(:);
	rdmSet(16,:,:) = squareform(pdist(cm3(:)));

	modelSet.rdmSet = rdmSet;
	modelSet.coordSet = coordSet;


	if monitor
		helper_plotModels(modelSet)
	end

	function helper_plotModels(modelSet)
		labels = {'linear(branch)','linear(leaf)','linear(diag1)','linear(diag2)','cluster a(branch)','cluster a(leaf)','cluster a(diag1)','cluster a(diag2)','cluster b(branch)','cluster b(leaf)','cluster b(diag1)','cluster b(diag2)','cluster c(branch)','cluster c(leaf)','cluster c(diag1)','cluster c(diag2)'};
		figure();set(gcf,'Color','w');
		for ii = 1:size(modelSet.rdmSet,1)
			subplot(4,4,ii);
			imagesc(reshape(squeeze(modelSet.coordSet(ii,:)),5,5));
			title(labels{ii},'FontWeight','normal');
			set(gca,'XTickLabel',{});
			set(gca,'YTickLabel',{});
			xlabel('branch','FontSize',8);			
			ylabel('leaf','FontSize',8);
			colormap('jet');
			axis('square');
		end
		set(gcf,'Position',[403,22,890,644]);
		figure();set(gcf,'Color','w');
		for ii = 1:size(modelSet.rdmSet,1)
			subplot(4,4,ii);
			image(scale01(rankTransform_equalsStayEqual(squeeze(modelSet.rdmSet(ii,:,:)))),'CDataMapping','scaled','AlphaData',1);
			colormap('jet');
			title(labels{ii},'FontWeight','normal');
			axis('square');
		end
		set(gcf,'Position',[403,22,890,644]);
	end
end
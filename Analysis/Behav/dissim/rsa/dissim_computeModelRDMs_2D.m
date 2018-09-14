function modelSet = dissim_computeModelRDMs_2D(monitor)
	%% RDMSET = DISSIM_COMPUTEMODELRDMS_2D()
	% 
	% computes model rdms based on 
	% potential arrangements of stimuli in 2D space
	% assuming that participants discovered grid-like structure 
	% models are either grid like or assume clusters along one of the 
	% two possible task dimensions (for diagonal and cardinal ones)
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford
	
	if ~exist('monitor')
		monitor = 0;
	end
	%% MAIN
	modelSet = struct();
	rdmSet   = [];
	coordSet = [];

	% distortion parameters
	bias_x = 1;
	bias_y = 1;

	%% 2D Models  - full model (evenly spaced grid) ---------------------------
	[branch,leaf] = meshgrid(1:5,1:5);
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(1,:,:) = [branch,leaf];
	rdmSet(1,:,:) = squareform(pdist([leaf,branch]));

	%% 2D Models  - clusters --------------------------------------------------
	% branch
	[branch,leaf] = meshgrid([1,2-bias_x/2,3,4+bias_x/2,5],1:5);
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(2,:,:) = [branch,leaf];
	rdmSet(2,:,:) = squareform(pdist([leaf,branch]));
	% leaf
	[branch,leaf] = meshgrid(1:5,[1,2-bias_x/2,3,4+bias_x/2,5]);
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(3,:,:) = [branch,leaf];
	rdmSet(3,:,:) = squareform(pdist([leaf,branch]));
	% diag 1
	[branch,leaf] = meshgrid(1:5,1:5);
	idces_topLeft     = find(triu(branch,1)~=0);
	idces_bottomRight = find(tril(branch,-1)~=0);
	branch(idces_topLeft) = branch(idces_topLeft)+bias_y; % shift top left upwards
	leaf(idces_topLeft)   =   leaf(idces_topLeft)-bias_x; % shift top left leftwards
	branch(idces_bottomRight) = branch(idces_bottomRight)-bias_y; % shift bottom right downwards
	leaf(idces_bottomRight)   =   leaf(idces_bottomRight)+bias_x; % shift bottom right righwards
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(4,:,:) = [branch,leaf];
	rdmSet(4,:,:) = squareform(pdist([leaf,branch]));
	% diag 2
	[branch,leaf] = meshgrid(1:5,1:5);
	idces_bottomLeft     = find(fliplr(triu(fliplr(branch),1))~=0);
	idces_topRight = find(fliplr(tril(fliplr(branch),-1))~=0);
	branch(idces_bottomLeft) = branch(idces_bottomLeft)-bias_y; % shift bottom left downwards
	leaf(idces_bottomLeft)   =   leaf(idces_bottomLeft)-bias_x; % shift bottom left leftwards
	branch(idces_topRight) = branch(idces_topRight)+bias_y; % shift top right upwards
	leaf(idces_topRight)   =   leaf(idces_topRight)+bias_x; % shift top right righwards
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(5,:,:) = [branch,leaf];
	rdmSet(5,:,:) = squareform(pdist([leaf,branch]));

	%% 2D Models  - clusters (more high) ---------------------------------------
	% branch
	[branch,leaf] = meshgrid([1,2-bias_x/2,3+bias_x,4+bias_x/2,5],1:5);
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(6,:,:) = [branch,leaf];
	rdmSet(6,:,:) = squareform(pdist([leaf,branch]));
	% leaf
	[branch,leaf] = meshgrid(1:5,[1,2-bias_x/2,3+bias_x,4+bias_x/2,5]);
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(7,:,:) = [branch,leaf];
	rdmSet(7,:,:) = squareform(pdist([leaf,branch]));
	% diag 1
	[branch,leaf] = meshgrid(1:5,1:5);
	idces_topLeft     = find(triu(branch)~=0);
	idces_bottomRight = find(tril(branch,-1)~=0);
	branch(idces_topLeft) = branch(idces_topLeft)+bias_y; % shift top left upwards
	leaf(idces_topLeft)   =   leaf(idces_topLeft)-bias_x; % shift top left leftwards
	branch(idces_bottomRight) = branch(idces_bottomRight)-bias_y; % shift bottom right downwards
	leaf(idces_bottomRight)   =   leaf(idces_bottomRight)+bias_x; % shift bottom right righwards
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(8,:,:) = [branch,leaf];
	rdmSet(8,:,:) = squareform(pdist([leaf,branch]));
	% diag 2
	[branch,leaf] = meshgrid(1:5,1:5);
	idces_bottomLeft     = find(fliplr(triu(fliplr(branch),1))~=0);
	idces_topRight = find(fliplr(tril(fliplr(branch)))~=0);
	branch(idces_bottomLeft) = branch(idces_bottomLeft)-bias_y; % shift bottom left downwards
	leaf(idces_bottomLeft)   =   leaf(idces_bottomLeft)-bias_x; % shift bottom left leftwards
	branch(idces_topRight) = branch(idces_topRight)+bias_y; % shift top right upwards
	leaf(idces_topRight)   =   leaf(idces_topRight)+bias_x; % shift top right righwards
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(9,:,:) = [branch,leaf];
	rdmSet(9,:,:) = squareform(pdist([leaf,branch]));

	%% 2D Models  - clusters (more low) --------------------------------------
	[branch,leaf] = meshgrid([1,2-bias_x/2,3-bias_x,4+bias_x/2,5],1:5);
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(10,:,:) = [branch,leaf];
	rdmSet(10,:,:) = squareform(pdist([leaf,branch]));
	% leaf
	[branch,leaf] = meshgrid(1:5,[1,2-bias_x/2,3-bias_x,4+bias_x/2,5]);
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(11,:,:) = [branch,leaf];
	rdmSet(11,:,:) = squareform(pdist([leaf,branch]));
	% diag 1
	[branch,leaf] = meshgrid(1:5,1:5);
	idces_topLeft     = find(triu(branch,1)~=0);
	idces_bottomRight = find(tril(branch)~=0);
	branch(idces_topLeft) = branch(idces_topLeft)+bias_y; % shift top left upwards
	leaf(idces_topLeft)   =   leaf(idces_topLeft)-bias_x; % shift top left leftwards
	branch(idces_bottomRight) = branch(idces_bottomRight)-bias_y; % shift bottom right downwards
	leaf(idces_bottomRight)   =   leaf(idces_bottomRight)+bias_x; % shift bottom right righwards
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(12,:,:) = [branch,leaf];
	rdmSet(12,:,:) = squareform(pdist([leaf,branch]));
	% diag 2
	[branch,leaf] = meshgrid(1:5,1:5);
	idces_bottomLeft     = find(fliplr(triu(fliplr(branch)))~=0);
	idces_topRight = find(fliplr(tril(fliplr(branch),-1))~=0);
	branch(idces_bottomLeft) = branch(idces_bottomLeft)-bias_y; % shift bottom left downwards
	leaf(idces_bottomLeft)   =   leaf(idces_bottomLeft)-bias_x; % shift bottom left leftwards
	branch(idces_topRight) = branch(idces_topRight)+bias_y; % shift top right upwards
	leaf(idces_topRight)   =   leaf(idces_topRight)+bias_x; % shift top right righwards
	branch = branch(:);
	leaf   =   leaf(:);
	coordSet(13,:,:) = [branch,leaf];
	rdmSet(13,:,:) = squareform(pdist([leaf,branch]));
	
	modelSet.rdmSet = rdmSet;
	modelSet.coordSet = coordSet;


	if monitor
		helper_plotModels(modelSet)
	end

	function helper_plotModels(modelSet)

		figure();set(gcf,'Color','w');
		labels = {'grid','clusters a(branch)','clusters a(leaf)','clusters a(diag1)','clusters a(diag2)','clusters b(branch)','clusters b(leaf)','clusters b(diag1)','clusters b(diag2)','clusters c(branch)','clusters c(leaf)','clusters c(diag1)','clusters c(diag2)'};
		for ii = 1:size(modelSet.rdmSet,1)
			if ii == 1
				subplot(4,4,ii);
			else 
				subplot(4,4,ii+3);
			end
			scatter(squeeze(modelSet.coordSet(ii,:,1)),squeeze(modelSet.coordSet(ii,:,2)),'FaceColor','blue');
			title(labels{ii},'FontWeight','normal');
			colormap('jet');
			xlabel('branch','FontSize',8);
			ylabel('leaf','FontSize',8);
			box on;
			axis('square');
			set(gca,'XTickLabel',{});
			set(gca,'YTickLabel',{});
			xlim([0,6])
			ylim([0,6])	
		end
		set(gcf,'Position',[403,22,890,644]);
		figure();set(gcf,'Color','w');
		for ii = 1:size(modelSet.rdmSet,1)
			if ii == 1
				subplot(4,4,ii);
			else 
				subplot(4,4,ii+3);
			end
			image(scale01(rankTransform_equalsStayEqual(squeeze(modelSet.rdmSet(ii,:,:)))),'CDataMapping','scaled','AlphaData',1);
			colormap('jet');
			title(labels{ii},'FontWeight','normal');
			axis('square');
		end
		set(gcf,'Position',[403,22,890,644]);
	end

end
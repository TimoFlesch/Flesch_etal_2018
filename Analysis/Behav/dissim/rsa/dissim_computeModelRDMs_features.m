function modelSet = dissim_computeModelRDMs_features(monitor)
	%% RDMSET = DISSIM_COMPUTEMODELRDMS_features()
	% 
	% computes model rdms based on 
	% - first feature dimension
	% - second feature dimension
	% - 2d grid
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
	%coordSet = [];

	%
	[branch,leaf] = meshgrid(1:5,1:5);
	branch = branch(:);
	leaf   =   leaf(:);
	% branch model
	%coordSet(1,:) = branch;
	rdmSet(1,:,:) = squareform(pdist(branch));
	% leaf model
	%coordSet(2,:) = leaf;
	rdmSet(2,:,:) = squareform(pdist(leaf));
	% grid model
	%coordSet(3,:,:) = [branch,leaf];
	rdmSet(3,:,:) = squareform(pdist([leaf,branch]));
	
	% cluster models:
	bias_x = 1;
	bias_y = 1;
	[branch,leaf] = meshgrid([1,2-bias_x/2,3-bias_x,4+bias_x/2,5],1:5);
	branch = branch(:);
	leaf   =   leaf(:);	
	rdmSet(4,:,:) = squareform(pdist([leaf,branch]));
	% leaf
	[branch,leaf] = meshgrid(1:5,[1,2-bias_x/2,3-bias_x,4+bias_x/2,5]);
	branch = branch(:);
	leaf   =   leaf(:);	
	rdmSet(5,:,:) = squareform(pdist([leaf,branch]));

	modelSet.rdmSet = rdmSet;
end
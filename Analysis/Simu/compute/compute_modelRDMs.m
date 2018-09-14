function rdmSet = compute_modelRDMs(bound,rewards)
	%% COMPUTE_MODELRDMS()
	%
	% computes various task-task model rdms:
	% - pixel dissimilarity
	% - grid encoding	
	% - same tasks
	% - different tasks
	%
	% Timo Flesch, 2017

	if ~exist('bound')
		bound = 'cardinal';
	end
	if ~exist('rewards')
		rewards = 'pp';
	end

	rdmSet = [];

	%% main 
	% 1. pixel dissimilarity (of normalised images)
	load('tree_tasksets')	
	normalisedTrees = normalisedTrees(:,:);
	rdmSet(1,:,:) = squareform(pdist(normalisedTrees,'correlation')); % north-south
	normalisedTrees = [normalisedTrees(1:25,:);normalisedTrees(26:end,:)];
	rdmSet(2,:,:) = squareform(pdist(normalisedTrees,'correlation'));      % south-north

	
	% 2. grid encoding
	% irrespective of context, just encode the branch-leaf grid.
	[b,l] = meshgrid(1:5,1:5);
	b = [b(:);b(:)];
	l = [l(:);l(:)];
	rdmSet(3,:,:) = squareform(pdist([b,l]));


	if strcmp(bound,'cardinal')
		% 3. task-based encoding: categorical - cardinal
		if strcmp(rewards,'pp') || strcmp(rewards,'mm')
			[b,l] = meshgrid([-1,-1,0,1,1],[-1,-1,0,1,1]); 
			bb = [b(:);b(:)];
			ll = [l(:);l(:)];
			bl = [b(:);l(:)];
			lb = [l(:);b(:)];
			% both leaf ('north only')
			rdmSet(4,:,:)  = squareform(pdist(ll));
			% both branch ('south only')
			rdmSet(5,:,:)  = squareform(pdist(bb));
			% leaf,branch ('north-south')
			rdmSet(6,:,:)  = squareform(pdist(lb));
			% branch,leaf ('south-north')
			rdmSet(7,:,:)  = squareform(pdist(bl));

			% orthogonal model. as the matrices are symmetric, I can use the same for pp as well as mm
			l = tril(ones(5,5));           % diagonal north (ortho cardinal)
			l(1:length(l)+1:end) = 0.5;
			l = fliplr(l);
			ll = [l(:);l(:)];
			rdmSet(8,:,:) = squareform(pdist(ll));

		elseif strcmp(rewards,'pm') || strcmp(rewards,'mp')		 	 
			% pm,mp
			[b,l] = meshgrid([-1,-1,0,1,1],[1,1,0,-1,-1]); 
			bb = [b(:);b(:)];
			ll = [l(:);l(:)];
			bl = [b(:);l(:)];
			lb = [l(:);b(:)];
			% both leaf ('north only')
			rdmSet(4,:,:)  = squareform(pdist(ll));
			% both branch ('south only')
			rdmSet(5,:,:)  = squareform(pdist(bb));
			% leaf,branch ('north-south')
			rdmSet(6,:,:)  = squareform(pdist(lb));
			% branch,leaf ('south-north')
			rdmSet(7,:,:)  = squareform(pdist(bl));

			b = tril(ones(5,5));           % diagonal south  
			b(1:length(b)+1:end) = 0.5;
			b = flipud(fliplr(b));
			bb = [b(:);b(:)];
			rdmSet(8,:,:) = squareform(pdist(bb));
			
		end
	elseif strcmp(bound,'diagonal')
		% 4. task-based encoding: categorical - diagonal
		if strcmp(rewards,'pp') || strcmp(rewards,'mm')
			l = tril(ones(5,5));           % diagonal north (ortho cardinal)
			l(1:length(l)+1:end) = 0.5;
			l = fliplr(l);
			
			b = tril(ones(5,5));           % diagonal south  
			b(1:length(b)+1:end) = 0.5;
			% b = flipud(fliplr(b));
			bb = [b(:);b(:)];
			ll = [l(:);l(:)];
			bl = [b(:);l(:)];
			lb = [l(:);b(:)];
			% 'north only'
			rdmSet(4,:,:)  = squareform(pdist(ll));
			% 'south only'
			rdmSet(5,:,:)  = squareform(pdist(bb));
			% 'north-south'
			rdmSet(6,:,:)  = squareform(pdist(lb));
			% 'south-north'
			rdmSet(7,:,:)  = squareform(pdist(bl));

			[b,l] = meshgrid([-1,-1,0,1,1],[-1,-1,0,1,1]); 
			ll = [l(:);l(:)];
 			rdmSet(8,:,:) = squareform(pdist(ll));

		elseif strcmp(rewards,'pm') || strcmp(rewards,'mp')	
			l = tril(ones(5,5));           % diagonal north (ortho cardinal)
			l(1:length(l)+1:end) = 0.5;
			l = fliplr(l);
			
			b = tril(ones(5,5));           % diagonal south  
			b(1:length(b)+1:end) = 0.5;
			% b = flipud(b);
			bb = [b(:);b(:)];
			ll = [l(:);l(:)];
			bl = [b(:);l(:)];
			lb = [l(:);b(:)];
			% 'north only'
			rdmSet(4,:,:)  = squareform(pdist(ll));
			% 'south only'
			rdmSet(5,:,:)  = squareform(pdist(bb));
			% 'north-south'
			rdmSet(6,:,:)  = squareform(pdist(lb));
			% 'south-north'
			rdmSet(7,:,:)  = squareform(pdist(bl));


			[b,l] = meshgrid([-1,-1,0,1,1],[-1,-1,0,1,1]); 
			b = [b(:);b(:)];
 			rdmSet(8,:,:) = squareform(pdist(bb));
		end
	end




end





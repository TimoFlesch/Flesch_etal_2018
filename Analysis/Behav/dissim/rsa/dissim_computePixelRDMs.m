function rdmSet = dissim_computePixelRDMs(data)
	%% RDMSET= DISSIM_COMPUTEPIXELRDMS(DATA)
	%
	% computes pixel-based RDMS
	% uses the exemplars that were shown to the participants
	% returns subject-x-trial-x-dim1-x-dim2 set of rdms
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford

	imageFolder = '/Data/ArenaTrees'; % specifies where to find the trees

	numTrials = max(data(1).data(:,1));
	rdmSet    = [];

	for ii=1:length(data)
		idces = 1:25;
		for jj=1:numTrials
			% load images
			stimMat = helper_loadImages(imageFolder,data(ii).stimuli(idces),0);
			% vectorize the images
			stimMat = stimMat(1:25,:);
			% compute rdms:
			rdmSet(ii,jj,:,:) = squareform(pdist(stimMat));
			idces = idces+25;
			stimMat = [];
		end
	end


end

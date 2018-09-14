function rdmSet = dissim_computeRDMs(data)
	%% DISSIM_COMPUTERDMS(DATA)
	%
	% iterates through subjects and computes trial-wise RDMs
	%
	% INPUT:
	% - data: dissim data (obtained by dissim_getAllData.m)
    %
	% OUTPUT: 
	% -rdmSet: subject-x-trial-x-dim1-x-dim2 RDM set
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford


	%% MAIN
	rdmSet = [];
	% loop through subjects and trials
	for ii = 1:length(data)
		for jj = 1:max(data(1).data(:,1))
			coords = data(ii).data(data(ii).data(:,1)==jj,6:7);
			dists = pdist(coords);
			dists = dists./max(dists);
			rdm   = squareform(dists);
			rdmSet(ii,jj,:,:) = rdm;
		end
	end

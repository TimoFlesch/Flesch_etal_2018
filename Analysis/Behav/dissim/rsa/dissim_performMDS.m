function [mdsSet] = dissim_performMDS(rdmSet)
	%% [MDSSET] = DISSIM_PERFORMMDS(RDMSET)
	%
	% performs mds on group-level rdms 
	%
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department, 
	% University of Oxford

	%% main
	mdsSet = [];	
	rdmSet = squeeze(mean(mean(rdmSet,2),1));
	mdsSet = mdscale(rdmSet,2,'Criterion','metricstress');

end

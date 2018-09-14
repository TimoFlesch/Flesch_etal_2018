function pvals = dissim_statinf_RDMmassTtest(rdmsG1,rdmsG2)
	%% DISSIM_STATINF_RDMMASSTTEST(RDMSG1,RDMSG2)
	%
	% performs t-test (or rank sum) on each pairwise dissimilarity
	% between rdms from two different groups
	%
	% (c) Timo Flesch, 2017
	% Summerfield lab, Experimental Psychology Department
	% University of Oxford

	pvals = [];

	% 1. vectorize each single subject rdm
	vrdmsG1 = helper_vectorizeEachRDM(rdmsG1);
	vrdmsG2 = helper_vectorizeEachRDM(rdmsG2);

	% 2. loop through pairwise distances and perform ranksum test
	for pd = 1:size(vrdmsG2,2)
		pvals(pd) = ranksum(squeeze(vrdmsG1(:,pd)),squeeze(vrdmsG2(:,pd)));
	end

end


function vectRDMs = helper_vectorizeEachRDM(rdmSet)
	% 
	% iterates through 3d rdm set (sub-dim1-dim2)
	% and vectorizes each single subject rdm 

	%% MAIN
	vectRDMs = [];
	for ii = 1 : size(rdmSet,1)
		vectRDMs(ii,:) = vectorizeRDM(squeeze(rdmSet(ii,:,:)));		
	end

end
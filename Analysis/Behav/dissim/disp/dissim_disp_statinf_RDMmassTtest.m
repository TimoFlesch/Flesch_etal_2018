function dissim_disp_statinf_RDMmassTtest(data,pvals,prepostID)
	%% DISSIM_DISP_STATINF_RDMMASSTTEST(PVALS,TITLESTR)
	%
	% displays thresholded pvalue-rdms
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	imageFolder = '/home/timo/Projects/EXP_CL_TREES/exp/mturk/treetask_dissimrating/stims/'; % specifies where to find the trees

	groupNames = {'cardinalBlocked200',
	              'cardinalInterleaved',
	              'diagonalBlocked200',
	              'diagonalInterleaved'};
    pairIdces = [1,2;1,3;1,4;2,3;2,4;3,4];

    stimuli = data(1).stimuli(1:25);
	images  = helper_loadImages(imageFolder,stimuli,255);
	% make data compatible with rsatoolbox:
	imlist        = struct();
	imlist.images = struct();
	for tt = 1:25
		imlist.images(tt).image = squeeze(images(tt,:,:,:));
	end		

	if (prepostID == 1)
		phaseID = 'pre';
	else
		phaseID = 'post';
	end
		
    figure();set(gcf,'Color','w');
    for ii = 1:size(pairIdces,1) % for all combinations
    	subplot(2,3,ii);
    	rdm = squareform(squeeze(pvals(prepostID,pairIdces(ii,1),pairIdces(ii,2),:)));
    	rdm(1:length(rdm)+1:end) = 0;
    	thresh = FDRthreshold(rdm);
    	rdm = rdm <= thresh;
    	rdm(1:length(rdm)+1:end) = 0;
		dissim_dispRDM(rdm,imlist);
		title({['\bf (' groupNames{pairIdces(ii,1)} ',' groupNames{pairIdces(ii,2)} ')']},'FontSize',8);		
	end
	colormap('parula');
end
function dissim_disp_RDMdendrogram(rdm,titleStr)
	%% DISSIM_DISP_RDMDENDROGRAM(RDMSET,TITLESTR)
	%
	% displays dendrogram of provided RDM
	% 
	% (c) Timo Flesch, 2017
	% SUmmerfield Lab, Experimental Psychology Department
	% University of Oxford

	[a,b] = meshgrid(1:5,1:5);
	labels = {};
	for ii = 1:25
		labels{ii} = ['B' num2str(a(ii)) 'L' num2str(b(ii))];
	end
	options.conditionLabels = labels;
	options.conditionLabels =   labels;
	options.analysisName    = 'joajoa';
	options.rootPath        =      pwd;

	RDMs       = struct();
	RDMs.name  = titleStr;
	RDMs.RDM   = rdm;
	RDMs.color = colormap('jet');
	close all;

	dendrogramConditions(RDMs,options);
	saveas(gcf,['dissim_dendrogram_' strrep(titleStr,', ','_') '_allindia.png']);
end
	

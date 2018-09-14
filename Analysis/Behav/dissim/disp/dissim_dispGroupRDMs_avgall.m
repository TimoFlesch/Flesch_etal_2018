function dissim_dispGroupRDMs_avgall(rdmSet,data,titleStr)
	%% DISSIM_DISPGROUPRDMS_AVGALL(RDMSET,DATA,TITLESTR)
	%
	% plots group-level rdms averaged across trials
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department, 
	% University of Oxford


	imageFolder = '/home/timo/Projects/EXP_CL_TREES/exp/mturk/treetask_dissimrating/stims/'; % specifies where to find the trees

	idces = [1:25];
	
	rdm = squeeze(mean(mean(rdmSet,2),1));

	figure();set(gcf,'Color',[150 150 150]./150);
	%set(gcf,'Color',[150 150 150]./255);
	stimuli = data(1).stimuli(idces);
	images  = helper_loadImages(imageFolder,stimuli,255);
	% make data compatible with rsatoolbox:
	imlist        = struct();
	imlist.images = struct();
	for tt = 1:25
		imlist.images(tt).image = squeeze(images(tt,:,:,:));
	end
	% plot! 
	dissim_dispRDM(rdm,imlist);
	idces = idces+25;
	cb = colorbar();
	ylabel(cb,'Dissimilarity','FontSize',12);
	set(gcf,'Position',[239     5   795   659]);
	title({['\bf Group-Level Dissimlarity Ratings']; ['\rm' titleStr ]});
	saveas(gcf,['dissim_rdm_grouplevel_' strrep(titleStr,', ','_') 'allindia.png']);
	close all;

end
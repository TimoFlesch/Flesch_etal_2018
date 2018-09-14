function dissim_dispGroupRDMs(rdmSet,data)
	%% DISSIM_DISPGROUPRDMS(RDMSET,DATA)
	%
	% plots group-level trial wise RDMS (2,3 subplots)
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department, 
	% University of Oxford


	imageFolder = '/media/timo/tfdrive/work/UOXF/Research_Assistant/Projects/EXP_CL_TREES/exp/mturk/treetask_dissimrating/stims/'; % specifies where to find the trees

	idces = [1:25];
	
	for jj = 1:size(rdmSet,2)			
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
		rdm = squeeze(mean(rdmSet(:,jj,:,:),1));
		dissim_dispRDM(rdm,imlist);
		idces = idces+25;
		set(gcf,'Position',[239     5   795   659]);
		title({['\bf Group-Level Dissimlarity Ratings']; ['Trial ' num2str(jj)]});
		saveas(gcf,['dissim_rdm_grouplevel_trial' num2str(jj) '_allindia.png']);
		close all;
	end




end
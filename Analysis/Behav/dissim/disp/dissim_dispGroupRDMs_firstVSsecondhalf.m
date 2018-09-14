function dissim_dispGroupRDMs_firstVSsecondhalf(rdmSet,data)
	%% DISSIM_DISPGROUPRDMS_FIRSTVSSECONDHALF(RDMSET,DATA)
	%
	% plots group-level trial wise RDMS (2,3 subplots)
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department, 
	% University of Oxford


	imageFolder = '/media/timo/tfdrive/work/UOXF/Research_Assistant/Projects/EXP_CL_TREES/exp/mturk/treetask_dissimrating/stims/'; % specifies where to find the trees

	idces = [1:25];
	
	rdms(1,:,:) = squeeze(mean(mean(rdmSet(:,1:3,:,:),2),1));
	rdms(2,:,:) = squeeze(mean(mean(rdmSet(:,4:6,:,:),2),1));
 	tNames = {'first','second'};

	for jj = 1:2
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
		rdm = squeeze(rdms(jj,:,:));
		dissim_dispRDM(rdm,imlist);
		idces = idces+25;
		set(gcf,'Position',[239     5   795   659]);
		title({['\bf Group-Level Dissimlarity Ratings']; [tNames{jj} ' half']});
		saveas(gcf,['dissim_rdm_grouplevel_' tNames{jj} ' half.png']);
		close all;
	end




end
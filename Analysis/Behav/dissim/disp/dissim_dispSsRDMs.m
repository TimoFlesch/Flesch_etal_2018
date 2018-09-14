function dissim_dispSsRDMs(rdmSet,data)
	%% DISPSSRDMS(RDMSET)
	%
	% plots  single subject rdms (2,3 subplots per subject)
	% and uses stimulus images as axis labels
	% 
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford
	
	imageFolder = '/media/timo/tfdrive/work/UOXF/Research_Assistant/Projects/EXP_CL_TREES/exp/mturk/treetask_dissimrating/stims/'; % specifies where to find the trees


	for ii = 1:size(rdmSet,1)		
		idces = [1:25];
		disp(['processing subject ' num2str(ii)]);
		for jj = 1:size(rdmSet,2)			
			figure();set(gcf,'Color',[150 150 150]./150);
			%set(gcf,'Color',[150 150 150]./255);
			stimuli = data(ii).stimuli(idces);
			images  = helper_loadImages(imageFolder,stimuli,255);
			% make data compatible with rsatoolbox:
			imlist        = struct();
			imlist.images = struct();
			for tt = 1:25
				imlist.images(tt).image = squeeze(images(tt,:,:,:));
			end
			% plot! 
			rdm = squeeze(rdmSet(ii,jj,:,:));
			dissim_dispRDM(rdm,imlist);
			idces = idces+25;
			set(gcf,'Position',[239     5   795   659]);
			title({['\bf Subject ' num2str(ii) ', Trial ' num2str(jj)]});
			saveas(gcf,['dissim_rdm_sub' num2str(ii) 'trial' num2str(jj) '.png']);
			close all;
		end
	end



end
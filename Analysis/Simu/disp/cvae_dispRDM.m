function cvae_dispRDM(rdmSet,dissimData)
	%% DISSIM_DISPGROUPRDMS_AVGALL(RDMSET,DISSIMDATA)
	%
	% plots rdm for encoder output of beta vae
	% needs dissim data as input to generate image indices
	%
	% (c) Timo Flesch, 2017
	


	imageFolder = '/home/timo/Projects/EXP_CL_TREES/exp/mturk/treetask_dissimrating/stims/'; % specifies where to find the trees

	idces = [1:25];
	
	rdm = squeeze(rdmSet(5,end,:,:)); % remember, betas = [1,2,6,10,50,100]

	figure();set(gcf,'Color',[150 150 150]./150);
	%set(gcf,'Color',[150 150 150]./255);
	stimuli = dissimData(1).stimuli(idces);
	images  = helper_loadImages(imageFolder,stimuli,255);
	% make dissimData compatible with rsatoolbox:
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
	title({['\bf Tree Dissimilaries, \beta-CVAE Encoder Output']; ['\rm test data, \beta = 50'   ]});
	% saveas(gcf,['dissim_rdm_grouplevel_' strrep(titleStr,', ','_') 'allindia.png']);
	

end
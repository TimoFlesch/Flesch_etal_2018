function disp_modelRDMs()
	%% DISP_MODELRDMS()
	% 
	% displays model rdms and saves figures 
	%
	% Timo Flesch, 2017

	%% MAIN
	rdmSet = compute_modelRDMs;

	titleNames = {'Pixel Dissimilarity - NorthSouth', 'Pixel Dissimilarity - SouthNorth', 'Branch-x-Leaf Grid Dissimilarity', 'Both North - Cardinal', 'Both South - Cardinal', 'First North, Second South - Cardinal', ' First South, Second North - Cardinal', 'Both North - Diagonal', 'Both South - Diagonal', 'First North, Second South - Diagonal', ' First South, Second North - Diagonal'};
	saveNames = {'PixelDissimilarity_NorthSouth', 'PixelDissimilarity_SouthNorth', 'BranchLeaf_Grid_Dissimilarity', 'BothNorth_Cardinal', 'BothSouth_Cardinal', 'FirstNorth_SecondSouth_Cardinal', ' FirstSouth_SecondNorth_Cardinal', 'BothNorth_Diagonal', 'BothSouth_Diagonal', 'FirstNorth_SecondSouth_Diagonal', ' FirstSouth_SecondNorth_Diagonal'};

	labelCodes = {'ns','sn','ns','nn','ss','ns','sn','nn','ss','ns','sn'};

	imageLabels= helper_makeImageLabelSet();

	for ii = 1:length(labelCodes)
		figure();set(gcf,'Color','w');

		trees      = flip(imageLabels.(labelCodes{ii}));
		imlist        = struct();
		imlist.images = struct();
		for tt = 1:size(trees,1)
			imlist.images(tt).image = squeeze(trees(tt,:,:,:));
		end
		dissim_dispRDM(squeeze(rdmSet(ii,:,:)),imlist);
		set(gcf,'Position',[239     5   795   659]);
		title({['\bf ' titleNames{ii}]});
		cb = colorbar();
		ylabel(cb,'Dissimilarity');

		savefig(['modelRDMs_' saveNames{ii} '.fig']);
		saveas(gcf,['modelRDMs_' saveNames{ii} '.png']);
		saveas(gcf,['modelRDMs_' saveNames{ii} '.svg']);
		close all;
	end

end


function imLabels = helper_makeImageLabelSet()
	% make labels for ns, sn, nn and ss conditions
	load('tree_imgs.mat');

	trees       = cast(trees,'double')./255;
	imLabels    =                  struct();
	
	imLabels.sn = cat(1,trees(26:50,:,:,:),trees(1:25,:,:,:));
	imLabels.nn =   cat(1,trees(1:25,:,:,:),trees(1:25,:,:,:));
	imLabels.ss =       cat(1,trees(26:50,:,:,:),trees(26:50,:,:,:));
	imLabels.ns =                                trees;


end

function cnn_disp_rdms(rdmCollection, taskorder, bound)
	%% CNN_DISP_RDMS(RDMCOLLECTION,TITLESTR)
	%
	% displays rdms of layer and output activity patterns
	% for single tasks and both tasks 
	% saves figures as fig,svg,png 
	%
	% Timo Flesch, 2017


	tasks           = {'first','second','both'};
	curricula       = {'blocked','interleaved'};
	% layers          = {'layerConv1Test','layerConv2Test','layerfc1Test','layerfc2Test'};
	layers          = {'layerfc1Test','layerfc2Test'};
	numTestSessions = 2;
	
	
	for c = curricula	
		% iterate through sessions and compute rdms
		for ll = layers
			for sess = 1:numTestSessions
				for taskID = tasks
					rdm = squeeze(mean(rdmCollection.(c{1}).(ll{1}).(taskID{1})(:,sess,:,:),1));
					helper_dispRDM(rdm,c{1},ll{1},sess,taskID{1},taskorder,bound);
				end
			end
		end
	end


end

function helper_dispRDM(rdm,curriculum,layer,sess,task,taskorder,bound)
	%% displays rdm 
	
	% 0. create figure
	figure();set(gcf,'color','w');
	% 1. load suitable label images 
	load('/media/timo/2CA562973F3C77EC/Research_Assistant/Projects/EXP_CL_TREES/analysis/data/auxiliar/tree_imgs');
	if (strcmp(taskorder,'ns'))
		switch task		
		case 'first'
			trees = cast(trees(1:25,:,:,:),'double')./255;
			taskTitle = 'First Task';
		case 'second'
			trees = cast(trees(26:end,:,:,:),'double')./255;
			taskTitle = 'Second Task';
		case 'both'
			trees = cast(trees,'double')./255;
			taskTitle = 'Both Tasks';
		end
	else 
		switch task		
		case 'first'
			trees = cast(trees(26:50,:,:,:),'double')./255;
			taskTitle = 'First Task';
		case 'second'
			trees = cast(trees(1:25,:,:,:),'double')./255;
			taskTitle = 'Second Task';
		case 'both'
			trees = cast(cat(1,trees(26:50,:,:,:),trees(1:25,:,:,:)),'double')./255;
			taskTitle = 'Both Tasks';
		end
	end
	trees      = flip(trees);
	imlist        = struct();
	imlist.images = struct();
	for tt = 1:size(trees,1)
		imlist.images(tt).image = squeeze(trees(tt,:,:,:));
	end
	% 2. make figure
	dissim_dispRDM(rdm,imlist);
	% 3. adjust and save
	set(gcf,'Position',[239     5   795   659]);
	title({['\bf Feature Dissimilarity, ' upper(layer(6)) lower(layer(7:end-4)) ' Layer, ' taskTitle]; ['\rm' bound ' boundary, ' taskorder '-' curriculum ' training, TestSess' num2str(sess)]});
	cb = colorbar();
	ylabel(cb,'Dissimilarity');
	saveas(gcf,['simu_rdm_' bound '_' taskorder '_' curriculum '_' layer '_testsess' num2str(sess) '_' task '_cnn_cvae_3D_beta1000.png']);
	saveas(gcf,['simu_rdm_' bound '_' taskorder '_' curriculum '_' layer '_testsess' num2str(sess) '_' task '_cnn_cvae_3D_beta1000.svg']);
	savefig(['simu_rdm_' bound '_' taskorder '_' curriculum '_' layer '_testsess' num2str(sess) '_' task '_cnn_cvae_3D_beta1000.fig']);
	close all;

end
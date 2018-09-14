function cnn_visualizeFiltersAndOutputs()
%% VISUALIZEFILTERSANDOUTPUTS
%
%
% visualises filters and outputs of conv filters of trained cnn
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, 
% University of Oxford


% 1. load data 
load('cnn__blurred_blocked_1_ns_0.mat')
weights_blockedNS = wConv;
out1_North_blockedNS = owConvNorth;
out1_South_blockedNS = owConvSouth;
out2_North_blockedNS = owConv2North;
out2_South_blockedNS = owConv2South;

load('cnn__blurred_blocked_1_sn_0.mat')
weights_blockedSN = wConv;
out1_North_blockedSN = owConvNorth;
out1_South_blockedSN = owConvSouth;
out2_North_blockedSN = owConv2North;
out2_South_blockedSN = owConv2South;


load('cnn__blurred_interleaved_1_ns_0.mat')
weights_interleavedNS = wConv;
out1_North_interleavedNS = owConvNorth;
out1_South_interleavedNS = owConvSouth;
out2_North_interleavedNS = owConv2North;
out2_South_interleavedNS = owConv2South;






% % 1. CNN Filters
% % (a) raw filters, subplots for each session. columns for test phase, rows for curricula
% helper_plot_filters(weights_blockedNS,'Blocked,N-S-N-S',0);
% helper_plot_filters(weights_blockedSN,'Blocked,S-N-S-N',0);
% helper_plot_filters(weights_interleavedNS,'Interleaved',0);

% % (b) smoothed filters, same as above 
% helper_plot_filters(weights_blockedNS,'Blocked,N-S-N-S',1);
% helper_plot_filters(weights_blockedSN,'Blocked,S-N-S-N',1);
% helper_plot_filters(weights_interleavedNS,'Interleaved',1);

% % (c) smoothed filters, rgb2gray, same as above 
% helper_plot_filters(weights_blockedNS,'Blocked,N-S-N-S',1,1);
% helper_plot_filters(weights_blockedSN,'Blocked,S-N-S-N',1,1);
% helper_plot_filters(weights_interleavedNS,'Interleaved',1,1);
% (c) randomly initialized filter, rgb and gray,  same as above

%% 2. CNN Output, convlayer 1
% rows for tasks (2), columns for curricula, figures for test phases
% test phase 1
% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_North_blockedNS,1)
% title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 1'})
% subplot(1,3,2)
% helper_plot_output(out1_North_blockedSN,1)
% title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 1'})
% subplot(1,3,3)
% helper_plot_output(out1_North_interleavedNS,1)
% title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 1'})

% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_South_blockedNS,1)
% title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 1'})
% subplot(1,3,2)
% helper_plot_output(out1_South_blockedSN,1)
% title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 1'})
% subplot(1,3,3)
% helper_plot_output(out1_South_interleavedNS,1)
% title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 1'})

% % test phase 2
% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_North_blockedNS,2)
% title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 2'})
% subplot(1,3,2)
% helper_plot_output(out1_North_blockedSN,2)
% title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 2'})
% subplot(1,3,3)
% helper_plot_output(out1_North_interleavedNS,2)
% title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 2'})

% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_South_blockedNS,2)
% title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 2'})
% subplot(1,3,2)
% helper_plot_output(out1_South_blockedSN,2)
% title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 2'})
% subplot(1,3,3)
% helper_plot_output(out1_South_interleavedNS,2)
% title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 2'})


% % test phase 3
% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_North_blockedNS,3)
% title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 3'})
% subplot(1,3,2)
% helper_plot_output(out1_North_blockedSN,3)
% title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 3'})
% subplot(1,3,3)
% helper_plot_output(out1_North_interleavedNS,3)
% title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 3'})

% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_South_blockedNS,3)
% title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 3'})
% subplot(1,3,2)
% helper_plot_output(out1_South_blockedSN,3)
% title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 3'})
% subplot(1,3,3)
% helper_plot_output(out1_South_interleavedNS,3)
% title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 3'})

% % test phase 4
% %figure();set(gcf,'Color','w');
% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_North_blockedNS,4)
% title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 4'})
% subplot(1,3,2)
% helper_plot_output(out1_North_blockedSN,4)
% title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 4'})
% subplot(1,3,3)
% helper_plot_output(out1_North_interleavedNS,4)
% title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 4'})

% figure();set(gcf,'Color','w');
% subplot(1,3,1)
% helper_plot_output(out1_South_blockedNS,4)
% title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 4'})
% subplot(1,3,2)
% helper_plot_output(out1_South_blockedSN,4)
% title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 4'})
% subplot(1,3,3)
% helper_plot_output(out1_South_interleavedNS,4)
% title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 4'})

%% 3. CNN Output, convlayer 2
% same as above 
figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_North_blockedNS,1)
title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 1'})
subplot(1,3,2)
helper_plot_output(out2_North_blockedSN,1)
title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 1'})
subplot(1,3,3)
helper_plot_output(out2_North_interleavedNS,1)
title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 1'})

figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_South_blockedNS,1)
title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 1'})
subplot(1,3,2)
helper_plot_output(out2_South_blockedSN,1)
title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 1'})
subplot(1,3,3)
helper_plot_output(out2_South_interleavedNS,1)
title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 1'})

% test phase 2
figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_North_blockedNS,2)
title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 2'})
subplot(1,3,2)
helper_plot_output(out2_North_blockedSN,2)
title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 2'})
subplot(1,3,3)
helper_plot_output(out2_North_interleavedNS,2)
title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 2'})

figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_South_blockedNS,2)
title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 2'})
subplot(1,3,2)
helper_plot_output(out2_South_blockedSN,2)
title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 2'})
subplot(1,3,3)
helper_plot_output(out2_South_interleavedNS,2)
title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 2'})


% test phase 3
figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_North_blockedNS,3)
title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 3'})
subplot(1,3,2)
helper_plot_output(out2_North_blockedSN,3)
title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 3'})
subplot(1,3,3)
helper_plot_output(out2_North_interleavedNS,3)
title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 3'})

figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_South_blockedNS,3)
title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 3'})
subplot(1,3,2)
helper_plot_output(out2_South_blockedSN,3)
title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 3'})
subplot(1,3,3)
helper_plot_output(out2_South_interleavedNS,3)
title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 3'})

% test phase 4
%figure();set(gcf,'Color','w');
figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_North_blockedNS,4)
title({'\bf North Task';'\bf blocked N-S-N-S'; '\rm Test Phase 4'})
subplot(1,3,2)
helper_plot_output(out2_North_blockedSN,4)
title({'\bf North Task';'\bf blocked S-N-S-N'; '\rm Test Phase 4'})
subplot(1,3,3)
helper_plot_output(out2_North_interleavedNS,4)
title({'\bf North Task';'\bf interleaved'; '\rm Test Phase 4'})

figure();set(gcf,'Color','w');
subplot(1,3,1)
helper_plot_output(out2_South_blockedNS,4)
title({'\bf South Task';'\bf blocked N-S-N-S'; '\rm Test Phase 4'})
subplot(1,3,2)
helper_plot_output(out2_South_blockedSN,4)
title({'\bf South Task';'\bf blocked S-N-S-N'; '\rm Test Phase 4'})
subplot(1,3,3)
helper_plot_output(out2_South_interleavedNS,4)
title({'\bf South Task';'\bf interleaved'; '\rm Test Phase 4'})
end


function helper_plot_filters(filtMat,titleStr,doInterp,doGray)

if ~exist('doInterp') doInterp = 0;
end 
if ~exist('doGray') doGray = 0;
end 




if doInterp
	tmp = [];
	for ii = 1:4
	tmp(ii,:,:,:,:) = imresize(squeeze(filtMat(ii,:,:,:,:)),10);	
	end
	filtMat = tmp;
	for ii = 1:4
	filtMat(ii,41:45,41:45,:,:,:,:) = 0;
	end 
else 
	for ii = 1:4
	filtMat(ii,5,5,:,:,:,:) = 0;
	end 
end 

if doGray 
	tmp = [];
	for ii = 1:4
		for jj = 1:32
			tmp(ii,:,:,jj) = rgb2gray(squeeze(filtMat(ii,:,:,:,jj)));
		end
	end
	filtMat = tmp;
	
end

figure();set(gcf,'Color','w');

subplot(1,4,1);
if doGray 
	w = (squeeze(filtMat(1,:,:,:))); 
	w = reshape(w,[1,size(w)]);
	size(w)
	w = permute(w,[2,3,1,4]);
	size(w)
else
	w = (squeeze(filtMat(1,:,:,:,:))); 
end
size(w)
montage(w*100);
;
title({'\bf ConvLayer1 Weights';'\rm Test Phase 1';titleStr});

subplot(1,4,2);
if doGray 
	w = (squeeze(filtMat(2,:,:,:))); 
	w = reshape(w,[1,size(w)]);
	w = permute(w,[2,3,1,4]);
else
	w = (squeeze(filtMat(2,:,:,:,:))); 
end
montage(w*100);
;
title({'\bf ConvLayer1 Weights';'\rm Test Phase 2';titleStr});

subplot(1,4,3);
if doGray 
	w = (squeeze(filtMat(3,:,:,:))); 
	w = reshape(w,[1,size(w)]);
	w = permute(w,[2,3,1,4]);
else
	w = (squeeze(filtMat(3,:,:,:,:))); 
end
montage(w*100);
;
title({'\bf ConvLayer1 Weights';'\rm Test Phase 3';titleStr});

subplot(1,4,4);
if doGray 
	w = (squeeze(filtMat(4,:,:,:))); 
	w = reshape(w,[1,size(w)]);
	w = permute(w,[2,3,1,4]);
else
	w = (squeeze(filtMat(4,:,:,:,:))); 
end
montage(w*100);
;
title({'\bf ConvLayer1 Weights';'\rm Test Phase 4';titleStr});

set(gcf,'Position',[ 56         273        1307         412])
end


function helper_plot_output(im,taskID)

im = squeeze(im(taskID,:,:,:,:));
im = reshape(im,[1,size(im)]);
montage(permute(im,[2,3,1,4])*5);

end 
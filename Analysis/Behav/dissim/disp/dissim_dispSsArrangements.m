function dissim_dispSsArrangements(data,titleString,doParfor)	
	%% DISSIM_DISPSSARRANGEMENTS(DATA,TITLESTRING)
	%
	% plots trial-wise single subject arrangements
	% - one figure per subject
	% - one subplot per trial (2x3)
	% - id and duration in figure name 
	%
	% Input: 
	% dissimdata struct (from dissim_getAllData.m)
	if ~exist('titleString')
		titleString = 'testimg';
	end
	if ~exist('doParfor')
		doParfor = false
	end

	if doParfor
		parpool(32)
		numWorkers = 32;
	else 
		numWorkers = 0;
	end

	numTrials = 6;
	subX      = 2;
	subY      = 3;

	parfor(ii = 1:length(data),numWorkers)
		disp(['processing subject ' num2str(ii)]);
		%figure('Name',['sub ' num2str(ii) ', t=' num2str(floor(data(ii).edata.duration))]); set(gcf,'Color','w');
		figure(); set(gcf,'Color','w');
		for trialID=1:numTrials
			tmp = dissim_generateArrangementImg(data(ii).stimuli,data(ii).data,trialID);
			subplot(subX,subY,trialID);
			imshow(tmp);
			axis square;
			xlabel([]);
			ylabel([]);
			title(['Trial ' num2str(trialID)],'FontWeight','normal');			
		end
		set(gcf,'Position',[ 220          56        1558         922]);
		saveas(gcf,[titleString '_sub' num2str(ii) '.png']);
		close all;
	end 
	if numWorkers > 0
		delete(gcp);
	end
end

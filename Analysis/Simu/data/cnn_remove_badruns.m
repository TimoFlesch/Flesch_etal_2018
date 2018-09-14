function cnn_remove_badruns()
	%% CNN_REMOVE_BADRUNS()
	%
	% removes runs where network diverged
	% note: happened only in a few runs,
	% potentially due to bad initialisation
	% note: this happened only in the blocked curriculum
	%
	% Timo Flesch, 2017
	 
	% original cnn_final 
	% fileNames = {'cardinal_ns_mp',
	% 			'cardinal_ns_pm',
	% 			'cardinal_sn_pp',
	% 			'cardinal_sn_mm',
	% 			'cardinal_sn_mp',
	% 			'cardinal_sn_pm',
	% 			'diagonal_sn_mp',
	% 			'diagonal_sn_pm'};
	% % badRuns = {[4],
	% 		[1],
	% 		[2,4,5],
	% 		[4],
	% 		[1,5],
	% 		[3],
	% 		[1,4,5],
	% 		[1]};

	% % cnn final with corrected layer activity files
	% fileNames = {'cardinal_ns_mp',
	% 			'cardinal_ns_pm',
	% 			'cardinal_sn_mm',
	% 			'cardinal_sn_mp',
	% 			'cardinal_sn_pm',
	% 			'diagonal_ns_mp'};

	% badRuns = { [2,3],
	% 			 [2],
	% 			 [4],
	% 			 [1],
	% 			 [4],
	% 			 [4]};


    % cnn-cvae-beta50
 %    fileNames = {'cardinal_ns_pp',
	% 			'cardinal_ns_mp',
	% 			'cardinal_ns_pm',
	% 			'cardinal_sn_mp',
	% 			'cardinal_sn_pm',
	% 			'diagonal_ns_mp',
	% 			'diagonal_ns_pm',
	% 			'diagonal_sn_mp',
	% 			'diagonal_sn_pm'};

	% badRuns = {[2],
	% 			[3],
	% 			[5],
	% 			[1,2,5],
	% 			[1,3],
	% 			[2,4,5],
	% 			[2,3,4,5],
	% 			[2,3],
	% 			[1]};

	% cnn-cvae-3d-beta1000
% 	fileNames = {'cardinal_ns_pp', 
% 'cardinal_ns_mm',
% 'cardinal_sn_mp',
% 'cardinal_sn_pm',
% 'diagonal_ns_mp',
% 'diagonal_ns_pm',
% 'diagonal_sn_pm'};
% 	badRuns   = {[4],
% [3,4],
% [2],
% [1],
% [1,2,3],
% [1,2,3],
% [1,2]};

% cnn-cvae-3d-beta1
fileNames={'cardinal_ns_mm',
'cardinal_sn_mp',
'diagonal_ns_mp',
'diagonal_ns_pm',
'diagonal_sn_mp',
'diagonal_sn_pm'};
badRuns={[1,3],
[1],
[1,2,3],
[1,2,3],
[3],
[1,3]};

	 for brID = 1:length(badRuns)	 	
	 	load(['allRuns_cnn_cvae_3D_beta1_' fileNames{brID} '.mat']);
	 	fns = fieldnames(allRuns.cnn.blocked.resp);
	 	for fid = 1:length(fns)
	 		fn = fns{fid};
	 		if(ndims(allRuns.cnn.blocked.resp.(fn))==4)
	 			allRuns.cnn.blocked.resp.(fn)(badRuns{brID},:,:,:) = [];
 			else 
 				allRuns.cnn.blocked.resp.(fn)(badRuns{brID},:,:) = [];
			end			
		end
		fns = fieldnames(allRuns.cnn.blocked.exp);
		for fid = 1:length(fns)
	 		fn = fns{fid};
			allRuns.cnn.blocked.exp.(fn)(badRuns{brID},:,:) = [];
		end
		save(['allRuns_cnn_cvae_3D_beta1_' fileNames{brID} '.mat'],'allRuns');
	 end


	end


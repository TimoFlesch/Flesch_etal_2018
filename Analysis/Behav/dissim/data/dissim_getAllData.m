function dissim_getAllData(dataDir)
	%% DISSIM_GETALLDATA(DATADIR)
	%
	% helper function which imports all single subject data files
	% and reorganises the relevant fields in a group-level
	% struct with fields edata (subject etc), data (main),
	% structure (column ids of data) and stimuli (file names)
	%
	% normalizes the coordinates: coords = coords;%./max(coords)
	%
	% !!! NOW requires renamed data (see rew scripts) !!!
	% set datadir as /data/renamed/ with subdirs cardinal and diagonal
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department, University of Oxford

	if(~exist('dataDir'))
		disp('please set file directory!');
		return;
	end

	%% MAIN
	%subs_names  = strsplit(ls(dataDir));
	% subs_total  = length(subs_names)-1;
	boundary_groups = {'cardinal','diagonal'};
	exp_parts       = {'pre','post'};

	badsubs = {[],[]};
	badarrangement = {[],[]};
	subs_total = [95,90]; % moreIndia


	% do the magic
	for taskID = 1:length(exp_parts)
		thisTask = exp_parts{taskID};

		for bGroup = 1:length(boundary_groups)
			% subjects = subs_groups(bGroup).subs;
			dissimData_blocked     = struct();
			dissimData_interleaved = struct();
			dissimData_all         = struct();
			ii_bl  = 1;
			ii_in  = 1;


			subjects = 1:subs_total(bGroup);
			subjects(badsubs{bGroup}) = [];
			subjects(badarrangement{bGroup}) = [];
			sIDX = 1;
			% load and add data
			for ii = 1:length(subjects)
				subj = subjects(ii);

				tmp   = load([dataDir '/' boundary_groups{bGroup} '/s' num2str(subjects(ii))]);
				names =                    fieldnames(tmp);
				data  =                      tmp.(names{1});
				if strcmp(data.task_id{1},'blocked')
					% EDATA	- BLOCKED
					% copy into collection
					dissimData_blocked(ii_bl).edata  = data.edata;
					% boundary index
					dissimData_blocked(ii_bl).boundaryIDX = data.parameters.val_rewAssignment;
					% dissimData_blocked(ii_bl).edata.duration = (data.edata.exp_finishtime-data.edata.exp_starttime)/1000/60;

					% DISSIM - BLOCKED
				    dissimData_blocked(ii_bl).data     = [];
				    dissimData_blocked(ii_bl).structure = 'trial | leaf | branch | x_orig | y_orig | x_final | y_final';
				    dissimData_blocked(ii_bl).data(:,1) = data.([thisTask '_dissimData']).([thisTask '_trialID']);
				    dissimData_blocked(ii_bl).data(:,2) = data.([thisTask '_dissimData']).([thisTask '_stimLeafLevel']);
				    dissimData_blocked(ii_bl).data(:,3) = data.([thisTask '_dissimData']).([thisTask '_stimBranchLevel']);
				    dissimData_blocked(ii_bl).data(:,4) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,1);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,1));
				    dissimData_blocked(ii_bl).data(:,5) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,2);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,2));
				    dissimData_blocked(ii_bl).data(:,6) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,1);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,1));
				    dissimData_blocked(ii_bl).data(:,7) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,2);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,2));

				    % EXEMPLARS - BLOCKED
				    dissimData_blocked(ii_bl).stimuli = data.([thisTask '_dissimData']).([thisTask '_stimNames']);
				    disp(['total sub' num2str(ii) ' ' boundary_groups{bGroup} ', block sub' num2str(ii_bl)])
				    ii_bl = ii_bl+1;
			    else
				    % EDATA	- INTERLEAVED
					% copy into collection
				    dissimData_interleaved(ii_in).edata  = data.edata;
					% dissimData_interleaved(ii_in).edata.duration = (data.edata.exp_finishtime-data.edata.exp_starttime)/1000/60;
					% boundary index
					dissimData_interleaved(ii_in).boundaryIDX = data.parameters.val_rewAssignment;
					% DISSIM - INTERLEAVED
				    dissimData_interleaved(ii_in).data     = [];
				    dissimData_interleaved(ii_in).structure = 'trial | leaf | branch | x_orig | y_orig | x_final | y_final';
				    dissimData_interleaved(ii_in).data(:,1) = data.([thisTask '_dissimData']).([thisTask '_trialID']);
				    dissimData_interleaved(ii_in).data(:,2) = data.([thisTask '_dissimData']).([thisTask '_stimLeafLevel']);
				    dissimData_interleaved(ii_in).data(:,3) = data.([thisTask '_dissimData']).([thisTask '_stimBranchLevel']);
				    dissimData_interleaved(ii_in).data(:,4) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,1);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,1));
				    dissimData_interleaved(ii_in).data(:,5) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,2);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,2));
				    dissimData_interleaved(ii_in).data(:,6) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,1);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,1));
				    dissimData_interleaved(ii_in).data(:,7) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,2);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,2));

				    % EXEMPLARS - INTERLEAVED
				    dissimData_interleaved(ii_in).stimuli = data.([thisTask '_dissimData']).([thisTask '_stimNames']);
				    disp(['total sub' num2str(ii) ' ' boundary_groups{bGroup}  ', interleaved sub' num2str(ii_bl)])
				    ii_in = ii_in+1;
				end
				dissimData_all(ii).edata  = data.edata;
				% boundary index
				dissimData_all(ii).boundaryIDX = data.parameters.val_rewAssignment;
				% dissimData_all(ii).edata.duration = (data.edata.exp_finishtime-data.edata.exp_starttime)/1000/60;

				% DISSIM - ALL
			    dissimData_all(ii).data     = [];
			    dissimData_all(ii).structure = 'trial | leaf | branch | x_orig | y_orig | x_final | y_final';
			    dissimData_all(ii).data(:,1) = data.([thisTask '_dissimData']).([thisTask '_trialID']);
			    dissimData_all(ii).data(:,2) = data.([thisTask '_dissimData']).([thisTask '_stimLeafLevel']);
			    dissimData_all(ii).data(:,3) = data.([thisTask '_dissimData']).([thisTask '_stimBranchLevel']);
			    dissimData_all(ii).data(:,4) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,1);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,1));
			    dissimData_all(ii).data(:,5) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,2);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Orig'])(:,2));
			    dissimData_all(ii).data(:,6) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,1);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,1));
			    dissimData_all(ii).data(:,7) = data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,2);%./max(data.([thisTask '_dissimData']).([thisTask '_stimCoords_Final'])(:,2));

			    % EXEMPLARS - ALL
			    dissimData_all(ii).stimuli = data.([thisTask '_dissimData']).([thisTask '_stimNames']);
			    dissimData_all(ii).code    = data.subID';
			end

			dissimData = dissimData_blocked;
			save([dataDir '/../results/dissimData_' boundary_groups{bGroup}  '_B200_' thisTask '.mat'],'dissimData');
			dissimData = dissimData_interleaved;
			save([dataDir '/../results/dissimData_' boundary_groups{bGroup}  '_INT_' thisTask '.mat'],'dissimData');
			dissimData = dissimData_all;
			save([dataDir '/../results/dissimData_' boundary_groups{bGroup}  '_allSubs_' thisTask '.mat'],'dissimData');
		end
	end
end

function wrapper_dissim_computeRDMCorrelations()
	%% WRAPPER_DISSIM_COMPUTERDMCORRELATIONS()
	%
	% computes rdm model correlations for all subjects
	% and all conditions
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford

	curricula       =               {'B200','INT'};
	exp_phases      =               {'pre','post'};
	boundary_groups =      {'cardinal','diagonal'};

	modelRDMs_1D = dissim_computeModelRDMs_1D();
	modelRDMs_2D = dissim_computeModelRDMs_2D();
	modelRDMs_features = dissim_computeModelRDMs_features();
	modelRDMs_1D = modelRDMs_1D.rdmSet;
	modelRDMs_2D = modelRDMs_2D.rdmSet;
	modelRDMs_features = modelRDMs_features.rdmSet;
	modelRDMs_features(end+1,:,:) = squeeze(modelRDMs_2D(2,:,:)); % branch cluster 2d
	modelRDMs_features(end+1,:,:) = squeeze(modelRDMs_2D(3,:,:)); % leaf cluster 2d

	for cIDX = 1:length(curricula)
		for bIDX = 1:length(boundary_groups)
			for eIDX = 1:length(exp_phases)
				% load pixel rdms
				%load(['rdmSet_pixelRDMs_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '_premainpost_FULL.mat']);
                pixelRDMs = [];%rdmSet;
                %clear rdmSet;
				% load subject rdms
				load(['rdmSet_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat']);

				% load subject data and prepare boundaryvect
				load(['dissimData_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat']);				
				boundaryIdces = [];
				for ii = 1:length(dissimData)
					boundaryIdces(ii) = dissimData(ii).boundaryIDX;
				end
				modelIDs_1D = helper_selectModels(boundaryIdces,'1D');
				modelIDs_2D = helper_selectModels(boundaryIdces,'2D');

				% compute correlation coefficients
				tauas_1D = dissim_computeRDMCorrelations(modelRDMs_1D, pixelRDMs, rdmSet, modelIDs_1D);
				tauas_2D = dissim_computeRDMCorrelations(modelRDMs_2D, pixelRDMs, rdmSet, modelIDs_2D);
				tauas_features = dissim_computeRDMCorrelations_features(modelRDMs_features,pixelRDMs,rdmSet);

				% save results
				save(['tauas_1D_modelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat'],'tauas_1D');
				save(['tauas_2D_modelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat'],'tauas_2D');
				save(['tauas_features_modelRDM_correlations_' boundary_groups{bIDX}  '_group' curricula{cIDX} '_' exp_phases{eIDX} '.mat'],'tauas_features');

			end
		end
	end


end

function modelIDs = helper_selectModels(boundaryIdces,dimensionality)
    % returns vector with model IDs
    if strcmp(dimensionality,'1D')
        % first two are task dimensions, third is always combination/bias
        % rows for different clustering assumptions (linear, clustered, etc)
        % -------------linear,cluster_equal,cluster_highrew,cluster_lowrew----
        idSet(1,:,:) = [1,2,3;5,6,7;9,10,11;13,14,15]; % c++
        idSet(2,:,:) = [1,2,3;5,6,7;13,14,15;9,10,11]; % c-- (same as rdms sign invariant)
        idSet(3,:,:) = [1,2,4;5,6,8;13,10,16;9,14,12]; % c-+
        idSet(4,:,:) = [1,2,4;5,6,8;9,14,12;13,10,16]; % c+-

        idSet(5,:,:) = [3,4,1;7,8,5;11,12,9;15,16,13]; % d++
        idSet(6,:,:) = [3,4,1;7,8,5;15,16,13;11,12,9]; % d--
        idSet(7,:,:) = [3,4,2;7,8,6;15,12,14;11,16,10];% d-+
        idSet(8,:,:) = [3,4,2;7,8,6;11,16,10;15,12,14];% d+-
    elseif strcmp(dimensionality,'2D')
        % first two are task dimensions, third is always combination/bias
        % rows for different clustering assumptions (linear, clustered, etc)
        % ------------grid,cluster_equal,cluster_highrew,cluster_lowrew ----
        idSet(1,:,:) = [1,1,1;2,3,4;6,7,9;10,11,13]; % c++
        idSet(2,:,:) = [1,1,1;2,3,4;10,11,13;6,7,9]; % c--
        idSet(3,:,:) = [1,1,1;2,3,5;10,7,12;6,11,8]; % c-+
        idSet(4,:,:) = [1,1,1;2,3,5;6,11,8;10,7,12]; % c+-

        idSet(5,:,:) = [1,1,1;4,5,2;8,9,6;12,13,10]; % d++
        idSet(6,:,:) = [1,1,1;4,5,2;12,13,10;8,9,6]; % d--
        idSet(7,:,:) = [1,1,1;4,5,3;12,9,7;8,13,11]; % d-+
        idSet(8,:,:) = [1,1,1;4,5,3;8,13,11;12,9,7]; % d+-

    end
    for jj = 1:length(boundaryIdces)
        modelIDs(jj,:,:) = squeeze(idSet(boundaryIdces(jj),:,:));
    end

end

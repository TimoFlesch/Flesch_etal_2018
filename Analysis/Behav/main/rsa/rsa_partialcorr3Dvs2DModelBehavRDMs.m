function taus = rsa_partialcorr3Dvs2DModelBehavRDMs(rdmCollection,isDiag)
%% TAUS = RSA_PARTIALCORR3Dvs2DMODELBEHAVRDMS(RDMCOLLECTION,ISDIAG)
%
% for all behavioural rdms in rdmcollection, compute
% pairwise partial correlations with candidate model rdms (categorical)
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department,
% University of Oxford

	taus = struct();

	if isDiag
	    modLeaf   = rsa_genCategoricalModelRDM(3);
	    modBranch = rsa_genCategoricalModelRDM(4);
	    modDiag   = rsa_genCategoricalModelRDM(2); % branch is interaction

	else
	    modLeaf   = rsa_genCategoricalModelRDM(1);
	    modBranch = rsa_genCategoricalModelRDM(2);
	    modDiag   = rsa_genCategoricalModelRDM(3); % diag 1 is interaction

	end
	% rdmLeaf       =   modLeaf.choiceRDM;
	% rdmBranch     = modBranch.choiceRDM;
	% rdmDiag       =   modDiag.choiceRDM;

	rdm3Dmod   = squareform(pdist([modBranch.choiceMat(:);modLeaf.choiceMat(:)]));
	rdm2Dmod   = squareform(pdist([modDiag.choiceMat(:);modDiag.choiceMat(:)]));

	% define variables to loop through
	groupNamesIn  = {'bl200','bl20','bl2','in'};
	groupNamesOut =   {'b200','b20','b2','int'};
	% groupNamesIn  =     {'bl200','in'};
	% groupNamesOut =     {'b200','int'};
	% groupNamesIn  =     {'bl200'};
	% groupNamesOut =     {'b200'};
	phaseNames    =   {'train','test'};



	% b200,b20,b20,int:
	for groupID = 1:length(groupNamesIn)
		groupIn  =  groupNamesIn{groupID};
		groupOut = groupNamesOut{groupID};

		nSubsGroup = size(rdmCollection.train.(groupIn).le,1);

		% train, test:
		for phaseID = 1:length(phaseNames)
			% subjects:l
			for subID = 1:nSubsGroup
					behavRDM = squeeze(rdmCollection.(phaseNames{phaseID}).(groupIn).both(subID,:,:));


					% 3d vs 2d
					taus.(phaseNames{phaseID}).(groupOut).both(subID,1) = partialcorr_Kendall_taua(behavRDM,rdm3Dmod,rdm2Dmod);
					taus.(phaseNames{phaseID}).(groupOut).both(subID,2) = partialcorr_Kendall_taua(behavRDM,rdm2Dmod,rdm3Dmod);



			end

		end
	end


end

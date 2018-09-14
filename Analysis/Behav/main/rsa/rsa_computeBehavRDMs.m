function rdmCollection = rsa_computeBehavRDMs(choiceMats)
%% RDMCOLLECTION = RSA_COMPUTEBEHAVRDMS(BASICSTATS)
%
% given a set of choice matrices, this function computes
% single subject RDMs
% and returns a subject-dim1-dim2 matrix per group
% groups: branchy vs leafy for interleaved vs blocked and training vs test
% extract choiceMatrices
%
% input: results.choicematrices

% output: rdmCollection
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, University of Oxford


rdmCollection = struct();

% groupNamesIn =   {'b200','b20','b2','int'};
% groupNamesIn =   {'b200'};
groupNamesIn =   			{'b200','int'};
% groupNames   = {'bl200','bl20','bl2','in'};
% groupNames   = {'bl200'};
groupNames   = 		    {'bl200','in'};
phaseNames   =            {'train','test'};
dimIn 	     =           {'north','south'};
dimOut       = 			       {'le','br'};



% b200,b20,b20,int:
for groupID = 1:length(groupNames)
	groupName  =  groupNames{groupID};


	nSubsGroup = size(choiceMats.train.north.(groupNamesIn{groupID}),1);

	% train, test
	for phaseID = 1:length(phaseNames)
		% all subs
		for subID = 1:nSubsGroup
			% north/south -> le/br

			for dimID = 1:length(dimIn)
				tmp =  squeeze(choiceMats.(phaseNames{phaseID}).(dimIn{dimID}).(groupNamesIn{groupID})(subID,:,:));
				rdmCollection.(phaseNames{phaseID}).(groupName).(dimOut{dimID})(subID,:,:) = squareform(pdist(tmp(:)));
			end
			matNorth = squeeze(choiceMats.(phaseNames{phaseID}).north.(groupNamesIn{groupID})(subID,:,:));
			matSouth = squeeze(choiceMats.(phaseNames{phaseID}).south.(groupNamesIn{groupID})(subID,:,:));
			tmp = [matSouth(:);matNorth(:)];
			rdmCollection.(phaseNames{phaseID}).(groupName).both(subID,:,:)	= squareform(pdist(tmp(:)));
		end

	end

end

end

function modelcomps = main_compareModels(modelfits,params,modelsToCompare)
	%
	% performs random effects bayesian model comparison (RFX-BMS) for 
	% sets of models
	% requires VBA toolbox on path
	% 
	% Timo Flesch, 2018	

    modelcomps = struct();
	for ii = 1:length(modelsToCompare) % for all sets of models to compare
		models = modelsToCompare{ii};
		modelNames = fieldnames(modelfits);
		modelNames = modelNames(models);
		%celldisp(modelNames)
        modelcomps(ii).pairs = strrep(modelNames,'_','-');
        
		for groupID = 1:length(params.groupNames)
			% compute log model evidence
			lme = [];
			for jj = 1:length(modelNames)
				lme = [lme;compute_LogEvidence(modelfits.(modelNames{jj}).(params.expPhase{1}).(params.groupNames{groupID}).gof)];
            end
            [modelcomps(ii).groups.(params.groupNames{groupID}).posterior,modelcomps(ii).groups.(params.groupNames{groupID}).out] = VBA_groupBMC(lme,params.vbaOptions);
            if params.vbaOptions.DisplayWin
            	set(gcf,'Name',[params.boundaryName, ' - ' params.groupNames{groupID}]);
            	for subID = 1:4
            		subplot(3,2,subID);
            		set(gca,'XTickLabel',modelcomps(ii).pairs);
            	end
            end
        end       
        
        % alternative: ANOVA on log model evidences :) 



    end

end
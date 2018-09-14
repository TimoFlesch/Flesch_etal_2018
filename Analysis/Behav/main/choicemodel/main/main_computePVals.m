
function stats = main_computePVals(modelfits,modelcomps,params)
	% performs ranksum tests and returns pvals, zvals and ranksums
	%
	% Timo Flesch, 2018

	stats = struct();	
	modelNames = fieldnames(modelfits);
	groupNames = fieldnames(modelfits.(modelNames{1}).(params.expPhase{1}));
	
	%% 1. model fits
	for mm = 1:length(modelNames)
		paramNames = fieldnames(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{1}));
		paramNames = paramNames(1:end-3); % ignore phi, gof and nll
		for ii = 1:length(paramNames)
			stats.modelfits.(modelNames{mm}).(paramNames{ii}) = {};
			for g1 = 1:length(groupNames)
				stats.modelfits.(modelNames{mm}).(paramNames{ii}).mu(g1,:)    = mean(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g1}).(paramNames{ii}));
				stats.modelfits.(modelNames{mm}).(paramNames{ii}).sem(g1,:)   = std(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g1}).(paramNames{ii}),0,1)./sqrt(length(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g1}).(paramNames{ii})));
				for g2 = g1+1:length(groupNames)	
					[p,~,s] = ranksum(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g1}).(paramNames{ii}),modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g2}).(paramNames{ii}));
					stats.modelfits.(modelNames{mm}).(paramNames{ii}).p(g1,g2) = p;
					stats.modelfits.(modelNames{mm}).(paramNames{ii}).z(g1,g2) = s.zval;
					stats.modelfits.(modelNames{mm}).(paramNames{ii}).rs(g1,g2) = s.ranksum;

					% [p,~,s] = ranksum(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g1}).(paramNames{ii}),modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g2}).(paramNames{ii}),'tail','left');
					% stats.modelfits.(modelNames{mm}).(paramNames{ii}).p_left(g1,g2) = p;
					% stats.modelfits.(modelNames{mm}).(paramNames{ii}).z_left(g1,g2) = s.zval;
					% stats.modelfits.(modelNames{mm}).(paramNames{ii}).ranksum_left(g1,g2) = s.ranksum;

					% [p,~,s] = ranksum(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g1}).(paramNames{ii}),modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{g2}).(paramNames{ii}),'tail','right');
					% stats.modelfits.(modelNames{mm}).(paramNames{ii}).p_right(g1,g2) = p;
					% stats.modelfits.(modelNames{mm}).(paramNames{ii}).z_right(g1,g2) = s.zval;
					% stats.modelfits.(modelNames{mm}).(paramNames{ii}).ranksum_right(g1,g2) = s.ranksum;
				end
			end
		end
	end

	%% 2. model comparisons (code assumes only pairs of competing models)
	stats.modelcomps = struct();
	for ii = 1:length(modelcomps) % for all pairwise model comparisons
		stats.modelcomps(ii).pairs = modelcomps(ii).pairs;
		for mm = 1:2 % for each model
		% between groups (within models): 
			for g1 = 1:length(groupNames)
				% for each model-x-group: compute mu and sigma model evidences				
				stats.modelcomps(ii).moments.mu(mm,g1) = mean(modelcomps(ii).groups.(groupNames{g1}).posterior.r(mm,:));
				stats.modelcomps(ii).moments.sem(mm,g1) = std(modelcomps(ii).groups.(groupNames{g1}).posterior.r(mm,:),0,2)./sqrt(length(modelcomps(ii).groups.(groupNames{g1}).posterior.r(mm,:)));

				% do statistical inference
				for  g2 = g1+1:length(groupNames)
					[p,~,s] = ranksum(modelcomps(ii).groups.(groupNames{g1}).posterior.r(mm,:),modelcomps(ii).groups.(groupNames{g2}).posterior.r(mm,:));
					stats.modelcomps(ii).betweenGroups.p(mm,g1,g2)       =         p;
					stats.modelcomps(ii).betweenGroups.z(mm,g1,g2)       =    s.zval;
					stats.modelcomps(ii).betweenGroups.rs(mm,g1,g2) = s.ranksum;			
				end
			end
		end
		% within groups (between models):
		for g = 1:length(groupNames)
			
			[p,~,s] = signrank(modelcomps(ii).groups.(groupNames{g}).posterior.r(1,:),modelcomps(ii).groups.(groupNames{g}).posterior.r(2,:));
			stats.modelcomps(ii).withinGroups.(groupNames{g}).p         =         p;
			stats.modelcomps(ii).withinGroups.(groupNames{g}).z         =    s.zval;
			stats.modelcomps(ii).withinGroups.(groupNames{g}).sr   = s.signedrank;
		end
	end

end
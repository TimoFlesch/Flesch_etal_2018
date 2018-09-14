function main_plotFittingResults(modelfits,params)
	%% MAIN_PLOTFITTINGRESULTS(MODELFITS)
	% 
	% plots results of model fitting 
	% one subplot per parameter
	% one figure per model 
	% - barplots with SEM and sigstar-bars
	% 
	% Timo Flesch, 2018
	% Human Information Processing Lab,
	% Experimental Psychology Department
	% University of Oxford



	modelNames = fieldnames(modelfits)
	groupNames = fieldnames(modelfits.(modelNames{1}).(params.expPhase{1}));
	colvals = linspace(0.2,0.8,length(groupNames));
	
	for mm = 1:length(modelNames)
		paramNames = fieldnames(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{1}));
		paramNames = paramNames(1:end-2); % ignore phi, gof and nll
		figure();set(gcf,'Color','w');
		set(gcf,'Name',modelNames{mm});
		% model parameters
		for pp = 1:length(paramNames)-1
			mu  = []; 
			sem = [];
			subplot(2,2,pp);
			for gg = 1:length(groupNames)
				%mu = [mu, mean(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp}),1)];
				%sem = [sem, std(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp}),0,1)./sqrt(length(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp})))];
				mu = mean(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp}),1);
				sem = std(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp}),0,1)./sqrt(length(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp})));
				hb = bar(gg,mu);
				hb.FaceColor = [1,1,1].*colvals(gg);
				hold on;
				eb = errorbar(gg,mu,sem,'Color','k');

			end
			if strcmp(paramNames{pp},'bias')
				title('abs bias');
			else
				title(paramNames{pp});
			end
			set(gca,'XTick',1:length(groupNames));
			set(gca,'XTickLabel',groupNames);
			box off;		
		end
		% phi of one-boundary model
		if strcmp(modelNames{mm},'free_oneBound') || strcmp(modelNames{mm},'fixed_taskLapse')
			subplot(2,2,4);
			for gg = 1:length(groupNames)
				%mu = [mu, mean(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp}),1)];
				%sem = [sem, std(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp}),0,1)./sqrt(length(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{pp})))];
				mu = mean(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{end}),1);
				sem = std(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{end}),0,1)./sqrt(length(modelfits.(modelNames{mm}).(params.expPhase{1}).(groupNames{gg}).(paramNames{end})));
				hb = bar(gg,mu);
				hb.FaceColor = [1,1,1].*colvals(gg);
				hold on;
				eb = errorbar(gg,mu,sem,'Color','k');
			end
			title(paramNames{end});
			set(gca,'XTick',1:length(groupNames));
			set(gca,'XTickLabel',groupNames);
			box off;			
		end	

	end
	% modelNames = modelNames([1,3]);
	% for mm = 1:2
	% 	figure();set(gcf,'Color','w');
	% 	set(gcf,'Name',[modelNames{mm} ' - comparison']);
	% 	for gg = 1:length(groupNames)			
				
	% 			hb = bar(gg,stats.modelcomps.moments.mu(mm,gg));
	% 			hb.FaceColor = [1,1,1].*colvals(gg);
	% 			hold on;
	% 			eb = errorbar(gg,stats.modelcomps.moments.mu(mm,gg),stats.modelcomps.moments.sem(mm,gg),'Color','k');

	% 	end
	% 	title(['Model Frequencies, ' strrep(modelNames{mm},'_','-')]);
	% 	set(gca,'XTick',1:length(groupNames));
	% 	set(gca,'XTickLabel',groupNames);
	% 	box off;	
	% end
end
function dissim_dispCorrelationResults_1D2D(taus_pre,taus_post,noiseceil_pre,noiseceil_post,titleStr,dimensionality)
	%% DISSIM_DISPCORRELATIONRESULTS_1D2D(TAUAS)
	%
	% displays results of correlation analysis
	% with one subplot per trial
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	if dimensionality == 1
		% 1d model labels
		labels = {'linear Task A', 'linear Task B', 'linear Combination', 'cluster a Task A', 'cluster a Task B', 'cluster a Combination', 'cluster b Task A', 'cluster b Task B', 'cluster b Combination','cluster c Task A', 'cluster c Task B', 'cluster c Combination'};
	else 
		% 2d model labels
		labels = {'grid', 'cluster a Task A', 'cluster a Task B', 'cluster a Combination', 'cluster b Task A', 'cluster b Task B', 'cluster b Combination','cluster c Task A', 'cluster c Task B', 'cluster c Combination'};

	end

	figure(); set(gcf,'Color','w');
	noiseceil_pre = squeeze(mean(noiseceil_pre,1));
	lb_pre = noiseceil_pre(1);
	ub_pre = noiseceil_pre(2);

	noiseceil_post = squeeze(mean(noiseceil_post,1));
	lb_post = noiseceil_post(1);
	ub_post = noiseceil_post(2);


	y_pre = squeeze(mean(taus_pre,1))';
	y_pre = y_pre(:);
	e_pre = squeeze(std(taus_pre,0,1))'./sqrt(size(taus_pre,1));
	e_pre = e_pre(:);
	
	y_post = squeeze(mean(taus_post,1))';
	y_post = y_post(:);
	e_post = squeeze(std(taus_post,0,1))'./sqrt(size(taus_post,1));
	e_post = e_post(:);
	
	if dimensionality == 2
		y_pre(2:3) = [];
		e_pre(2:3) = [];
		y_post(2:3) = [];
		e_post(2:3) = [];
	end

	b = barwitherr([e_pre,e_post],[y_pre,y_post]);	
	b(1).FaceColor = 'blue';
	b(2).FaceColor = 'green';
	set(gca,'XTickLabel',labels);
	set(gca,'XTickLabelRotation',25);
	hold on;
	fh1 = fill([xlim fliplr(xlim)],[lb_pre lb_pre ub_pre ub_pre],[0 0 1],'FaceAlpha',0.8,'LineStyle','None');
	fh2 = fill([xlim fliplr(xlim)],[lb_post lb_post ub_post ub_post],[0 1 0],'FaceAlpha',0.8,'LineStyle','None');
	ylabel('Kendall''s \tau_{a}');
	ylim([0,0.6]);
	legend([fh1,fh2],{'noise ceiling pre','noise ceiling post'});
	title({'\bf RDM Model Correlations';['\rm' titleStr]});
	box off;
	set(gcf,'Position',[403   113   872   553]);
	saveas(gcf,['modelcorrIMG_' num2str(dimensionality) 'D_' strrep(titleStr,', ','_')  '_FULL.png']);
	close all;


end

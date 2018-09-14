function dissim_dispCorrelationResults(taus_pre,taus_post,noiseceil_pre,noiseceil_post,titleStr,modelStr)
	%% DISSIM_DISPCORRELATIONRESULTS(TAUAS)
	%
	% displays results of correlation analysis
	% with one subplot per trial
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	figure(); whitebg([.97 .97 .97]);set(gcf,'Color','w');
	noiseceil_pre = squeeze(mean(noiseceil_pre,1));
	lb_pre = noiseceil_pre(1);
	ub_pre = noiseceil_pre(2);

	noiseceil_post = squeeze(mean(noiseceil_post,1));
	lb_post = noiseceil_post(1);
	ub_post = noiseceil_post(2);


	y_pre = squeeze(mean(taus_pre(:,1:3),1));
	e_pre = squeeze(std(taus_pre(:,1:3),0,1))./sqrt(size(taus_pre(:,1:3),1));

	y_post = squeeze(mean(taus_post(:,1:3),1));
	e_post = squeeze(std(taus_post(:,1:3),0,1))./sqrt(size(taus_post(:,1:3),1));
	

	b = barwitherr([e_pre',e_post'],[y_pre',y_post']);	
	b(1).FaceColor = 'blue';
	b(2).FaceColor = 'green';
	set(gca,'XTickLabel',{'Branch','Leaf','Gridiness'});%,'BranchCluster-x-Leaf','Branch-x-LeafCluster'});
	set(gca,'XTickLabelRotation',25);
	hold on;
	fh1 = fill([xlim fliplr(xlim)],[lb_pre lb_pre ub_pre ub_pre],[0 0 1],'FaceAlpha',0.6,'LineStyle','None');
	fh2 = fill([xlim fliplr(xlim)],[lb_post lb_post ub_post ub_post],[0 1 0],'FaceAlpha',0.6,'LineStyle','None');
	ylabel('Kendall''s \tau_{a}');
	ylim([0,0.35]);
	set(gca,'XTick',1:3);
	legend([fh1,fh2],{'PRE session','POST session'});
	title({'\bf RDM Model Correlations';['\rm' titleStr]});
	box off;
	saveas(gcf,['modelcorrIMG_FEATURES_' strrep(titleStr,', ','_')  '_allindia.png']);
	saveas(gcf,['modelcorrIMG_FEATURES_' strrep(titleStr,', ','_')  '_allindia.svg']);
	close all;


end

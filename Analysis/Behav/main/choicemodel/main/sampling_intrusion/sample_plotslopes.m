function sample_plotslopes(sigmas)
%% SAMPLE_PLOTSLOPES(SIGMAS)
%
% plots group-mean + sem of estimated slope parameter
% Timo Flesch, 2018

groupNames = fieldnames(sigmas);
dims       =    {'rel','irrel'};
colvals = linspace(0.2,0.8,length(groupNames));

for dim = 1:length(dims)				
	figure();set(gcf,'Color','w');
	for gg = 1:length(groupNames)
		% average tasks:
		sgms = mean([sigmas.(groupNames{gg}).north.(dims{dim}),sigmas.(groupNames{gg}).south.(dims{dim})],2);
		mu = mean(sgms,1);
		sem = std(sgms,0,1)./sqrt(length(sgms));
		hb = bar(gg,mu);
		hb.FaceColor = [1,1,1].*colvals(gg);
		hold on;
		eb = errorbar(gg,mu,sem,'Color','k');	
	end
	set(gca,'XTick',1:length(groupNames));
	set(gca,'XTickLabel',groupNames);		
	title(['slopes, ' dims{dim} ' dim']);
end
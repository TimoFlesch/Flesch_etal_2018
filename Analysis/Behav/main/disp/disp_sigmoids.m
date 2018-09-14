function disp_sigmoids(choiceprobs)
	%% DISP_SIGMOIDS(CHOICEPROBS)
	%
	% plots group level choice probabilities together with
	% best fitting sigmoidal curves (just for illustration purposes fit on group level)
	%
	% Timo Flesch, 2018
	figure();set(gcf,'Color','w');
	rewVals = -2:1:2;
	dimNames = {'rel','irrel'};
	styles   = {'-','-.'};
	groupNames = {'b200','b20','b2','int'};
	colvals = linspace(0.2,.8,length(groupNames));
	for dd = 1:length(dimNames)
		for gg = 1:length(groupNames)
			% plot errorbars of choice probas
			y = squeeze(mean(choiceprobs.test.(dimNames{dd}).(groupNames{gg}),1));
			eb(gg) = errorbar(rewVals,y,squeeze(std(choiceprobs.test.(dimNames{dd}).(groupNames{gg}),0,1))./sqrt(size(choiceprobs.test.(dimNames{dd}).(groupNames{gg}),1)),'o','MarkerSize',3,'MarkerEdgeColor',[1,1,1].*colvals(gg),'MarkerFaceColor',[1,1,1].*colvals(gg),'Color',[1,1,1].*colvals(gg));
			hold on;
			% plot group level sigmoidal fits
			warning off;
			sigmas = fitSigmoid([rewVals',y']);
			x = -2:0.1:2;
			y = mysigmoid([sigmas],x);
			plot(x,y,'Color',[1,1,1].*colvals(gg),'LineWidth',1,'LineStyle',styles{dd});

		end
	end
	legend(eb,groupNames,'Box','off','Location','NorthEastOutside');
xlabel('Reward');
ylabel('P(Plant)');
set(gca,'XTick',-2:1:2);
set(gca,'XTickLabel',-50:25:50);
ylim([0,1]);
set(gca,'YTick',0:0.25:1);  
set(gca,'TickDir','out');
box off;
% set(gcf,'Position',[ 680   751   346   227]);
set(gca,'LineWidth',1);



end
function betas = fitSigmoid(data)

betas = nlinfit(data(:,1),data(:,2),@mysigmoid,[1,1,1]);

end

function fun = mysigmoid(b,x)

fun = b(3) + (1-b(3)*2)./(1+exp(-b(1)*(x-b(2))));

end

%% EXPERIMENT 4b ---------------------------------------------------------------

% 1. Accuracy
disp(' ACCURACY -------------------------------------------------------------');
disp('accuracy on first task, second session - cardinal - vanillaCNN vs priorCNN')
load('accuracy_exp3a.mat');
vanCNN = results.accuracies.all.test.first.blocked(2,:);
load('accuracy_exp4b_cardinal.mat');
priorCNN = results.accuracies.all.test.first.blocked(2,:);
disp(['vanCNN; n: ' num2str(length(vanCNN))  ', mean: '  num2str(round(mean(vanCNN)*1000)/1000)  ', median: '  num2str(round(median(vanCNN)*1000)/1000) ', stdev: '	num2str(round(std(vanCNN,0,2)*1000)/1000) ', sem: ' num2str(round(std(vanCNN,0,2)./sqrt(length(vanCNN))*1000)/1000)])
disp(['priorCNN; n: ' num2str(length(priorCNN))  ', mean: '  num2str(round(mean(priorCNN)*1000)/1000)  ', median: '  num2str(round(median(priorCNN)*1000)/1000) ', stdev: '	num2str(round(std(priorCNN,0,2)*1000)/1000) ', sem: ' num2str(round(std(priorCNN,0,2)./sqrt(length(priorCNN))*1000)/1000)])
[p,~,stats] = ranksum(vanCNN,priorCNN);
r = compute_nonparametricEffectsize(stats.zval,length(priorCNN)+length(vanCNN));

fprintf([ 'b200 > int :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

disp('accuracy on first task, second session - diagonal - vanillaCNN vs priorCNN')
load('accuracy_exp3b.mat');
vanCNN = results.accuracies.all.test.first.blocked(2,:);
load('accuracy_exp4b_diagonal.mat');
priorCNN = results.accuracies.all.test.first.blocked(2,:);
disp(['vanCNN; n: ' num2str(length(vanCNN))  ', mean: '  num2str(round(mean(vanCNN)*1000)/1000)  ', median: '  num2str(round(median(vanCNN)*1000)/1000) ', stdev: '	num2str(round(std(vanCNN,0,2)*1000)/1000) ', sem: ' num2str(round(std(vanCNN,0,2)./sqrt(length(vanCNN))*1000)/1000)])
disp(['priorCNN; n: ' num2str(length(priorCNN))  ', mean: '  num2str(round(mean(priorCNN)*1000)/1000)  ', median: '  num2str(round(median(priorCNN)*1000)/1000) ', stdev: '	num2str(round(std(priorCNN,0,2)*1000)/1000) ', sem: ' num2str(round(std(priorCNN,0,2)./sqrt(length(priorCNN))*1000)/1000)])
[p,~,stats] = ranksum(vanCNN,priorCNN);
r = compute_nonparametricEffectsize(stats.zval,length(priorCNN)+length(vanCNN));
fprintf([ 'b200 > int :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval)  '\t r=' num2str(r) '\n']);


disp('RSA RESULTS -----------------------------------------------------------');
disp('rdm correlation - factorised - cardinal - vanillaCNN vs priorCNN');
load('taus_rsa_exp3ab.mat')
taus_vanCNN = [squeeze(taus.exp3a.blocked.ns.both(:,2,3:5,2));squeeze(taus.exp3a.blocked.sn.both(:,2,3:5,2))];
load('taus_rsa_exp4b.mat')
taus_priorCNN = [squeeze(taus.cardinal.blocked.ns.both(:,2,:,2));squeeze(taus.cardinal.blocked.sn.both(:,2,:,2))];
for layerID = 1:3
    disp(['vanCNN; n: ' num2str(length(taus_vanCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_vanCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_vanCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_vanCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_vanCNN(:,layerID),0,1)./sqrt(length(taus_vanCNN(:,layerID)))*1000)/1000)])
    disp(['priorCNN; n: ' num2str(length(taus_priorCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_priorCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_priorCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_priorCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_priorCNN(:,layerID),0,1)./sqrt(length(taus_priorCNN(:,layerID)))*1000)/1000)])
		[p,~,stats] = ranksum(taus_vanCNN(:,layerID),taus_priorCNN(:,layerID));
		r = compute_nonparametricEffectsize(stats.zval,length(taus_priorCNN(:,layerID))+length(taus_vanCNN(:,layerID)));
		fprintf([ 'priorCNN > vanCNN :\t layer=' num2str(layerID) ',\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval)  '\t r=' num2str(r)  '\n']);
end

disp('------------------------------------------------------------------');
disp('rdm correlation - interference - cardinal - vanillaCNN vs priorCNN');
load('taus_rsa_exp3ab.mat')
taus_vanCNN = [squeeze(taus.exp3a.blocked.ns.both(:,2,3:5,3));squeeze(taus.exp3a.blocked.sn.both(:,2,3:5,3))];
load('taus_rsa_exp4b.mat')
taus_priorCNN = [squeeze(taus.cardinal.blocked.ns.both(:,2,:,3));squeeze(taus.cardinal.blocked.sn.both(:,2,:,3))];
for layerID = 1:3
    disp(['vanCNN; n: ' num2str(length(taus_vanCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_vanCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_vanCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_vanCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_vanCNN(:,layerID),0,1)./sqrt(length(taus_vanCNN(:,layerID)))*1000)/1000)])
    disp(['priorCNN; n: ' num2str(length(taus_priorCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_priorCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_priorCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_priorCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_priorCNN(:,layerID),0,1)./sqrt(length(taus_priorCNN(:,layerID)))*1000)/1000)])
		[p,~,stats] = ranksum(taus_vanCNN(:,layerID),taus_priorCNN(:,layerID));
		r = compute_nonparametricEffectsize(stats.zval,length(taus_priorCNN(:,layerID))+length(taus_vanCNN(:,layerID)));
		fprintf([ 'priorCNN < vanCNN :\t layer=' num2str(layerID) ',\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval)  '\t r=' num2str(r)  '\n']);
end

disp('------------------------------------------------------------------');
disp('rdm correlation - factorised - diagonal - vanillaCNN vs priorCNN');
load('taus_rsa_exp3ab.mat')
taus_vanCNN = [squeeze(taus.exp3b.blocked.ns.both(:,2,3:5,2));squeeze(taus.exp3b.blocked.sn.both(:,2,3:5,2))];
load('taus_rsa_exp4b.mat')
taus_priorCNN = [squeeze(taus.diagonal.blocked.ns.both(:,2,:,2));squeeze(taus.diagonal.blocked.sn.both(:,2,:,2))];
for layerID = 1:3
    disp(['vanCNN; n: ' num2str(length(taus_vanCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_vanCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_vanCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_vanCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_vanCNN(:,layerID),0,1)./sqrt(length(taus_vanCNN(:,layerID)))*1000)/1000)])
    disp(['priorCNN; n: ' num2str(length(taus_priorCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_priorCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_priorCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_priorCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_priorCNN(:,layerID),0,1)./sqrt(length(taus_priorCNN(:,layerID)))*1000)/1000)])
		[p,~,stats] = ranksum(taus_vanCNN(:,layerID),taus_priorCNN(:,layerID));
		r = compute_nonparametricEffectsize(stats.zval,length(taus_priorCNN(:,layerID))+length(taus_vanCNN(:,layerID)));
		fprintf([ 'priorCNN > vanCNN :\t layer=' num2str(layerID) ',\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval)  '\t r=' num2str(r)  '\n']);
end

disp('------------------------------------------------------------------');
disp('rdm correlation - interference - diagonal - vanillaCNN vs priorCNN');
load('taus_rsa_exp3ab.mat')
taus_vanCNN = [squeeze(taus.exp3b.blocked.ns.both(:,2,3:5,3));squeeze(taus.exp3b.blocked.sn.both(:,2,3:5,3))];
load('taus_rsa_exp4b.mat')
taus_priorCNN = [squeeze(taus.diagonal.blocked.ns.both(:,2,:,3));squeeze(taus.diagonal.blocked.sn.both(:,2,:,3))];
for layerID = 1:3
    disp(['vanCNN; n: ' num2str(length(taus_vanCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_vanCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_vanCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_vanCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_vanCNN(:,layerID),0,1)./sqrt(length(taus_vanCNN(:,layerID)))*1000)/1000)])
    disp(['priorCNN; n: ' num2str(length(taus_priorCNN(:,layerID)))  ', mean: '  num2str(round(mean(taus_priorCNN(:,layerID))*1000)/1000)  ', median: '  num2str(round(median(taus_priorCNN(:,layerID))*1000)/1000) ', stdev: '	num2str(round(std(taus_priorCNN(:,layerID),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus_priorCNN(:,layerID),0,1)./sqrt(length(taus_priorCNN(:,layerID)))*1000)/1000)])
		[p,~,stats] = ranksum(taus_vanCNN(:,layerID),taus_priorCNN(:,layerID));
		r = compute_nonparametricEffectsize(stats.zval,length(taus_priorCNN(:,layerID))+length(taus_vanCNN(:,layerID)));
		fprintf([ 'priorCNN > vanCNN :\t layer=' num2str(layerID) ',\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval)  '\t r=' num2str(r)  '\n']);
end

%% EXPERIMENT 1a ---------------------------------------------------------------

% 1. Accuracy
disp('ACCURACY - ALL TRIALS -------------------------------------------------');
% ANOVA
load('accuracies_exp1a.mat')
fn = fieldnames(acc_all.test);
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(acc_all.test.(fn{ii})))  ', mean: '  num2str(round(mean(acc_all.test.(fn{ii}))*1000)/1000)  ', median: '  num2str(round(median(acc_all.test.(fn{ii}))*1000)/1000) ', stdev: '	num2str(round(std(acc_all.test.(fn{ii}),0,2)*1000)/1000) ', sem: ' num2str(round(std(acc_all.test.(fn{ii}),0,2)./sqrt(length(acc_all.test.(fn{ii})))*1000)/1000)])
end

data = [];
idces = [];
for ii = 1:numel(fn)
	data = [data, acc_all.test.(fn{ii})];
	idces = [idces, ones(1,length(acc_all.test.(fn{ii}))).*ii];
end

[~,atb,stats] = anova1(data,idces,'off')

% TTEST2
for ii = 1:numel(fn)
	for jj = ii+1:numel(fn)
		[~,a,b,c] = ttest2(acc_all.test.(fn{ii}),acc_all.test.(fn{jj}));
		d = compute_cohensD('t2',mean(acc_all.test.(fn{ii})),std(acc_all.test.(fn{ii}),0,2),mean(acc_all.test.(fn{jj})),std(acc_all.test.(fn{jj}),0,2));
		fprintf([ fn{ii} '!=' fn{jj} ':\t p= ' num2str(round(a*1000)/1000) ',\t tstat ' num2str(c.tstat) ', df: ' num2str(c.df) '\t d=' num2str(d) '\n']);
	end
	fprintf('\n');
end

% 2. Accuracy - Switch only
disp('ACCURACY - SWITCH ONLY ------------------------------------------------');
fn = fieldnames(acc_all.test_taskSwitchVsStay);
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2))) ', mean: '  num2str(round(mean(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2))*1000)/1000)  ', median: '  num2str(round(median(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2))*1000)/1000) ', stdev: '  num2str(round(std(squeeze(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2)),0,1)*1000)/1000) ', sem: ' num2str(round(std(squeeze(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2)),0,1)./sqrt(length(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2)))*1000)/1000)])
end

data = [];
idces = [];
for ii = 1:numel(fn)
	data = [data; squeeze(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2))];
	idces = [idces; ones(1,length(squeeze(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2))))'.*ii];
end
[~,atb,stats] = anova1(data,idces,'off')

% TTEST2
for ii = 1:numel(fn)
	for jj = ii+1:numel(fn)
		[~,a,b,c] = ttest2(squeeze(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2)),squeeze(acc_all.test_taskSwitchVsStay.(fn{jj})(:,:,2)));
		d = compute_cohensD('t2',mean(squeeze(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2))),std(squeeze(acc_all.test_taskSwitchVsStay.(fn{ii})(:,:,2)),0,1),mean(squeeze(acc_all.test_taskSwitchVsStay.(fn{jj})(:,:,2))),std(squeeze(acc_all.test_taskSwitchVsStay.(fn{jj})(:,:,2)),0,1));
		fprintf([ fn{ii} '!=' fn{jj} ':\t p= ' num2str(round(a*1000)/1000) ',\t tstat ' num2str(c.tstat) ', df: ' num2str(c.df) '\t d=' num2str(d) '\n']);
	end
	fprintf('\n');
end


% 3. Accuracy - B2 worst (one-sided)
disp('ACCURACY - B2 WORST ---------------------------------------------------');
[~,a,b,c] = ttest2(acc_all.test.int,acc_all.test.b2,'Tail','right');
d= compute_cohensD('t2',mean(acc_all.test.b2),std(acc_all.test.b2,0,2),mean(acc_all.test.int),std(acc_all.test.int,0,2));
fprintf([  'b2 != int :\t p= ' num2str(round(a*1000)/1000) ',\t tstat ' num2str(c.tstat) ', df: ' num2str(c.df) '\t d=' num2str(d) '\n']);


% 4. Intrusions
disp('IRREL SLOPES ----------------------------------------------------------');
load('slopes_exp1a.mat');
fn = fieldnames(slopes_all);
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(slopes_all.(fn{ii}).irrel.sigma))  ', mean: '  num2str(round(mean(slopes_all.(fn{ii}).irrel.sigma)*1000)/1000)  ', median: '  num2str(round(median(slopes_all.(fn{ii}).irrel.sigma)*1000)/1000) ', stdev: '	num2str(round(std(slopes_all.(fn{ii}).irrel.sigma,0,1)*1000)/1000) ', sem: ' num2str(round(std(slopes_all.(fn{ii}).irrel.sigma,0,1)./sqrt(length(slopes_all.(fn{ii}).irrel.sigma))*1000)/1000)])
end
[p,~,stats] = ranksum(slopes_all.int.irrel.sigma,slopes_all.b200.irrel.sigma);
r = compute_nonparametricEffectsize(stats.zval,length(slopes_all.int.irrel.sigma)+length(slopes_all.b200.irrel.sigma));
fprintf([ 'b200 < int :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

% 5. RSA
disp('RSA RESULTS -----------------------------------------------------------');
load('taus_rsa_exp1a.mat');

fn = fieldnames(taus.test);
disp('factorised model:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(taus.test.(fn{ii}).both(:,1)))  ', mean: '  num2str(round(mean(taus.test.(fn{ii}).both(:,1))*1000)/1000)  ', median: '  num2str(round(median(taus.test.(fn{ii}).both(:,1))*1000)/1000) ', stdev: '	num2str(round(std(taus.test.(fn{ii}).both(:,1),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus.test.(fn{ii}).both(:,1),0,1)./sqrt(length(taus.test.(fn{ii}).both(:,1)))*1000)/1000)])
end

disp('linear model:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(taus.test.(fn{ii}).both(:,2)))  ', mean: '  num2str(round(mean(taus.test.(fn{ii}).both(:,2))*1000)/1000)  ', median: '  num2str(round(median(taus.test.(fn{ii}).both(:,2))*1000)/1000) ', stdev: '	num2str(round(std(taus.test.(fn{ii}).both(:,2),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus.test.(fn{ii}).both(:,2),0,1)./sqrt(length(taus.test.(fn{ii}).both(:,2)))*1000)/1000)])
end

disp('tau diff: ');
% tau diff: b200 vs int, b200 vs b2
b200_diff = taus.test.b200.both(:,1)-taus.test.b200.both(:,2);
b2_diff   =     taus.test.b2.both(:,1)-taus.test.b2.both(:,2);
int_diff  =   taus.test.int.both(:,1)-taus.test.int.both(:,2);


disp(['b200_diff; n: ' num2str(length(b200_diff))  ', mean: '  num2str(round(mean(b200_diff)*1000)/1000)  ', median: '  num2str(round(median(b200_diff)*1000)/1000) ', stdev: '	num2str(round(std(b200_diff,0,1)*1000)/1000) ', sem: ' num2str(round(std(b200_diff,0,1)./sqrt(length(b200_diff))*1000)/1000)])
disp(['int_diff; n: ' num2str(length(int_diff))  ', mean: '  num2str(round(mean(int_diff)*1000)/1000)  ', median: '  num2str(round(median(int_diff)*1000)/1000) ', stdev: '	num2str(round(std(int_diff,0,1)*1000)/1000) ', sem: ' num2str(round(std(int_diff,0,1)./sqrt(length(int_diff))*1000)/1000)])
disp(['b2_diff; n: ' num2str(length(b2_diff))  ', mean: '  num2str(round(mean(b2_diff)*1000)/1000)  ', median: '  num2str(round(median(b2_diff)*1000)/1000) ', stdev: '	num2str(round(std(b2_diff,0,1)*1000)/1000) ', sem: ' num2str(round(std(b2_diff,0,1)./sqrt(length(b2_diff))*1000)/1000)])

[p,~,stats] = ranksum(int_diff,b200_diff);
r = compute_nonparametricEffectsize(stats.zval,length(b200_diff)+length(int_diff));
fprintf([ 'b200_diff > int_diff :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

[p,~,stats] = ranksum(b2_diff,b200_diff);
r = compute_nonparametricEffectsize(stats.zval,length(b200_diff)+length(b2_diff));
fprintf([ 'b200_diff > b2_diff :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);


% 6. Model
disp('MODEL -----------------------------------------------------------------');
load('modelfits_exp1a.mat');

% protected exceedance probabilities
fn = fieldnames(results.modelcomps.groups);
disp('protected exceedance probabilities: ');
for ii = 1:numel(fn)
	pep = compute_PEP(results.modelcomps.groups.(fn{ii}).out);
	disp([fn{ii} ': ' num2str(round(pep,3))])
end

% group x model estimated frequencies
b200_diff = results.modelcomps.groups.b200.posterior.r(1,:)-results.modelcomps.groups.b200.posterior.r(2,:);
int_diff = results.modelcomps.groups.int.posterior.r(1,:)-results.modelcomps.groups.int.posterior.r(2,:);

b2_diff = results.modelcomps.groups.b2.posterior.r(1,:)-results.modelcomps.groups.b2.posterior.r(2,:);
disp(['b200_diff; n: ' num2str(length(b200_diff))  ', mean: '  num2str(round(mean(b200_diff)*1000)/1000)  ', median: '  num2str(round(median(b200_diff)*1000)/1000) ', stdev: '	num2str(round(std(b200_diff,0,2)*1000)/1000) ', sem: ' num2str(round(std(b200_diff,0,2)./sqrt(length(b200_diff))*1000)/1000)])
disp(['int_diff; n: ' num2str(length(int_diff))  ', mean: '  num2str(round(mean(int_diff)*1000)/1000)  ', median: '  num2str(round(median(int_diff)*1000)/1000) ', stdev: '	num2str(round(std(int_diff,0,2)*1000)/1000) ', sem: ' num2str(round(std(int_diff,0,2)./sqrt(length(int_diff))*1000)/1000)])
disp(['b2_diff; n: ' num2str(length(b2_diff))  ', mean: '  num2str(round(mean(b2_diff)*1000)/1000)  ', median: '  num2str(round(median(b2_diff)*1000)/1000) ', stdev: '	num2str(round(std(b2_diff,0,2)*1000)/1000) ', sem: ' num2str(round(std(b2_diff,0,2)./sqrt(length(b2_diff))*1000)/1000)])

[p,~,stats] = ranksum(b200_diff,int_diff);
r = compute_nonparametricEffectsize(stats.zval,length(b200_diff)+length(int_diff));
fprintf([ 'b200_diff > int_diff :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

[p,~,stats] = ranksum(b200_diff,b2_diff);
r = compute_nonparametricEffectsize(stats.zval,length(b200_diff)+length(b2_diff));
fprintf([ 'b200_diff > b2_diff :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

% boundary deviance
% - overview
disp('bias')
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias))  ', mean: '  num2str(round(mean(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias)*1000)/1000)  ', median: '  num2str(round(median(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias)*1000)/1000) ', stdev: '	num2str(round(std(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias,0,1)*1000)/1000) ', sem: ' num2str(round(std(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias,0,1)./sqrt(length(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias))*1000)/1000)]);
end

% - ranksums
disp('bias')
bias_b200 = results.modelfits.free_twoBoundsAndSigmoids.test.b200.bias;
bias_int = results.modelfits.free_twoBoundsAndSigmoids.test.int.bias;
[p,~,stats] = ranksum(bias_int,bias_b200);
r = compute_nonparametricEffectsize(stats.zval,length(bias_b200)+length(bias_int));
fprintf([ 'b200 < int :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

disp('slope')

for ii = 1:numel(fn)
	disp(['n: ' num2str(length(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).slope))  ', mean: '  num2str(round(mean(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).slope)*1000)/1000)  ', median: '  num2str(round(median(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).slope)*1000)/1000) ', stdev: '	num2str(round(std(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).slope,0,1)*1000)/1000) ', sem: ' num2str(round(std(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).slope,0,1)./sqrt(length(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).slope))*1000)/1000)]);
end
slope_b200 = results.modelfits.free_twoBoundsAndSigmoids.test.b200.slope;
slope_int = results.modelfits.free_twoBoundsAndSigmoids.test.int.slope;
[p,~,stats] = ranksum(slope_int,slope_b200);
r = compute_nonparametricEffectsize(stats.zval,length(slope_b200)+length(slope_int));
fprintf([ 'b200 > int :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

slope_b200 = results.modelfits.free_twoBoundsAndSigmoids.test.b200.slope;
slope_b2 = results.modelfits.free_twoBoundsAndSigmoids.test.b2.slope;
[p,~,stats] = ranksum(slope_b2,slope_b200);
r = compute_nonparametricEffectsize(stats.zval,length(slope_b200)+length(slope_b2));
fprintf([ 'b200 > b2 :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

% lapse rate
% - kruskal wallis
disp('lapse')
data = [];
idces = [];
for ii = 1:numel(fn)
	data = [data, results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).lapse'];
	idces = [idces, ones(1,length(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).lapse)).*ii];
end

[p,atb,stats] = kruskalwallis(data,idces,'off')

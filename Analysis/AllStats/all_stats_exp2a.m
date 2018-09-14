%% EXPERIMENT 2a ---------------------------------------------------------------

% 1. RSA
disp('RSA RESULTS -----------------------------------------------------------');
load('taus_rsa_exp2a.mat');

fn = fieldnames(taus.test);
disp('factorised model:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(taus.test.(fn{ii}).both(:,1)))  ', mean: '  num2str(round(mean(taus.test.(fn{ii}).both(:,1))*1000)/1000)  ', median: '  num2str(round(median(taus.test.(fn{ii}).both(:,1))*1000)/1000) ', stdev: '	num2str(round(std(taus.test.(fn{ii}).both(:,1),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus.test.(fn{ii}).both(:,1),0,1)./sqrt(length(taus.test.(fn{ii}).both(:,1)))*1000)/1000)])
end

disp('linear model:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(taus.test.(fn{ii}).both(:,2)))  ', mean: '  num2str(round(mean(taus.test.(fn{ii}).both(:,2))*1000)/1000)  ', median: '  num2str(round(median(taus.test.(fn{ii}).both(:,2))*1000)/1000) ', stdev: '	num2str(round(std(taus.test.(fn{ii}).both(:,2),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus.test.(fn{ii}).both(:,2),0,1)./sqrt(length(taus.test.(fn{ii}).both(:,2)))*1000)/1000)])
end

disp('tau factorised model: ');
[p,~,stats] = ranksum(taus.test.int.both(:,1),taus.test.b200.both(:,1));
r = compute_nonparametricEffectsize(stats.zval,length(taus.test.b200.both(:,1))+length(taus.test.int.both(:,1)));
fprintf([ 'b200 > int :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval)  '\t r=' num2str(r)  '\n']);



% 2. Model
disp('MODEL -----------------------------------------------------------------');
load('modelfits_exp2a.mat');

% group x model estimated frequencies
b200_diff = results.modelcomps.groups.b200.posterior.r(1,:)-results.modelcomps.groups.b200.posterior.r(2,:);
int_diff = results.modelcomps.groups.int.posterior.r(1,:)-results.modelcomps.groups.int.posterior.r(2,:);

disp(['b200_diff; n: ' num2str(length(b200_diff))  ', mean: '  num2str(round(mean(b200_diff)*1000)/1000)  ', median: '  num2str(round(median(b200_diff)*1000)/1000) ', stdev: '	num2str(round(std(b200_diff,0,2)*1000)/1000) ', sem: ' num2str(round(std(b200_diff,0,2)./sqrt(length(b200_diff))*1000)/1000)])
disp(['int_diff; n: ' num2str(length(int_diff))  ', mean: '  num2str(round(mean(int_diff)*1000)/1000)  ', median: '  num2str(round(median(int_diff)*1000)/1000) ', stdev: '	num2str(round(std(int_diff,0,2)*1000)/1000) ', sem: ' num2str(round(std(int_diff,0,2)./sqrt(length(int_diff))*1000)/1000)])

[p,~,stats] = ranksum(b200_diff,int_diff);
r = compute_nonparametricEffectsize(stats.zval,length(b200_diff)+length(int_diff));
fprintf([ 'b200_diff > int_diff :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

% boundary deviance
% - overview
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias))  ', mean: '  num2str(round(mean(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias)*1000)/1000)  ', median: '  num2str(round(median(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias)*1000)/1000) ', stdev: '	num2str(round(std(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias,0,1)*1000)/1000) ', sem: ' num2str(round(std(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias,0,1)./sqrt(length(results.modelfits.free_twoBoundsAndSigmoids.test.(fn{ii}).bias))*1000)/1000)]);
end

% - ranksums
bias_b200 = results.modelfits.free_twoBoundsAndSigmoids.test.b200.bias;
bias_int = results.modelfits.free_twoBoundsAndSigmoids.test.int.bias;
[p,~,stats] = ranksum(bias_int,bias_b200);
r = compute_nonparametricEffectsize(stats.zval,length(bias_b200)+length(bias_int));
fprintf([ 'b200 > int :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

% 3. GRID PRIOR
disp('GRID PRIOR -------------------------------------------------------------');

% accuracy median split
disp('Accuracy - Median Split')
load('accuracy_highVSlowGridiness_exp2a.mat')
fn = fieldnames(acc_all.accuracy_low.test);
disp('summary stats, low prior:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(acc_all.accuracy_low.test.(fn{ii})))  ', mean: '  num2str(round(mean(acc_all.accuracy_low.test.(fn{ii}))*1000)/1000)  ', median: '  num2str(round(median(acc_all.accuracy_low.test.(fn{ii}))*1000)/1000) ', stdev: '	num2str(round(std(acc_all.accuracy_low.test.(fn{ii}),0,2)*1000)/1000) ', sem: ' num2str(round(std(acc_all.accuracy_low.test.(fn{ii}),0,2)./sqrt(length(acc_all.accuracy_low.test.(fn{ii})))*1000)/1000)])
end
fn = fieldnames(acc_all.accuracy_high.test);
disp('summary stats, high prior:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(acc_all.accuracy_high.test.(fn{ii})))  ', mean: '  num2str(round(mean(acc_all.accuracy_high.test.(fn{ii}))*1000)/1000)  ', median: '  num2str(round(median(acc_all.accuracy_high.test.(fn{ii}))*1000)/1000) ', stdev: '	num2str(round(std(acc_all.accuracy_high.test.(fn{ii}),0,2)*1000)/1000) ', sem: ' num2str(round(std(acc_all.accuracy_high.test.(fn{ii}),0,2)./sqrt(length(acc_all.accuracy_high.test.(fn{ii})))*1000)/1000)])
end
disp('interaction with group:')
b200_diff = acc_all.accuracy_high.test.b200 - acc_all.accuracy_low.test.b200;
int_diff = acc_all.accuracy_high.test.int - acc_all.accuracy_low.test.int;
[p,~,stats] = ranksum(int_diff,b200_diff);
r = compute_nonparametricEffectsize(stats.zval,length(b200_diff)+length(int_diff));
fprintf([ 'b200_diff > int_diff :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);
disp('b200 hi vs lo:')
b200_high = acc_all.accuracy_high.test.b200;
b200_low  =  acc_all.accuracy_low.test.b200;
disp(['b200_high; n: ' num2str(length(b200_high))  ', mean: '  num2str(round(mean(b200_high)*1000)/1000)  ', median: '  num2str(round(median(b200_high)*1000)/1000) ', stdev: '	num2str(round(std(b200_high,0,2)*1000)/1000) ', sem: ' num2str(round(std(b200_high,0,2)./sqrt(length(b200_high))*1000)/1000)])
disp(['b200_low; n: ' num2str(length(b200_low))  ', mean: '  num2str(round(mean(b200_low)*1000)/1000)  ', median: '  num2str(round(median(b200_low)*1000)/1000) ', stdev: '	num2str(round(std(b200_low,0,2)*1000)/1000) ', sem: ' num2str(round(std(b200_low,0,2)./sqrt(length(b200_low))*1000)/1000)])

[p,~,stats] = ranksum(b200_high,b200_low);
r = compute_nonparametricEffectsize(stats.zval,length(b200_high)+length(b200_low));
fprintf([ 'b200_high > b200_low :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

disp('int hi vs lo:')
int_high  = acc_all.accuracy_high.test.int;
int_low   =  acc_all.accuracy_low.test.int;
disp(['int_high; n: ' num2str(length(int_high))  ', mean: '  num2str(round(mean(int_high)*1000)/1000)  ', median: '  num2str(round(median(int_high)*1000)/1000) ', stdev: '	num2str(round(std(int_high,0,2)*1000)/1000) ', sem: ' num2str(round(std(int_high,0,2)./sqrt(length(int_high))*1000)/1000)])
disp(['int_low; n: ' num2str(length(int_low))  ', mean: '  num2str(round(mean(int_low)*1000)/1000)  ', median: '  num2str(round(median(int_low)*1000)/1000) ', stdev: '	num2str(round(std(int_low,0,2)*1000)/1000) ', sem: ' num2str(round(std(int_low,0,2)./sqrt(length(int_low))*1000)/1000)])

[p,~,stats] = ranksum(int_high,int_low);
r = compute_nonparametricEffectsize(stats.zval,length(int_high)+length(int_low));
fprintf([ 'int_high > int_low :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

% accuracy - ANCOVA
disp('Accuracy - ANCOVA')
[~,atab,ctab,stats]= gridprior_ancova('acc',{'exp2a'});

% RSA median split
disp('RSA - Median Split')
load('corrs_rdms_highVSlowGridiness_exp2a.mat')
fn = fieldnames(taus.modelcorrs_low.test);
disp('summary stats, low prior:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(taus.modelcorrs_low.test.(fn{ii})(:,1)))  ', mean: '  num2str(round(mean(taus.modelcorrs_low.test.(fn{ii})(:,1))*1000)/1000)  ', median: '  num2str(round(median(taus.modelcorrs_low.test.(fn{ii})(:,1))*1000)/1000) ', stdev: '	num2str(round(std(taus.modelcorrs_low.test.(fn{ii})(:,1),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus.modelcorrs_low.test.(fn{ii})(:,1),0,1)./sqrt(length(taus.modelcorrs_low.test.(fn{ii})(:,1)))*1000)/1000)])
end
fn = fieldnames(taus.modelcorrs_high.test);
disp('summary stats, high prior:');
for ii = 1:numel(fn)
	disp(['n: ' num2str(length(taus.modelcorrs_high.test.(fn{ii})(:,1)))  ', mean: '  num2str(round(mean(taus.modelcorrs_high.test.(fn{ii})(:,1))*1000)/1000)  ', median: '  num2str(round(median(taus.modelcorrs_high.test.(fn{ii})(:,1))*1000)/1000) ', stdev: '	num2str(round(std(taus.modelcorrs_high.test.(fn{ii})(:,1),0,1)*1000)/1000) ', sem: ' num2str(round(std(taus.modelcorrs_high.test.(fn{ii})(:,1),0,1)./sqrt(length(taus.modelcorrs_high.test.(fn{ii})(:,1)))*1000)/1000)])
end
disp('interaction with group:')
b200_diff = taus.modelcorrs_high.test.b200(:,1) - taus.modelcorrs_low.test.b200(:,1);
int_diff = taus.modelcorrs_high.test.int(:,1) - taus.modelcorrs_low.test.int(:,1);
[p,~,stats] = ranksum(int_diff,b200_diff);
r = compute_nonparametricEffectsize(stats.zval,length(b200_diff)+length(int_diff));
fprintf([ 'b200_diff > int_diff :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);
disp('b200 hi vs lo:')
b200_high = taus.modelcorrs_high.test.b200(:,1);
b200_low  =  taus.modelcorrs_low.test.b200(:,1);
disp(['b200_high; n: ' num2str(length(b200_high))  ', mean: '  num2str(round(mean(b200_high)*1000)/1000)  ', median: '  num2str(round(median(b200_high)*1000)/1000) ', stdev: '	num2str(round(std(b200_high,0,1)*1000)/1000) ', sem: ' num2str(round(std(b200_high,0,1)./sqrt(length(b200_high))*1000)/1000)])
disp(['b200_low; n: ' num2str(length(b200_low))  ', mean: '  num2str(round(mean(b200_low)*1000)/1000)  ', median: '  num2str(round(median(b200_low)*1000)/1000) ', stdev: '	num2str(round(std(b200_low,0,1)*1000)/1000) ', sem: ' num2str(round(std(b200_low,0,1)./sqrt(length(b200_low))*1000)/1000)])

[p,~,stats] = ranksum(b200_high,b200_low);
r = compute_nonparametricEffectsize(stats.zval,length(b200_high)+length(b200_low));
fprintf([ 'b200_high > b200_low :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

disp('int hi vs lo:')
int_high  = taus.modelcorrs_high.test.int(:,1);
int_low   =  taus.modelcorrs_low.test.int(:,1);
disp(['int_high; n: ' num2str(length(int_high))  ', mean: '  num2str(round(mean(int_high)*1000)/1000)  ', median: '  num2str(round(median(int_high)*1000)/1000) ', stdev: '	num2str(round(std(int_high,0,1)*1000)/1000) ', sem: ' num2str(round(std(int_high,0,1)./sqrt(length(int_high))*1000)/1000)])
disp(['int_low; n: ' num2str(length(int_low))  ', mean: '  num2str(round(mean(int_low)*1000)/1000)  ', median: '  num2str(round(median(int_low)*1000)/1000) ', stdev: '	num2str(round(std(int_low,0,1)*1000)/1000) ', sem: ' num2str(round(std(int_low,0,1)./sqrt(length(int_low))*1000)/1000)])
[p,~,stats] = ranksum(int_high,int_low);
r = compute_nonparametricEffectsize(stats.zval,length(int_high)+length(int_low));
fprintf([ 'int_high > int_low :\t p= ' num2str(round(p*1000)/1000) ',\t z: ' num2str(stats.zval) '\t r=' num2str(r) '\n']);

% RSA - ANCOVA
disp('RSA - ANCOVA')
[~,atab,ctab,stats]= gridprior_ancova('acc',{'exp2a'});

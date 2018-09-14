function wrapper_compute_learningCurves(saveDat,monitorDat)
%% WRAPPER_compute_LEARNINGCURVES()
%
% wrapper which computes, saves and plots some learning curves
%
% (c) Timo Flesch, 2016
%

%% load data
load('allData_exp1a.mat')

%% 1. compute vals
acc = compute_pcorrect_learningCurves(allData,0);

%% 2. plot results - accuracy
if monitorDat
	% 1. learning curves blocked vs interleaved ALL
	graphBlocked200 = rew_plot_acc_learningCurves(acc.pMatBlock200',100,[0 0 0.8],{'\bf Learning Curves - Blocked vs Interleaved Training';'\rm Accuracy'});
	graphBlocked20 = rew_plot_acc_learningCurves(acc.pMatBlock20',100,[0 0 0.5],{'\bf Learning Curves - Blocked vs Interleaved Training';'\rm Accuracy'});
	graphBlocked2 = rew_plot_acc_learningCurves(acc.pMatBlock2',100,[0 0 0.2],{'\bf Learning Curves - Blocked vs Interleaved Training';'\rm Accuracy'});
	graphInt = rew_plot_acc_learningCurves(acc.pMatInt',100,[0 0.5 0.5],{'\bf Learning Curve - Cardinal Boundary';'\rm Accuracy'});
	legend([graphBlocked200{1},graphBlocked20{1},graphBlocked2{1},graphInt{1}],{'Blocked 200'; 'Blocked 20'; 'Blocked 2'; 'Interleaved '},'Location','East');
	% legend([graphBlocked200{1},graphInt{1}],{'Blocked 200';  'Interleaved '},'Location','East');



end

if saveDat

	lcurves = struct();
	lcurves.acc = acc;
	lcurves.rew = rew;
	save('lcurves_gooddata_reward_mturk_new.mat','lcurves')
end

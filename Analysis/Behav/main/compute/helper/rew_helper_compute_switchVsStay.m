function [rt_switchTrials,rt_stayTrials,acc_switchTrials,acc_stayTrials] = rew_helper_compute_switchVsStay(rsData,ii_test,ii_sub,rt_col,acc_col)
% splits data into switch and stay trials
% computes mean rt and accuracy for both groups
%
% (c) Timo Flesch, 2016
% Summerfield Lab, Experimental Psychology Department, University of Oxford



%% obtain sets
testData = rsData(ii_sub).data(ii_test,:);
[switchData, stayData] = rew_helper_compute_SwitchVsStay_subsets(testData);

%% for both sets:

% 1. compute mean RT
rt_switchTrials  =  squeeze(nanmean(switchData(:,rt_col),1))-0.5;
rt_stayTrials    =    squeeze(nanmean(stayData(:,rt_col),1))-0.5;
% 2. compute mean Accuracy
acc_switchTrials =  squeeze(nanmean(switchData(:,acc_col),1));
acc_stayTrials   =    squeeze(nanmean(stayData(:,acc_col),1));
end

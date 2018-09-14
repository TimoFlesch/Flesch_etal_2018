function [switchData, stayData] = rew_helper_compute_SwitchVsStay_subsets(testData)
% split test block into switch and stay trials
%
% (c) Timo Flesch, 2017

%% main
% the task indices:
taskVect = squeeze(testData(:,3));
% shift by one (n==n -> switch == stay)
shiftVect = circshift(taskVect,1,1);
%% determine set of switch and stay trials
stayData = testData(taskVect==shiftVect,:);
switchData = testData(~(taskVect==shiftVect),:);
% discard first entry
stayData(1,:)   = [];
switchData(1,:) = [];
end

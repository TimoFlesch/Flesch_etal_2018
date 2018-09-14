function [lcRew, lcAcc] = rew_helper_compute_lc(data,rew_col,acc_col)
	% 1-x-time
  % extracts data for learning curves / computes learning curves
  % (c) Timo Flesch, 2017

  %% main 
	lcRew = squeeze(cumsum(data(:,rew_col)));
	lcAcc =        squeeze(data(:,acc_col)) ;
end

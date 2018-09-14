function acc = rew_helper_compute_acc(data,feat_col,acc_col)
	% 1-x-feature
  % computes accuracy for five feature levels
  % (c) Timo Flesch, 2017
  
	for featureLevel = 1:5
		acc(featureLevel) = squeeze(nanmean(data(data(:,feat_col)==featureLevel,acc_col),1));
	end
end

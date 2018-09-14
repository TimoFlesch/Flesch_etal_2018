function rt = rew_helper_compute_rt(data,feat_col,rt_col)
	% 1-x-feature
  % computes rt for five feature levels
  % (c) Timo Flesch, 2017
  
	for featureLevel = 1:5
		rt(featureLevel) = squeeze(nanmean(data(data(:,feat_col)==featureLevel,rt_col),1));
	end
end

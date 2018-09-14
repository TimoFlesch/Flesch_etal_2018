function choice = rew_helper_compute_choice(data,rew_col,choice_col)
	% 1-x-rew
  % computes choice probabilities for five reward levels
  % (c) Timo Flesch, 2017

  %% main 
	choice = [];

	for rewLevel = -50:25:50
		choice = [choice, squeeze(nanmean(data(data(:,rew_col)==rewLevel,choice_col),1))];
	end
end

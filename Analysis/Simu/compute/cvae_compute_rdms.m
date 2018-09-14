function rdmSet = cvae_compute_rdms()
	%% CVAE_COMPUTE_RDMs()
	% 
	% computes rdms for layer-wise activation patterns
	% for each beta-vae that was trained
	%
	% Timo Flesch, 2017

	betas = [1,2,6,10,50,100];

	rdmSet = [];
	for b = 1:length(betas)
		% load data
		load(['log_trainingsess_mod_normalisedIMGcvae_beta_' num2str(betas(b)) '.mat']);

		% reshape data (with a kinda stupid approach)
		respMat = squeeze(mean(helper_reshape_layer(squeeze(encOut_test)),1));
		% compute rdm
		for ep= 1:21
			rdmSet(b,ep,:,:) = squareform(pdist(squeeze(respMat(ep,:,:)),'correlation'));
		end

	end
end



function respMat = helper_reshape_layer(actMat)
	%
	% reshapes layer activity mat into 
	% respmat: stimset-x-epoch-x-tree-x-activity	
	tmp2 = [];idx=1;
	for ii = 1:21
		tmp2(ii,:,:) = actMat(idx:idx+99,:);
		idx = idx+100;
	end
	respMat = [];
	idx=1;
	for jj = 1:4
		respMat(jj,:,:,:) = tmp2(:,idx:idx+24,:);idx=idx+25;
	end
end
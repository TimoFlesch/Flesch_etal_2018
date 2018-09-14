function disp_rsa_betweenModelRDMCorrelations()
%% DISP_RSA_BETWEENMODELRDMCORRELATIONS()
%
% computes and displays the correlation between
% three categorical candidate model rdms
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department
% University of Oxford

% 1. generate model rdms
m1 = genCategoricalModelRDM(1)
m2 = genCategoricalModelRDM(2)
m3 = genCategoricalModelRDM(3)
% 2. organize models in struct
rdms = struct()
rdms(1).RDM = m1.choiceRDM;
rdms(2).RDM = m2.choiceRDM;
rdms(3).RDM = m3.choiceRDM;
rdms(1).name = 'leaf'
rdms(2).name = 'branch'
rdms(3).name = 'diag'
rdms(1).color = [0 0 0];
rdms(2).color = [0 0 0];
rdms(3).color = [0 0 0];

% compute and plot between model correlations (spearman for data with tied ranks..)
RDMCorrMat(rdms,1,'Kendall');
f = figure(1);
cb = f.Children(1); % colorbar
mat = f.Children(2); % axis
ylabel(cb, {'\bf \tau_a'});
title({'\bf Between Model RDM Correlation Matrix','\rm Kendall''s \tau_a'});

end

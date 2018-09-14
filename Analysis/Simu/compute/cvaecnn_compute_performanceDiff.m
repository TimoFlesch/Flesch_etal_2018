load('allData_cnn_cvae_beta50_diagonal_ns.mat')
accNS_cvae = squeeze(allData.blocked.resp.accTest(:,:,2,1)); % runs,trial,sess2,task1
clear allData;
load('allData_cnn_cvae_beta50_diagonal_sn.mat')
accSN_cvae = squeeze(allData.blocked.resp.accTest(:,:,2,1)); % runs,trial,sess2,task1

accAll_cvae = [accNS_cvae;accSN_cvae];


load('allData_diagonal_ns.mat')
accNS_cnn = squeeze(allData.blocked.resp.accTest(:,:,2,1)); % runs,trial,sess2,task1
clear allData;
load('allData_diagonal_sn.mat')
accSN_cnn = squeeze(allData.blocked.resp.accTest(:,:,2,1)); % runs,trial,sess2,task1

accAll_cnn = [accNS_cnn;accSN_cnn];

[a,b,c] =ranksum(nanmean(accAll_cvae,2),nanmean(accAll_cnn,2))

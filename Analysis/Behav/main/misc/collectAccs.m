load('cnn_accuracy_cardinal_ns.mat')
acc1 = results.accuracies.all.test.second.blocked;
load('cnn_accuracy_cardinal_sn.mat')
acc2 = results.accuracies.all.test.second.blocked;
acc = [acc1,acc2];
load('accuracy_exp3a.mat')
results.accuracies.all.test.second.blocked = acc;
save('accuracy_exp3a.mat','results')



load('cnn_accuracy_cardinal_ns.mat')
acc1 = results.accuracies.all.test.second.interleaved;
load('cnn_accuracy_cardinal_sn.mat')
acc2 = results.accuracies.all.test.second.interleaved;
acc = [acc1,acc2];
load('accuracy_exp3a.mat')
results.accuracies.all.test.second.interleaved = acc;
save('accuracy_exp3a.mat','results')





load('cnn_accuracy_diagonal_ns.mat')
acc1 = results.accuracies.all.test.second.blocked;
load('cnn_accuracy_diagonal_sn.mat')
acc2 = results.accuracies.all.test.second.blocked;
acc = [acc1,acc2];
load('accuracy_exp3b.mat')
results.accuracies.all.test.second.blocked = acc;
save('accuracy_exp3b.mat','results')




load('cnn_accuracy_diagonal_ns.mat')
acc1 = results.accuracies.all.test.second.interleaved;
load('cnn_accuracy_diagonal_sn.mat')
acc2 = results.accuracies.all.test.second.interleaved;
acc = [acc1,acc2];
load('accuracy_exp3b.mat')
results.accuracies.all.test.second.interleaved = acc;
save('accuracy_exp3b.mat','results')



%
%
% load('results_acc_cardinal_cnn_cvae_beta50_ns.mat')
% acc1 = results.accuracies.all.test.second.blocked;
% load('results_acc_cardinal_cnn_cvae_beta50_sn.mat')
% acc2 = results.accuracies.all.test.second.blocked;
% acc = [acc1,acc2];
% load('accuracy_exp4a.mat')
% results.accuracies.all.test.second.blocked = acc;
% save('accuracy_exp4a.mat','results')
%
%
%
% load('results_acc_cardinal_cnn_cvae_beta50_ns.mat')
% acc1 = results.accuracies.all.test.second.interleaved;
% load('results_acc_cardinal_cnn_cvae_beta50_sn.mat')
% acc2 = results.accuracies.all.test.second.interleaved;
% acc = [acc1,acc2];
% load('accuracy_exp4a.mat')
% results.accuracies.all.test.second.interleaved = acc;
% save('accuracy_exp4a.mat','results')
%
%
%


load('results_acc_cardinal_cnn_cvae_beta50_ns.mat')
acc1 = results.accuracies.all.test.second.blocked;
load('results_acc_cardinal_cnn_cvae_beta50_sn.mat')
acc2 = results.accuracies.all.test.second.blocked;
acc = [acc1,acc2];
load('accuracy_exp4b_cardinal.mat')
results.accuracies.all.test.second.blocked = acc;
save('accuracy_exp4b_cardinal.mat','results')




load('results_acc_cardinal_cnn_cvae_beta50_ns.mat')
acc1 = results.accuracies.all.test.second.interleaved;
load('results_acc_cardinal_cnn_cvae_beta50_sn.mat')
acc2 = results.accuracies.all.test.second.interleaved;
acc = [acc1,acc2];
load('accuracy_exp4b_cardinal.mat')
results.accuracies.all.test.second.interleaved = acc;
save('accuracy_exp4b_cardinal.mat','results')



load('results_acc_diagonal_cnn_cvae_beta50_ns.mat')
acc1 = results.accuracies.all.test.second.blocked;
load('results_acc_diagonal_cnn_cvae_beta50_sn.mat')
acc2 = results.accuracies.all.test.second.blocked;
acc = [acc1,acc2];
load('accuracy_exp4b_diagonal.mat')
results.accuracies.all.test.second.blocked = acc;
save('accuracy_exp4b_diagonal.mat','results')



load('results_acc_diagonal_cnn_cvae_beta50_ns.mat')
acc1 = results.accuracies.all.test.second.interleaved;
load('results_acc_diagonal_cnn_cvae_beta50_sn.mat')
acc2 = results.accuracies.all.test.second.interleaved;
acc = [acc1,acc2];
load('accuracy_exp4b_diagonal.mat')
results.accuracies.all.test.second.interleaved = acc;
save('accuracy_exp4b_diagonal.mat','results')

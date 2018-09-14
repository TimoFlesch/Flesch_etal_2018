[rho,p] = partialcorr([acc_all.test.b200',abs(results.test.b200.bias), results.test.b200.lapse, results.test.b200.slope],'Type','Pearson');
disp('b200 - diagonal')
disp(' correlation coefficients')
rho = array2table(rho,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(rho)
disp('p-values')
p = array2table(p,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(p)

[rho,p] = partialcorr([acc_all.test.b20',abs(results.test.b20.bias), results.test.b20.lapse, results.test.b20.slope],'Type','Pearson');
disp('b20 - diagonal')
disp(' correlation coefficients')
rho = array2table(rho,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(rho)
disp('p-values')
p = array2table(p,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(p)

[rho,p] = partialcorr([acc_all.test.b2',abs(results.test.b2.bias), results.test.b2.lapse, results.test.b2.slope],'Type','Pearson');
disp('b2 - diagonal')
disp(' correlation coefficients')
rho = array2table(rho,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(rho)
disp('p-values')
p = array2table(p,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(p)

[rho,p] = partialcorr([acc_all.test.int',abs(results.test.int.bias), results.test.int.lapse, results.test.int.slope],'Type','Pearson');
disp('interleaved - diagonal')
disp(' correlation coefficients')
rho = array2table(rho,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(rho)
disp('p-values')
p = array2table(p,'VariableNames',{'Accuracy','AbsBias','Lapse','Slope'},'RowNames',{'Accuracy','AbsBias','Lapse','Slope'});
disp(p)
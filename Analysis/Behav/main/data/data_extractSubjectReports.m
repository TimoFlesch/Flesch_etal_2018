function data_extractSubjectReports(rsData,monitor)
%% DATA_EXTRACTSUBJECTREPORTS(RSDATA)
%
% for each subject, create a struct with
% 1. reported rule for both tasks
% 2. achieved train and test accuracies for both tasks
% 3. task IDs
% rsData: reshaped data
% monitor: write to stdout
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, University of Oxford



% loop through subjects
for ii = 1: length(rsData)

	% leaf task was always north, branch task always south
	ii_leafTaskTest    =   find(rsData(ii).data(:,1)==3 & rsData(ii).data(:,3)==1);
	ii_branchTaskTest  =   find(rsData(ii).data(:,1)==3 & rsData(ii).data(:,3)==2);
	acc_leafTaskTest   =       nanmean(squeeze(rsData(ii).data(ii_leafTaskTest,9)));
	acc_branchTaskTest =     nanmean(squeeze(rsData(ii).data(ii_branchTaskTest,9)));

	if monitor
		disp(['**subject ' num2str(ii)])
		disp(['-turker ' rsData(ii).id])
		disp(['-file ' rsData(ii).file])
		disp(['-ids ' num2str(rsData(ii).code')]);
		disp(['-test accuracy north: ' num2str(acc_leafTaskTest)])
		disp(['-report north: "' rsData(ii).repnorth '"'])
		disp(['-test accuracy south: ' num2str(acc_branchTaskTest)])
		disp(['-report south: "' rsData(ii).repsouth '"'])
		disp([' -timeouts :' num2str(length(find(rsData(ii).data(:,11) > 5)))])
		disp([' ']);
		disp([' ']);

	end
end

end

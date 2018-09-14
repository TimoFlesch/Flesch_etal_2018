function data_renameData(dataDir)
%% data_RENAMEDATA(DATADIR)
%
% load single subject 'uncelled' data and
% sorts them according to task condition
% saves each file with unique id.
%
% (c) Timo Flesch, 2016
% Summerfield Lab, Experimental Psychology Department, University of Oxford

if(~exist('dataDir'))
	disp('please set file directory!');
	return;
end


%% MAIN
alldata = struct();
subCodes = [];

% obtain filenames
subs_names   = strsplit(ls(dataDir));
subs_total   = length(subs_names)-1;
cardinalID   = 1;
diagonalID   = 1;

% load and add data
for ii = 1:subs_total
	% load
	tmp   = load([dataDir '/' subs_names{ii}]);
	names = fieldnames(tmp);
	data  = tmp.(names{1});
	% extract regime ID
	switch data.task_id{1}
		case 'interleaved'
			subCodes(1) = 3;

		case 'blocked'
			if (strcmp(data.task_id{2},'A'))
				subCodes(1) = 1;
			else
				subCodes(1) = 2;
			end
	end

	% extract flipIDs for A and B  (old data)
	%if any(strcmp('val_rewFlip',fieldnames(data.parameters)))
	%	subCodes(2) = data.parameters.val_rewFlip(1);
	%	subCodes(3) = data.parameters.val_rewFlip(2);
	%	disp('we''ve got a problem!')
	%end

	% extract flipIDs for A and B  (new 3/17)
	%if  any(strcmp('val_rewAssignment',fieldnames(data.parameters)))
		switch data.parameters.val_rewAssignment
			case 1
				subCodes(2) = 0
				subCodes(3) = 0
			case 2
				subCodes(2) = 1
				subCodes(3) = 1
			case 3
				subCodes(2) = 1
				subCodes(3) = 0
			case 4
				subCodes(2) = 0
				subCodes(3) = 1

			case 5
				subCodes(2) = 0
				subCodes(3) = 0
			case 6
				subCodes(2) = 1
				subCodes(3) = 1
			case 7
				subCodes(2) = 1
				subCodes(3) = 0
			case 8
				subCodes(2) = 0
				subCodes(3) = 1
		end
		% extract boundary code (1= diag, 0 = cardinal)
		subCodes(6) = (data.parameters.val_rewAssignment>4)
		subCodes(7) = data.parameters.val_rewAssignment;

	%else
	%	disp(['no rewass val, subj' num2str(ii)])
	%	disp(['file: ' num2str(subs_names{ii})])
	%end
	% extract key assignment
	subCodes(4) = data.parameters.keyassignment;
	% extract blockiness parameter
	if any(strcmp('blockiness',fieldnames(data.parameters)))
		subCodes(5)  = data.parameters.blockiness;
	end
	data.subID = subCodes;

	% save subject
	if subCodes(6) == 0 % if cardinal boundary dude
		save([dataDir '/../renamed/cardinal/s' num2str(cardinalID) ],'data');
		cardinalID = cardinalID+1;
	else
		save([dataDir '/../renamed/diagonal/s' num2str(diagonalID) ],'data');
		diagonalID = diagonalID+1;
	end
end

end

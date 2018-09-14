function alldata = data_getAllData(dataDir)
%% ALLDATA = DATA_GETALLDATA(DATADIR)
%
% loads single subject txt files from provided directory and
% puts them all in one matlab datastructure
%
% (c) Timo Flesch, 2016
% Summerfield Lab, Experimental Psychology Department, University of Oxford

if(~exist('dataDir'))
	disp('please set file directory!');
	return;
end


%% MAIN
alldata        =     struct();
subs_total     =            0;
subjects       = 1:subs_total;
badsubs                  = [];
badarrangement           = [];
subjects(badsubs)        = [];
subjects(badarrangement) = [];
sIDX = 1;

% load and add data
for ii = 1:length(subjects)
	subj = subjects(ii);
	% load
	tmp   = load([dataDir 's' num2str(subj)]);
	names = fieldnames(tmp);
	data  = tmp.(names{1});
	fieldNames = fieldnames(data.sdata);
	if ii==1
		% init alldata fields
		fieldNames = fieldnames(data.sdata);
		for jj = 1:length(fieldNames)
			alldata.(fieldNames{jj}) = [];
		end

		alldata.subCodes = [];
		alldata.subReports = struct();
		alldata.subTurker = {};
		alldata.subExp    = {};


	end
	if length(data.subID)<7
		disp(num2str(data.subID))
		disp(num2str(ii))
	end
	if data.subID(6) == 1 % cardinal 0, diagonal 1

		% populate matrices
		for jj = 1:length(fieldNames)
			alldata.(fieldNames{jj}) = horzcat(alldata.(fieldNames{jj}), data.sdata.(fieldNames{jj}));
		end

		alldata.subCodes = horzcat(alldata.subCodes, data.subID');
  	alldata.subReports(sIDX).north = data.rule_taskNorth;
		alldata.subReports(sIDX).south = data.rule_taskSouth;
		alldata.subTurker{sIDX} = data.edata.expt_turker;
		alldata.subExp{sIDX} = data.edata.expt_subject;
		alldata.subAge(sIDX) = helper_compute_subAge(data.edata.expt_age);
		alldata.subGender(sIDX)    = helper_compute_subGender(data.edata.expt_sex);
		alldata.subAcc(sIDX)  = helper_compute_subAccuracy(data.sdata.expt_catIDX,data.sdata.resp_correct,data.sdata.resp_reactiontime);
		sIDX = sIDX +1;

	 end
end


end

function subAge = helper_compute_subAge(ageRange)


	switch ageRange
		case '18-20'
			subAge = 19;
		case '21-30'
			subAge = 25;
		case '31-40'
			subAge = 35;
		case '41-50'
			subAge = 45;
		case '51-60'
			subAge = 55;
		case '61+'
			subAge = 65;
	end

end

function subGenderID = helper_compute_subGender(subGender)
	if strcmp(subGender,'male')
		subGenderID = 0;
	elseif strcmp(subGender,'female')
		subGenderID = 1;
	end
end

function subAcc = helper_compute_subAccuracy(subCat,subCorrect,subRT)
	catZero = find(subCat==0);
	timeOuts = find(subRT>5);
	subCorrect(timeOuts) = 0;
	subCorrect(catZero) = NaN;
	subAcc = nanmean(subCorrect(401:end));
end

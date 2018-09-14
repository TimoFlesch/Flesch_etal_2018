function allData = data_add_boundarycodes(allData)
	%% data_ADD_BOUNDARYCODES(ALLDATA)
	%
	% adds boundary codes to data files from old runs (without explicit boundary and group codes)
	% Timo Flesch, 2017

	allData.subCodes(5,:) = 200;
	allData.subCodes(6,:) =   0;

	for subID = 1:size(allData.subCodes,2)
		if (allData.subCodes(2,subID) == 0 && allData.subCodes(3,subID) ==0)
			allData.subCodes(7,subID) = 1;
		elseif (allData.subCodes(2,subID) == 1 && allData.subCodes(3,subID) ==1)
			allData.subCodes(7,subID) = 2;
		elseif (allData.subCodes(2,subID) == 1 && allData.subCodes(3,subID) ==0)
			allData.subCodes(7,subID) = 3;
		elseif (allData.subCodes(2,subID) == 0 && allData.subCodes(3,subID) ==1)
			allData.subCodes(7,subID) = 4;
		end
	end

end

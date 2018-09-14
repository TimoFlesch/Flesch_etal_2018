function results = compute_age_gender(allData)
	%% COMPUTE_AGE_GENDER(ALLDATA)
	%
	% computes mean age and counts number of male and female participants for each group
	%
	% Timo Flesch, 2017

	results = struct();
	results.age.b200.mu  = mean(allData.subAge(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==200));
	results.age.b200.std = std(allData.subAge(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==200));
	results.age.b20.mu   = mean(allData.subAge(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==20));
	results.age.b20.std  = std(allData.subAge(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==20));
	results.age.b2.mu    = mean(allData.subAge(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==2));
	results.age.b2.std   = std(allData.subAge(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==2));
	results.age.int.mu   = mean(allData.subAge(allData.subCodes(1,:)==3));
	results.age.int.std  = std(allData.subAge(allData.subCodes(1,:)==3));


	results.gender.b200.male    = sum(allData.subGender(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==200)==0);
	results.gender.b200.female  = sum(allData.subGender(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==200)==1);
	results.gender.b20.male     = sum(allData.subGender(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==20)==0);
	results.gender.b20.female   = sum(allData.subGender(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==20)==1);
	results.gender.b2.male      = sum(allData.subGender(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==2)==0);
	results.gender.b2.female    = sum(allData.subGender(allData.subCodes(1,:)~=3 & allData.subCodes(5,:)==2)==1);
	results.gender.int.male     = sum(allData.subGender(allData.subCodes(1,:)==3)==0);
	results.gender.int.female   = sum(allData.subGender(allData.subCodes(1,:)==3)==1);
end

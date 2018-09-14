function myModel = rsa_genCategoricalModelRDM(modIDX)
%% MYMODEL = RSA_GENCATEGORICALMODELRDM(modIDX)
%
% computes model rdm for branch-leaf cl experiment
% with one relevant and one irrelevant dimension
%
% INPUT:
%	- modIDX: model index (1 to 3)
%
% OUTPUT:
%	- the desired model rdm + choice mat
%
% (c) Timo Flesch, 2017
% Summerfield Lab, Experimental Psychology Department, University of Oxford
myModel = struct();

%% main
% 1. compute choice matrix:
switch modIDX
	case 1
		choiceMat = repmat([0;0;0.5;1;1],1,5); % cardinal north
	case 2
		choiceMat = repmat([0,0,0.5,1,1],5,1); % cardinal south (ortho diagonal)
	case 3
		choiceMat = tril(ones(5,5));           % diagonal north (ortho cardinal)
		choiceMat(1:length(choiceMat)+1:end) = 0.5;
		choiceMat = fliplr(choiceMat);
    case 4
        choiceMat = tril(ones(5,5));           % diagonal south
		choiceMat(1:length(choiceMat)+1:end) = 0.5;
		choiceMat = flipud(fliplr(choiceMat));

    case 5
    	% cardinal union
    	tmp = genCategoricalModelRDM(1);
    	m1 = tmp.choiceMat;
    	tmp = genCategoricalModelRDM(2);
    	m2 = tmp.choiceMat;
    	choiceMat = cast((m1==1 | m2==1),'double');
	case 6
		% cardinal intersection
		tmp = genCategoricalModelRDM(1);
    	m1 = tmp.choiceMat;
    	tmp = genCategoricalModelRDM(2);
    	m2 = tmp.choiceMat;
    	choiceMat = cast((m1==1 & m2==1),'double');


	case 7
		% diagonal union
		tmp = genCategoricalModelRDM(3);
    	m1 = tmp.choiceMat;
    	tmp = genCategoricalModelRDM(4);
    	m2 = tmp.choiceMat;
    	choiceMat = cast((m1==1 | m2==1),'double');

	case 8
		% diagonal intersection
		tmp = genCategoricalModelRDM(3);
    	m1 = tmp.choiceMat;
    	tmp = genCategoricalModelRDM(4);
    	m2 = tmp.choiceMat;
    	choiceMat = cast((m1==1 & m2==1),'double');

end


% 2. compute rdm:
myModel.choiceMat = choiceMat;
myModel.choiceRDM = squareform(pdist(choiceMat(:)));
end

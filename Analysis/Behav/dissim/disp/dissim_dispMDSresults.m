function dissim_dispMDSresults(mdsSet,data,titleStr)
	%% DISSIM_DISPMDSRESULTS(MDSSET,DATA,TITLESTR)
	%
	% plots mds results (
	% saves figures 
	%
	% (c) Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department,
	% University of Oxford

		
	fileNames = data(2).stimuli;
	idces     =            1:25;


	figure();set(gcf,'Color','w');
	tmp = dissim_generateArrangementImg(fileNames,mdsSet,idces);
	imshow(tmp);
	axis square;
	xlabel([]);
	ylabel([]);
	title({'\bf Group-Level RDM MDS'; ['\rm' titleStr] });
	set(gcf,'Position',[395,5,732,654]);
	% saveas(gcf,['dissim_RDMtoMDS_' strrep(titleStr,', ','_')  '_allindia.png']);
	% close all;

end 
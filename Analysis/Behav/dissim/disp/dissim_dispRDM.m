function dissim_dispRDM(rdm,imlist)
	%% DISSIM_DISPRDM(RDM_IMLIST)
	image(scale01(rankTransform_equalsStayEqual(rdm)),'CDataMapping','scaled','AlphaData',1);
	colormap('jet');
	addImageSequenceToAxes(gca,imlist);
	box off;
	axis off;
	
end
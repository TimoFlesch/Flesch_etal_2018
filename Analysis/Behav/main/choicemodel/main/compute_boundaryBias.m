
function boundaryBias = compute_boundaryBias(estimatedAngle,catBound,task)
	% we interpret a higher positive bias as stronger tendency towards a combined representations
	% hence the sign flip for north (combined would be 90, but optimal is 180 deg)
	% 
	% Timo Flesch, 2018
	switch task 
		case 'north'
			% boundaryBias = abs(rad2deg(circ_dist(deg2rad(estimatedAngle),deg2rad(catBound))));
			boundaryBias = -(rad2deg(circ_dist(deg2rad(estimatedAngle),deg2rad(catBound))));
		case 'south'
			boundaryBias = rad2deg(circ_dist(deg2rad(estimatedAngle),deg2rad(catBound)));
			% boundaryBias = abs(rad2deg(circ_dist(deg2rad(estimatedAngle),deg2rad(catBound))));
	end
end
function Y = choicemodel_helper_boundarymodel(X,phi,offset,slope,lapserate,monitor)
	%% REW_REGRESS_HELPER_BOUNDARYMODEL(X,PHI,OFFSET,SLOPE,MONITOR)
	%
	% flexible model that allows to capture choice dynamics in trees task
	%
	% INPUTS:
	% - X:     Matrix with input mesh coordinates (usually 25x2);
	% - PHI:   Angle of category boundary (deg)
	% - OFFSET: Shift of boundary along x-axis
	% - SLOPE: Slope of sigmoidal squashing function ( for choice probabilities)
	% - LAPSERATE: [0,0.5] moves shrinks y-range. 0.5== flat line, corresponds to random error trials
	%
	% OUTPUTS:
	% - Y: matrix of choice probabilities for each coordinate pair in X
	%
	% Timo Flesch, 2017
	% Summerfield Lab, Experimental Psychology Department
	% University of Oxford

	if~exist('monitor')
		monitor = 0;
	end

	if isempty(X)
		[x,y] = meshgrid(-2:2,-2:2);
		X     =         [x(:),y(:)];
	end

	%% Step 1: Project each point onto subspace and compute distance to origin
	% (1a)  compute line orthogonal to decision boundary:
	phi_bound =                deg2rad(phi);
	phi_ort   =       phi_bound-deg2rad(90);
	c         = [cos(phi_ort);sin(phi_ort)];
	% (1b) scalar projection of each b-x-l tuple onto c
	% note: s = |a_bl|*cos(phi_ort) = ||a_bl||*(a_bl^t*c)/(||a_bl||*||c||)
	%         = ((a_bl^t)*c)/(||c||) = (a_bl^t)*c if c is already unit vect
	% let's apply to whole matrix:
	s_proj = (X*c);

	%% Step 2:  Pass each s_proj through sigmoidal squashing function (with slope and offset) and return results as 5x5 (or whatever) matrix of choice probabilities
	Y = reshape(lapserate + (1-lapserate*2)./(1+exp(-slope*(s_proj-offset))),sqrt(length(s_proj)),sqrt(length(s_proj)));



	if monitor
		figure();set(gcf,'Color','w');
		set(gcf,'Position',[78,297,1225,369]);
		subplot(1,3,1);
		% grid with boundary and direction vect
		%scatter(x(:),y(:),'filled');
		scatter(X(:,1),X(:,2),'filled');
		hold on;
		hb = plot([-2*cos(phi_bound),2*cos(phi_bound)],[-2*sin(phi_bound),2*sin(phi_bound)],'Color',[1 0 0],'LineWidth',2);
		hc = quiver(0,0,2*cos(phi_ort),2*sin(phi_ort),'Color',[0 0.3 0],'AutoScale','off','MaxHeadSize',1.1,'LineWidth',1);
		hc.LineWidth = 2;
		set(gca,'XTick',-2:2);
		set(gca,'YTick',-2:2);
		set(gca,'XTickLabel',1:5,'FontWeight','normal');
		set(gca,'YTickLabel',1:5,'FontWeight','normal');
		xlabel('Branchiness','FontWeight','bold');
		ylabel('Leafiness','FontWeight','bold');
		title({'\bf Boundary Orientation'; [num2str(phi) '°']});
		xlim([-2,2]);
		ylim([-2,2]);
		axis square;


		subplot(1,3,2);
		% sigmoid
		plot(-2:0.1:2,1./(1+exp(-slope*([-2:0.1:2]-offset))),'LineWidth',2,'Color',[0 0 0.8]);
		set(gca,'XTick',-2:2);
		set(gca,'XTickLabel',-50:25:50,'FontWeight','normal');
		set(gca,'YTick',0:0.25:1,'FontWeight','normal');
		ylim([0,1]);
		xlabel('Reward','FontWeight','bold');
		ylabel('P(Plant Tree)','FontWeight','bold');
		title({'\bf Transducer';[' Slope ' num2str(slope) ', Offset ' num2str(offset) ', Lapse ' num2str(lapserate)]});
		box off;
		axis square;
		hsp1 = get(gca, 'Position');


		subplot(1,3,3);
		% output
		img = imagesc(flipud(Y)); % flip or visualisation purposes
		set(img,'CDataMapping','scaled');
		set(gca,'CLim',[0,1]);
		colormap('jet');
		set(gca,'XTickLabel',1:5,'FontWeight','normal');
		set(gca,'YTick',1:5);
		set(gca,'YTickLabel',{5:-1:1},'FontWeight','normal');
		xlabel('Branchiness','FontWeight','bold');
		ylabel('Leafiness','FontWeight','bold');
		title('Generated Choice Probabilities');
		cb = colorbar();
		ylabel(cb,'P(Plant Tree)','FontWeight','bold');
		axis square;
		hsp2 = get(gca, 'Position')
		set(gca, 'Position', [hsp2(1:2) 1.1*hsp1(3) hsp2(4)])

		end
end

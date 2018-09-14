function disp_comparisonstats(results)


    % % 1. RT
    %     % Train
    %     % rel - irrel
    %     helper_plot_rt(results.rt.train.rel,'Relevant Dimension, Diagonal, Training')
    %     helper_plot_rt(results.rt.train.irrel,'Irrelevant Dimension, Diagonal, Training')
    %     % Test
    %     % rel - irrel
    %     helper_plot_rt(results.rt.test.rel,'Relevant Dimension, Diagonal, Test')
    %     helper_plot_rt(results.rt.test.irrel,'Irrelevant Dimension, Diagonal, Test')
   % 2. Choice
        % Train
        % rel - irrel
        helper_plot_choice(results.choice.train.rel,'Relevant Dimension, Diagonal, Training')
        helper_plot_choice(results.choice.train.irrel,'Irrelevant Dimension, Diagonal, Training')
        % Test
        % rel - irrel
        helper_plot_choice(results.choice.test.rel,'Relevant Dimension, Diagonal, Test')
        helper_plot_choice(results.choice.test.irrel,'Irrelevant Dimension, Diagonal, Test')

    % % 3. Choice Matrices
    %     % Train
    %     helper_plot_matrices_avgAll(results.choicematrix.train,'Diagonal, Training')
    %     % Test
    %     helper_plot_matrices_avgAll(results.choicematrix.test,'Diagonal, Test')

% choice matrices, avg tasks:
%helper_plot_matrices_avgTasks(results.choicematrix.train,'Diagonal, Training',1)
% savefig('choiceMats_avgTasks_Diagonal_train.fig')
% saveas(gcf,'choiceMats_avgTasks_Diagonal_train.svg','svg');
% saveas(gcf,'choiceMats_avgTasks_Diagonal_train.png','png');
%helper_plot_matrices_avgTasks(results.choicematrix.test,'Diagonal, Test',1)
% savefig('choiceMats_avgTasks_Diagonal_test.fig')
% saveas(gcf,'choiceMats_avgTasks_Diagonal_test.svg','svg');
% saveas(gcf,'choiceMats_avgTasks_Diagonal_test.png','png');

end

function helper_plot_rt(data,taskID)
	figure(); set(gcf,'Color','w');

	cols = [0 0 0.8;
            0,0,0.5;
            0,0,0.2;
            0,0.5,0.5]; % b200,20,2,in
	ssDat = struct();

	% blocked 200
	eb = errorbar([1:5]-0.05,mean(data.b200,1),std(data.b200,0,1)./sqrt(size(data.b200,1)),'LineStyle','none');
    eb.Color = [0 0 0];
	eb.LineWidth = 1.5
	hold on;
	ssDat(1).h = scatter([1:5]-0.05,mean(data.b200,1));
	ssDat(1).h.MarkerFaceColor = cols(1,:);
	ssDat(1).h.MarkerEdgeColor = [0 0 0];
	ssDat(1).h.SizeData = 70;

	% % blocked 20
	% eb = errorbar([1:5]-0.02,mean(data.b20,1),std(data.b20,0,1)./sqrt(size(data.b20,1)),'LineStyle','none');
 %    eb.Color = [0 0 0];
	% eb.LineWidth = 1.5
	% hold on;
	% ssDat(2).h = scatter([1:5]-0.02,mean(data.b20,1));
	% ssDat(2).h.MarkerFaceColor = cols(2,:);
	% ssDat(2).h.MarkerEdgeColor = [0 0 0];
	% ssDat(2).h.SizeData = 70;

	% % blocked 2
	% eb = errorbar([1:5]+0.02,mean(data.b2,1),std(data.b2,0,1)./sqrt(size(data.b2,1)),'LineStyle','none');
 %    eb.Color = [0 0 0];
	% eb.LineWidth = 1.5
	% hold on;
	% ssDat(3).h = scatter([1:5]+0.02,mean(data.b2,1));
	% ssDat(3).h.MarkerFaceColor = cols(3,:);
	% ssDat(3).h.MarkerEdgeColor = [0 0 0];
	% ssDat(3).h.SizeData = 70;

	% interleaved
	eb = errorbar([1:5]+0.05,mean(data.int,1),std(data.int,0,1)./sqrt(size(data.int,1)),'LineStyle','none');
    eb.Color = [0 0 0];
	eb.LineWidth = 1.5
	hold on;
	ssDat(4).h = scatter([1:5]+0.05,mean(data.int,1));
	ssDat(4).h.MarkerFaceColor = cols(4,:);
	ssDat(4).h.MarkerEdgeColor = [0 0 0];
	ssDat(4).h.SizeData = 70;

    set(gca,'TickDir', 'out');
    set(gca,'YGrid','on');
    set(gca,'XGrid','on');
	set(gca,'Box','off');
	ylabel({'\bf Reaction Time' ;'\rm [ms]'});
	xlabel(['\bf Reward Value']);
    set(gca,'YTickLabel',get(gca,'YTick').*1000);
	set(gca,'XTick',1:5);
    set(gca,'XTickLabel',-50:25:50);
	title({'\bf Reaction Time';['\rm  ' taskID]},'FontSize',14);
	% legend([ssDat(1).h,ssDat(2).h,ssDat(3).h,ssDat(4).h],{'blocked200','blocked20','blocked2','interleaved'},'Location','NorthEast');
  legend([ssDat(1).h,ssDat(4).h],{'blocked200','interleaved'},'Location','NorthEast');
end



function helper_plot_choice(data,taskID);
    %%%   TASK %%%
	figure(); set(gcf,'Color','w');
	sgm = struct();
	%% RAW DATA
	% blocked 200
	eb = errorbar(-2:2,mean(data.b200,1),std(data.b200,0,1)./sqrt(size(data.b200,1)),'LineStyle','none');
	eb.Color = [0 0 0];
	eb.LineWidth = 1.5
	hold on;
	ssDat = scatter(-2:2,mean(data.b200,1));
	ssDat.MarkerFaceColor = [0 0 0.8];
	ssDat.MarkerEdgeColor = [0 0 0];
	ssDat.SizeData = 50;

 %    % blocked 20
	% eb = errorbar(-2:2,mean(data.b20,1),std(data.b20,0,1)./sqrt(size(data.b20,1)),'LineStyle','none');
	% eb.Color = [0 0 0];
	% eb.LineWidth = 1.5
	% hold on;
	% ssDat = scatter(-2:2,mean(data.b20,1));
	% ssDat.MarkerFaceColor = [0 0 .5];
	% ssDat.MarkerEdgeColor = [0 0 0];
	% ssDat.SizeData = 50;

 %    % blocked 2
	% eb = errorbar(-2:2,mean(data.b2,1),std(data.b2,0,1)./sqrt(size(data.b2,1)),'LineStyle','none');
	% eb.Color = [0 0 0];
	% eb.LineWidth = 1.5
	% hold on;
	% ssDat = scatter(-2:2,mean(data.b2,1));
	% ssDat.MarkerFaceColor = [0 0 .2];
	% ssDat.MarkerEdgeColor = [0 0 0];
	% ssDat.SizeData = 50;


    % interleaved
	eb = errorbar(-2:2,mean(data.int,1),std(data.int,0,1)./sqrt(size(data.int,1)),'LineStyle','none');
	eb.Color = [0 0 0];
	eb.LineWidth = 1.5
	hold on;
	ssDat = scatter(-2:2,mean(data.int,1));
	ssDat.MarkerFaceColor = [0 .5 .5];
	ssDat.MarkerEdgeColor = [0 0 0];
	ssDat.SizeData = 50;

	set(gca,'TickDir', 'out');
	set(gca,'YGrid','on');
	set(gca,'Box','off');
	set(gca,'YTick',0:0.1:1);
	set(gca,'XTick',-2:2)
	set(gca,'XTickLabel',-50:25:50);

	xlim([-2 2]);

    % NLINFIT
 	x = -2:2;
    % blocked200
	y = mean(data.b200,1);

	sigma = fitSigmoid([x',y']);
	sgm(1).h = plot(-2:0.01:2,mysigmoid(sigma,-2:0.01:2),'Color',[0 0 .8],'LineStyle','-','LineWidth',4	);
	hold on;

    % blocked20
	y = mean(data.b20,1);

	sigma = fitSigmoid([x',y']);
	sgm(2).h = plot(-2:0.01:2,mysigmoid(sigma,-2:0.01:2),'Color',[0 0 .5],'LineStyle','-','LineWidth',4	);
	hold on;

    % blocked2
	y = mean(data.b2,1);

	sigma = fitSigmoid([x',y']);
	sgm(3).h = plot(-2:0.01:2,mysigmoid(sigma,-2:0.01:2),'Color',[0 0 .2],'LineStyle','-','LineWidth',4	);
	hold on;

    % interleaved
    x = -2:2;
	y = mean(data.int,1);

	sigma = fitSigmoid([x',y']);
	sgm(4).h = plot(-2:0.01:2,mysigmoid(sigma,-2:0.01:2),'Color',[0 .5 .5],'LineStyle','-','LineWidth',4	);
	hold on;

	ylabel(['\bf P(Plant Tree)'])
	xlabel(['\bf Reward(Plant Tree)']);
	set(gca,'XTickLabel',[-50:25:50]);
	title({'\bf Choice ';['\rm  ' taskID]},'FontSize',14);
	ylim([0 1]);
   % legend([sgm(1).h,sgm(4).h],{'blocked200','interleaved'},'Location','SouthEast');
	legend([sgm(1).h,sgm(2).h,sgm(3).h,sgm(4).h],{'blocked200','blocked20','blocked2','interleaved'},'Location','SouthEast');

end


function fun = mysigmoid(b,x)

fun = 1./(1+exp(-b(1)*(x-b(2))));
% fun = 1./(1+exp(-b(1).*(x)));
%fun = normcdf(x,0,b(1));

end


function helper_plot_matrices_avgAll(data,taskID)
	% highly redundant code that serves its purpose...
  % average across all coherent and all incoherent


  figure();set(gcf,'Color','w');
  % blocked200
  subplot(2,2,1)
  thisMat = squeeze(nanmean(data.north.b200,1));
  plot_rewmat(thisMat,1)
  title({'\bf Blocked 200, North';[ '\rm' taskID]},'FontSize',14)
  subplot(2,2,3)
  thisMat = squeeze(nanmean(data.south.b200,1));
  plot_rewmat(thisMat,2)
  title({'\bf Blocked 200, South';[ '\rm' taskID]},'FontSize',14)

  % % blocked20
  % subplot(2,4,2)
  % thisMat = squeeze(nanmean(data.north.b20,1));
  % plot_rewmat(thisMat,3)
  % title({'\bf Blocked 20, North'; ['\rm' taskID]},'FontSize',14)
  % subplot(2,4,6)
  % thisMat = squeeze(nanmean(data.south.b20,1));
  % plot_rewmat(thisMat,4)
  % title({'\bf Blocked 20, South';[ '\rm' taskID]},'FontSize',14)

  % % blocked2
  % subplot(2,4,3)
  % thisMat = squeeze(nanmean(data.north.b2,1));
  % plot_rewmat(thisMat,3)
  % title({'\bf Blocked 2, North'; ['\rm' taskID]},'FontSize',14)
  % subplot(2,4,7)
  % thisMat = squeeze(nanmean(data.south.b2,1));
  % plot_rewmat(thisMat,4)
  % title({'\bf Blocked 2, South';[ '\rm' taskID]},'FontSize',14)

  %interleaved
  subplot(2,2,2)
  thisMat = squeeze(nanmean(data.north.int,1));
  plot_rewmat(thisMat,1)
  title({'\bf Interleaved, North'; ['\rm' taskID]},'FontSize',14)
  subplot(2,2,4)
  thisMat = squeeze(nanmean(data.south.int,1));
  plot_rewmat(thisMat,2)
  title({'\bf Interleaved, South';[ '\rm' taskID]},'FontSize',14)
  %set(gcf,'Position',[361,49,865,567]);

end


function helper_plot_matrices_avgTasks(data,taskID,isDiag)
  % highly redundant code that serves its purpose...
  % average across all coherent and all incoherent

  if isDiag
    bID = 3
  else
    bID = 1
  end
  figure();set(gcf,'Color','w');
  % blocked200
  subplot(1,4,1)
  thisMat = squeeze(nanmean(data.b200,1));
  plot_rewmat(thisMat,bID)
  title({'\bf Blocked 200';[ '\rm' taskID]},'FontSize',14)



  % % blocked20
  % subplot(1,4,2)
  % thisMat = squeeze(nanmean(data.b20,1));
  % plot_rewmat(thisMat,bID)
  % title({'\bf Blocked 20'; ['\rm' taskID]},'FontSize',14)

  % % blocked2
  % subplot(1,4,3)
  % thisMat = squeeze(nanmean(data.b2,1));
  % plot_rewmat(thisMat,bID)
  % title({'\bf Blocked 2'; ['\rm' taskID]},'FontSize',14)


  %interleaved
  subplot(1,4,4)
  thisMat = squeeze(nanmean(data.int,1));
  plot_rewmat(thisMat,bID)
  title({'\bf Interleaved'; ['\rm' taskID]},'FontSize',14)

  set(gcf,'Position',[-1674,408,1371,311]);

end


function plot_rewmat(matFile,rewLabelIndex)

imagesc(matFile);
set(gca,'XTick',1:5);
set(gca,'YTick',1:5);
set(gca,'XTickLabel',1:5);
set(gca,'YTickLabel',1:5);
xlabel({'\bf Feature Value ', '\rm dimension 1'},'FontSize',10);
ylabel({'\bf Feature Value ', '\rm dimension 2'},'FontSize',10);
colormap('parula');
axis('square');

switch rewLabelIndex
    case 1 % blocked north
        text(0.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(5,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);



    case 2 % blocked south
        text(0.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,1, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,1,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,2, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,2,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,2,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,3,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,3,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,3, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,3,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,3,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,4,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,4,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,4, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,5,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.00,5, '0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,5,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);

    case 3 % Diagonal north
                text(0.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,1,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,1,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(5.00,1,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,2,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.00,2,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,2,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,3,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,3,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,3,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,3,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,4,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2,4,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,4,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.00,5,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,5,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,5,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);

    case 4 % Diagonal south
        text(0.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,5,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,5,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(5.00,5,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(0.75,4,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,4,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,4,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.00,4,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(4.75,4,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,3,'-50','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,3,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3,3,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(3.75,3,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,3,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(0.75,2,'-25','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2,2,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(2.75,2,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,2,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,2,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(1.00,1,'0','Color',[1 1 1],'FontWeight','bold','FontSize',6);
        text(1.75,1,'+25','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(2.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(3.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
        text(4.75,1,'+50','Color',[0 0 0],'FontWeight','bold','FontSize',6);
end
cb = colorbar()
ylabel(cb,'\bf P(Plant Tree) \rm')
end

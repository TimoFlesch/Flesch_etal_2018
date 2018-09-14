function plotAllFigures(panelID)
  %% PLOTALLFIGURES(PANELID)
  %
  % wrapper script to recreate figures reported in paper
  % if you want to recreate results from raw data, consult the readme and
  % execute the corresponding functions :)
  %
  % USAGE:
  % just pass the numerical ID of the panel you'd like to recreate,
  % e.g. plotAllFigures(2) for panel 2 (Exp1a)
  % The Window titles contain the figure IDs (e.g. Panel 2, Fig A)
  %
  % Timo Flesch, 2018
  % Human Information Processing Lab,
  % Experimental Psychology
  % University of Oxford

  addpath(genpath([pwd '../Data/']));
  addpath(genpath([pwd '../Analysis/']));


  switch panelID
    case 1
      disp('Panel contains no data (only task design)');
    case 2
      % A learning curves and test accuracy
      load('allData_exp1a')
      disp_lcurve_binned(allData)
      f = gcf;
      f.Name = 'Panel 2, Fig A';

      % B switch vs stay accuracy
      load('accuracies_exp1a.mat')
      disp_accuracies(acc_all)
      f = gcf;
      f.Name = 'Panel 2, Fig B';

      % C sigmoids
      load('choiceRTstats_exp1a.mat');
      disp_sigmoids(results.choice);
      f = gcf;
      f.Name = 'Panel 2, Fig C';

      % E rsa model correlations
      load('taus_rsa_exp1a.mat')
      disp_rsa_3Dvs2DModelCorrelationResults(taus)
      f = gcf;
      f.Name = 'Panel 2, Fig E';

      % F model frequencies
      load('modelfits_exp1a.mat');
      disp_choicemodel_RFXBMSresults(results.modelcomps)
      f = gcf;
      f.Name = 'Panel 2, Fig F';

      % G angular bias
      disp_choicemodel_angles_decisionBound(results.modelfits.free_twoBoundsAndSigmoids,'exp1')
      f = gcf;
      f.Name = 'Panel 2, Fig G';
      % H lapse
      disp_choicemodel_lapse_decisionBound(results.modelfits.free_twoBoundsAndSigmoids,'exp1')
      f = gcf;
      f.Name = 'Panel 2, Fig H';

    case 3
      % A learning curves and test accuracy
      load('allData_exp1b')
      disp_lcurve_binned(allData)
      f = gcf;
      f.Name = 'Panel 3, Fig A';

      % B switch vs stay accuracy
      load('accuracies_exp1b.mat')
      disp_accuracies(acc_all)
      f = gcf;
      f.Name = 'Panel 3, Fig B';

      % C sigmoids
      load('choiceRTstats_exp1b.mat');
      disp_sigmoids(results.choice);
      f = gcf;
      f.Name = 'Panel 3, Fig C';

      % E rsa model correlations
      load('taus_rsa_exp1b.mat')
      disp_rsa_3Dvs2DModelCorrelationResults(taus)
      f = gcf;
      f.Name = 'Panel 3, Fig E';

      % F model frequencies
      load('modelfits_exp1b.mat');
      disp_choicemodel_RFXBMSresults(results.modelcomps)
      f = gcf;
      f.Name = 'Panel 3, Fig F';

      % G angular bias
      disp_choicemodel_angles_decisionBound(results.modelfits.free_twoBoundsAndSigmoids,'exp1')
      f = gcf;
      f.Name = 'Panel 3, Fig G';
      % H lapse
      disp_choicemodel_lapse_decisionBound(results.modelfits.free_twoBoundsAndSigmoids,'exp1')
      f = gcf;
      f.Name = 'Panel 3, Fig H';

    case 4
      disp('Panel contains no data (only task desigh)');

    case 5
      % A prior diff accuracy - cardinal
      load('accuracy_highVSlowGridiness_exp2a.mat');
      disp_gridprior_accuracy(acc_all)
      f = gcf;
      f.Name = 'Panel 5, Fig A';
      % B prior diff factorisation - cardinal
      load('corrs_rdms_highVSlowGridiness_exp2a.mat')
      disp_gridprior_taus(acc_all)
      f = gcf;
      f.Name = 'Panel 5, Fig B';
      % C prior diff accuracy - diagonal
      load('accuracy_highVSlowGridiness_exp2b.mat');
      disp_gridprior_accuracy(acc_all)
      f = gcf;
      f.Name = 'Panel 5, Fig C';
      % D prior diff factorisation - diagonal
      load('corrs_rdms_highVSlowGridiness_exp2b.mat')
      disp_gridprior_taus(acc_all)
      f = gcf;
      f.Name = 'Panel 5, Fig D';

    case 6
      % A performance - cardinal
      load('accuracy_exp3a');
      cnn_disp_testAcc(results);
      f = gcf;
      f.Name = 'Panel 6, Fig A';
      % B performance - diagonal
      load('accuracy_exp3b');
      cnn_disp_testAcc(results);
      f = gcf;
      f.Name = 'Panel 6, Fig B';
      % C rdm corrs - cardinal
      load('taus_rsa_exp3ab.mat')
      cnn_disp_rdmCorrsPaper(taus,'cardinal')
      f = gcf;
      f.Name = 'Panel 6, Fig C';
      % D rdm corrs - diagonal
      cnn_disp_rdmCorrsPaper(taus,'diagonal')
      f = gcf;
      f.Name = 'Panel 6, Fig D';
    case 7
      % A - latent traverse, was created in tensorflow on the fly
      % B - performance boost - cardinal
      cnn_disp_testAcc_vanillaVSpretrained('a');
      f = gcf;
      f.Name = 'Panel 7, Fig B';
      % C - factorisation boost - cardinal
      cnn_disp_rdmCorrsPaper_vanillaVSpretrained('a',1);
      f = gcf;
      f.Name = 'Panel 7, Fig C';
      % D - interference reduction - cardinal
      cnn_disp_rdmCorrsPaper_vanillaVSpretrained('a',2);
      f = gcf;
      f.Name = 'Panel 7, Fig D';
      % E - performance boost - diagonal
      cnn_disp_testAcc_vanillaVSpretrained('b')
      f = gcf;
      f.Name = 'Panel 7, Fig E';
      % F - factorisation boost -diagonal
      cnn_disp_rdmCorrsPaper_vanillaVSpretrained('b',1);
      f = gcf;
      f.Name = 'Panel 7, Fig F';
      % G - interference reduction - diagonal
      cnn_disp_rdmCorrsPaper_vanillaVSpretrained('b',2);
      f = gcf;
      f.Name = 'Panel 7, Fig G';
    otherwise
      disp(['Invalid ID (' num2str(panelID) ') \n Please use a value in the range 1,7']);

  end

end


## Analysis Scripts for Main Task (Exp 1,2)
***
### Data Preprocesssing

* **data/data_renameData()**  
Changes names of files to more accessible  format. requires that Jan's uncell script has preprocessed data

* **data/data_getAllData()**  
Loads all single-subject data, removes bad subjects and saves in one matlab .mat

* **data/data_reshapeData()**  
Reshapes matrices into format that I personally find most accessible

* **data/data_add_irrelevantDimensionValues()**  
adds data columns for irrelevant dimensions

* **data/data_add_boundarycodes()**  
adds identifier for orientation of bound

* **data/data_extractSubjectReports()**  
prints subject reports and mean accuracies at test


***
### Basic Descriptive Stats
functions for accuracy, p(choice) and RT   
* **compute/compute_pcorrect_learningCurve()**  
Computes group-level learning curves based on accuracy

* **compute/wrapper_rew_learningCurves()**  
calls above mentioned scripts and displays results (using rew_plot functions)

* **compute/compute_accuracy()**  
computes accuracy for training and test, switch and stay trials

* **compute/compute_rt()**  
computes RT for training and test, switch and stay trials

* **compute/compute_RTandCP()**  
computes RT and p(choice) as function of feature values (branchiness,leafiness)
returns values for relevant, irrelevant dimension and choice matrices

***
### Regression Analysis
* **regress_psychometrics()**  
sigmoids for relevant and irrelevant dimensions


***  
### RSA
functions for RSA on choice probabilities  

* **rsa/rsa_computeBehavRDMs()**   
computes behavioural RDMs

* **rsa/rsa_genCategoricalModelRDM()**  
generates model RDMs assuming either a cardinal or a diagonal boundary

* **rsa/rsa_partialcorr3Dvs2DModelBehavRDMs()**  
performs partial correlation between candidate models and behav RDMs

* **rsa/rsa_corr3Dvs2DModelBehavRDMs()**  
performs correlation between orthogonalised candidate models and behav RDMs

***
### Choice Model
functions for psychophysical models and bayesian model comparison
* **choicemodel/choicemodel_boundarymodel()**  
old demo function, implements and displays functionality of model

* **choicemodel/choicemodel_paramrecovery()**  
performs parameter recovery to validate model.

* **choicemodel/main/**  
model comparison of constrained vs unconstrained models
  * **external/barwitherr()**  
  plots bars with error bars (external)

  * **external/circ_dist()**  
  computes angular distance (external, circstat toolbox)

  * **external/sigstar()**  
  adds sig stars to bar plots (external)    

  * **models/fixedBoundaryModelTT()**  
  constrained model

  * **models/freeBoundaryModelTT()**    
  unconstrained model  

  * **fitBoundaryModelTT()**  
  fits models to data

  * **compute_boundaryBias()**  
  helper function to compute angular distance between true and estimated bound  

  * **main_compareModels()**  
  bayesian model comparison (requires vba toolbox)

  * **main_computePVals()**
  computes p values  

  * **main_fitAllmodels_cmats()**   
  fits models to choice matrices

  * **main_plotFittingResults()**  
  plots results of model fitting procedure  

  * **main_setFittingParams()**  
  sets all relevant parameters  

  * **wrapper_fmincon_bothtasks()**  
  a wrapper function for all above :)  

  * **sampling_intrusion/sample_modelresponses()**  
  using best-fitting parameters, function samples synthetic responses from model  

  * **sampling_intrustion/fitsigmoids()**  
  fits sigmoids to relevant and irrelevant dimension of synthetic data (above)  

  * **sampling_intrustion/sample_plotslopes()**  
  plots estimated slopes for relevant and irrelevant dimensions
  answers question if model recreates observed intrusion effects

* **choicemodel/tasklapse/**  
model comparison of task lapse with unconstrained and constrained models.


***
### Grid Priors and Main Performance
* **gridprior/gridprior_ancova()**   
performs ANCOVA on grid prior, group and accuracy/task factorisaton indices

* **gridprior/mediansplit_accuracy()**  
accuracy: low vs high prior

* **gridprior/mediansplit_choicematrices()**  
choice matrices: data split in low vs high prior  

* **gridprior/mediansplit_modelCorrs()**  
rdm correlations: low vs high prior

***  
### Figures

* **disp/disp_accuracies()**  
training/test phase accuracy bar plots (also for switch vs stay)  

* **disp/disp_rt()**  
training and test phase RT bar plots (also switch vs stay)

* **disp/disp_logrt()**  
training and test phase logRT bar plots (also switch vs stay)

* **disp/disp_lcurve_binned()**  
learning curves, averaged across bins of n trials  

* **disp/disp_lcurve_smooth()**  
learning curve as smoothed time series plot  (boxcar)  

* **disp/disp_comparisonstats()**  
choice probabilities, sigmoids, choice matrices

* **disp/disp_rsa_categoricalModelRDMs()**  
plots categorical model RDMs  

* **disp/disp_rsa_betweenModelRDMCorrelations()**  
plots correlation between (orthogonalised) model- and behav RDMs  

* **disp/disp_rsa_3Dvs2DModelPartialCorrelationResults()**  
plots partial correlation between model- and behav RDMs  

* **disp_choicemodel_angles_decisionBound()**  
plots angular distance between estiamted and true category boundary  

* **disp_choicemodel_offsets_decisionBound()**  
plots estimated shift of sigmoidal transducer   

* **disp_choicemodel_slopes_decisionBound()**  
plots estimated slope of transducer  

* **disp_choicemodel_lapse_decisionBound()**  
plots estimated lapse rate  

* **disp_choicemodel_paramrecovery()**  
plots results of parameter recovery simulation  



***  
### Statistical Inference
t-tests, ranksum etc  on results from computations above  

* **all_stats_behav()**  
computes and returns all reported statistics  

***
***

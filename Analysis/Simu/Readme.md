## Analysis Scripts for Simulations (Exp 3 & 4)

### Data Preprocessing

* **data/cnn_collectSubjects()**  
loads single runs and organises data in struct. Note: need to specify file name

* **data/cnn_remove_badruns()**  
remove runs where network got stuck  

* **data/wrapper_cnn_collectSubjects()**  
iterates through all groups and creates data structs. prints session-specific test accuracy  

***
### Basic Stats

* **cnn_eval_accuracy()**  
computes learning curves as well as test accuracy for each task and test phase  

* **cnn_eval_choices()**  
computes choice matrices and - if desired - aligns them in common reference frame

* **cvaecnn_compute_performanceDiff**  
computes performance difference between vanillaCNN and priorCNN  


***
### RSA

* **cnn_compute_rdms_layers()**
computes representational dissimilarity matrices for each hidden layer of CNN

* **wrapper_cnn_compute_rdms()**  
wrapper for function above, iterates through different groups with differing task order and boundary orientation  

* **cnn_compute_rdms_choice()**
computes rdms for output layer (choice probabilities)  

* **compute_modelRDMs()**  
computes various model RDMs  

* **cnn_correlate_model_layerRDMs()**  
correlates model RDMs with RDMs computed for each layer   

* **cvae_compute_rdms()**  
computes rdms for layer-wise activation patterns
for each beta-vae that was trained

* **cvae_compute_rdmCorr()**  
computes grid-prior of trained beta-vaes

***
### Figures
* **cnn_disp_accuracy()**  
learning curves as well as bar plots of mean accuracy for first and second task  

* **cnn_disp_testAcc()**  
displays test accuracy as bar plots of mean + SEM  

* **cnn_disp_testAcc_vanillaVSpretrained()**
displays test accuracy as bar plots of mean + SEM  
and compares vanillaCNN with priorCNN

* **cnn_disp_choicematrices()**
plots choice matrices of simulations  

* **cnn_disp_rdms()**  
displays RDMs for each layer

* **cnn_disp_rdmCorrsPaper()**  
displays rdm correlations for each layer  

* **cnn_disp_rdmCorrsPaper_vanillaVSpretrained**()  
displays model correlations for factorised and interference model and compares the priorCNN vs with vanillaCNN  

* **disp_modelRDMs()**  
displays model RDMs  

* **cnn_visualizeFiltersAndOutputs()**  
visualises learned conv filters and layer-outputs  

* **cvae_dispRDM()**  
displays RDMs of beta-VAE layer activity  

* **cvae_dispRDMCorrResults()**  
displays RDM correlation of beta-VAE (e.g. grid-prior)

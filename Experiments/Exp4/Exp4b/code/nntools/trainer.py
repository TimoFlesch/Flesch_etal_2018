"""
Training is defined in here
Timo Flesch, 2017
Summerfield lab, Experimental Psychology Department
University of Oxford

"""
import numpy      as np 
import tensorflow as tf
from datetime import datetime

FLAGS = tf.app.flags.FLAGS


def trainModel(sess,nnet,data_train,data_test,n_episodes=100,n_batches=10,batch_size=128,model_dir='./'):
    sess = nnet.session;

    # declare some log vars 
    results = {}
    images_orig          = []
    images_reconstructed = []
    loss_total_train     = []
    loss_total_test      = []

    # 1. add baseline summaries     
    # nnet.images(data_test['images'][0,:]) # reconstructed image of only noise

    # --- main training loop ------------------------------------------------------
    # save model
    # nnet.save_ckpt(model_dir + '/')     
    # perform online training
    # init data arrays:
    # choices (for learning curves)
    choice_train   = np.array([])
    # choices (for test accuracies)
    choice_test    = np.array([])

    # categories for learning curves and accuracies
    cat_train     = np.array([])
    cat_test      = np.array([])
    

    # layer wise outputs
    outConv1  = np.array([])
    outConv2  = np.array([])
    fc_test   = np.array([])
    fc2_test   = np.array([])
    
    
    
    blockStart = 0
    blockStart_train = 0
    
    
    for ii in range(data_train['images'].shape[0]):
                   
        # set reward value
        thisReward = (data_train['rewards'][ii]).reshape(1,1) 
        # set input 
        thisX = np.expand_dims(data_train['images'][ii],axis=0)
        # update weights
        thisOutput = nnet.train(thisX,thisReward)         
        # compute choice
        thisChoice = nnet.inference(thisX)        
        # save choice
        choice_train = np.append(choice_train,thisChoice)
    
        # every 200 trials, compute performance, don't save, just stdout
        if((ii+1)%200 == 0):            
            # compute chosen categories
            cat_train = (choice_train>0.5).astype('int')
            cat_train[choice_train<=0.5] = -1
            # compare targets with estimates up til now
            targets = data_train['categories'][blockStart_train:ii]
            estimates = cat_train[blockStart_train:ii]
            train_acc = np.mean(estimates[targets!=0]==targets[targets!=0])
            expTime = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            print('{} Trial {} Training Window Accuracy {:2.3f} \n'.format(expTime, int(ii+1), train_acc ))

        # at the end of each training block, evaluate 
        if((ii+1) % (FLAGS.exp_exemplars_train*25) == 0):            
            for jj in range(data_test['images'].shape[0]): 
                # choice                              
                choice_test = np.append(choice_test,nnet.inference(np.expand_dims(data_test['images'][jj],axis=0)))
            
            # layer activations for north task, full 5x5
            for jj in range(25):    
                # layer activations
                fc,fc2 = nnet.readLayers(data_test['images'][jj])
                # print(str(conv1.shape) + '_' + str(conv2.shape) + '_' + str(fc.shape) )
                
                # outConv1 = np.append(outConv1,np.expand_dims(conv1,0),axis=0) if outConv1.size else np.expand_dims(conv1,0)
                # outConv2 = np.append(outConv2,np.expand_dims(conv2,0),axis=0) if outConv2.size else np.expand_dims(conv2,0)
                fc_test  = np.append(fc_test,np.expand_dims(fc,0),axis=0)     if fc_test.size  else np.expand_dims(fc,0)
                fc2_test  = np.append(fc2_test,np.expand_dims(fc2,0),axis=0)     if fc2_test.size  else np.expand_dims(fc2,0)
            # .. and for south task:
            for jj in range(int(FLAGS.exp_exemplars_test*25),int(FLAGS.exp_exemplars_test*25)+25):
                # layer activations
                fc,fc2 = nnet.readLayers(data_test['images'][jj])
                # outConv1 = np.append(outConv1,np.expand_dims(conv1,0),axis=0) if outConv1.size else np.expand_dims(conv1,0)
                # outConv2 = np.append(outConv2,np.expand_dims(conv2,0),axis=0) if outConv2.size else np.expand_dims(conv2,0)
                fc_test  = np.append(fc_test,np.expand_dims(fc,0),axis=0)     if fc_test.size  else np.expand_dims(fc,0)
                fc2_test  = np.append(fc2_test,np.expand_dims(fc2,0),axis=0)     if fc2_test.size  else np.expand_dims(fc2,0)
            
            cat_test = (choice_test > 0.5).astype('int')
            cat_test[choice_test <= 0.5] = -1

            targets = data_test['categories']
            targets_first = targets[0:targets.shape[0]/2]
            targets_second = targets[targets.shape[0]/2:]
            estimates = cat_test[blockStart:]
            estimates_first = estimates[0:estimates.shape[0]/2]
            estimates_second = estimates[estimates.shape[0]/2:]

            # test acc, first
            test_acc_all = np.mean(estimates[targets!=0]==targets[targets!=0])
            test_acc_first = np.mean(estimates_first[targets_first!=0]==targets_first[targets_first!=0])
            test_acc_second = np.mean(estimates_second[targets_second!=0]==targets_second[targets_second!=0])
            expTime = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            print('{} Test Accuracy, Both: {:2.3f}, First: {:2.3f}, Second: {:2.3f} \n'.format(expTime, test_acc_all, test_acc_first, test_acc_second ))
            blockStart += data_test['images'].shape[0]   
            blockStart_train = ii         
            
        cat_train = (choice_train>0.5).astype('int')
        cat_train[choice_train<=0.5] = -1

        results = {'rTrain':data_train['rewards'],      #  reward              training
                    'tTrain':data_train['contexts'],    #  task (context)      training
                    'bTrain':data_train['branchiness'], #  branchiness         training
                    'lTrain':data_train['leafiness'],   #  leafiness           training
                    'cTrain':data_train['categories'],  #  category            training
                    'rTest':data_test['rewards'],       # reward               test
                    'tTest':data_test['contexts'],      # task                 test
                    'bTest':data_test['branchiness'],   # branchiness          test
                    'lTest':data_test['leafiness'],     # leafiness            test
                    'cTest':data_test['categories'],    # category             test
                    'choiceTrain':choice_train,         # choice probability,  training
                    'catTrain': cat_train,              # chosen category,     training
                    'choiceTest':choice_test,           # choice probability,  test
                    'catTest':cat_test,                 # choice category,     test
                    'fcTest':fc_test,                   # fc layer outputs,    test
                    'fc2Test':fc2_test,                 # fc2 layer outputs,    test
                    'conv1Test':outConv1,               # conv1 layer outputs, test
                    'conv2Test':outConv2}               # conv2 layer outputs, test
    return results  


"""
implements the cnn for the trees task
Timo Flesch, 2017
"""

import os
import numpy      as np 
import tensorflow as tf 

from nntools.io       import saveMyModel
from nntools.layers   import *
from nntools.external import *

FLAGS = tf.app.flags.FLAGS

class myModel(object):
    """
    the cnn class
    """

    def __init__(self,
        dim_inputs   =          [None,96,96,3],
        dim_outputs  =                [None,1],
        n_hidden     =                    512,
        lr           =                   0.005,
        optimizer    =                  'Adam',
        nonlinearity =                  'relu',
        keep_prob    =                     1.0,
        is_trained   =                  False):
        """ initializes the model with parameters """

        self.ITER           =     0
        self.session        =  None
        self.learning_rate  =    lr 
        
        self.dim_inputs     =  dim_inputs
        self.dim_outputs    = dim_outputs
        self.n_hidden       =    n_hidden
        
        
        self.nonlinearity   = getattr(tf.nn,nonlinearity)
        self.initializer    = tf.truncated_normal_initializer(FLAGS.weight_init_mu, 
                                FLAGS.weight_init_std)        

        # dictionary for all parameters (weights + biases)
        self.params        =  {}

        self.init_done     = False

        if not(is_trained):
            # input placeholder
            with tf.name_scope('input'):
                self.x = tf.placeholder(tf.float32,[None,self.dim_inputs[1]*self.dim_inputs[2]*self.dim_inputs[3]],name='x_in')
                self.W_Loss = tf.placeholder(tf.float32,self.dim_outputs,name='w_loss')
                self.keep_prob = tf.placeholder(tf.float32,name='keep_probability')
                
            
            # the neural network and label placeholder
            with tf.variable_scope('nnet'):
                self.nnet_builder()

            # optimizer
            with tf.name_scope('optimisation'):
                # loss function
                with tf.name_scope('loss-function'):
                    self.loss = tf.reduce_sum(-tf.matmul(self.y_out,tf.transpose(self.W_Loss)),name="loss")
                    print(self.loss.get_shape().as_list())

                # optimisation procedure
                with tf.name_scope('optimizer'):
                    self.optimizer = getattr(tf.train,optimizer+'Optimizer')(learning_rate=self.learning_rate)
                    self.train_step = self.optimizer.minimize(self.loss)


            # image visualiser
            with tf.name_scope('visualiser'):
                self.visIMG_orig  = self.x_img # tf.reshape(self.x,[1,96,96,3],name='reshape_input')
                self.visIMG_conv  = put_kernels_on_grid(self.params['l1_conv_weights'])
               

        else:
            self.init_done = True 


    def nnet_builder(self):
        """ creates neural network function approximator """
        
        # convolutions
        with tf.variable_scope('convolutions'):
            self.x_img = tf.reshape(self.x,[-1,self.dim_inputs[1],self.dim_inputs[2],self.dim_inputs[3]])
                   
            # first convolutional layer
            self.l1_conv, self.params['l1_conv_weights'], self.params['l1_conv_biases'], self.params['l1_conv_shape'] = layer_conv2d(self.x_img,
                16,(5,5),name='l1_conv',nonlinearity=self.nonlinearity,stride=(2,2),padding='SAME')
            print(self.params['l1_conv_shape'])
            # second convolutional layer
            self.l2_conv, self.params['l2_conv_weights'], self.params['l2_conv_biases'], self.params['l2_conv_shape'] = layer_conv2d(self.l1_conv,
                32,(3,3),name='l2_conv',nonlinearity=self.nonlinearity,stride=(2,2),padding='SAME')
            print(self.params['l2_conv_shape'])
            # third convolutional layer
            self.l3_conv, self.params['l3_conv_weights'], self.params['l3_conv_biases'], self.params['l3_conv_shape'] = layer_conv2d(self.l2_conv,
                32,(3,3),name='l3_conv',nonlinearity=self.nonlinearity,stride=(2,2),padding='SAME')
            print(self.params['l3_conv_shape'])

        # fully-connected block
        with tf.variable_scope('fullyconnected'):  
            # 1. flatten       
            self.l_flat = layer_flatten(self.l3_conv,name='l_flat')
            # 2. first fully connected
            self.l_fc, self.params['l_fc_weights'], self.params['l_fc_biases']   = layer_fc(self.l_flat,self.n_hidden,name='l_fc',nonlinearity=self.nonlinearity)
            # 3. first drop out
            self.l_dropout = layer_dropout(self.l_fc,self.keep_prob,name='l_dropout')

            # # 4. second fully connected
            self.l_fc2, self.params['l_fc2_weights'], self.params['l_fc2_biases']   = layer_fc(self.l_dropout,self.n_hidden,name='l_fc2',nonlinearity=self.nonlinearity)
            # 5. second dropout
            self.l_dropout2 = layer_dropout(self.l_fc2,self.keep_prob,name='l_dropout2')

        # read-out
        with tf.variable_scope('readout'):
            self.y_out,self.params['y_out_weights'],self.params['y_out_biases'] = layer_fc(self.l_dropout2,self.dim_outputs[1],name='y_out',nonlinearity=tf.nn.sigmoid)

        return


    def init_graph_vars(self,sess,log_dir='.'):
        """ initializes graph variables """
        # set session
        self.session = sess
        # initialize all variables
        self.init_op = tf.global_variables_initializer()
        self.session.run(self.init_op)

        # define saver object AFTER variable initialisation
        self.saver = tf.train.Saver()

        # define summaries
        self.summaryTraining = tf.summary.scalar("loss_training",self.loss)        
        self.summaryTest     = tf.summary.scalar("loss_test",self.loss)        
        
        self.summaryImgOrig   = tf.summary.image("input image",self.visIMG_orig)
        # filters, first convo layer
        self.summaryImgConv   = tf.summary.image("conv1_filters",self.visIMG_conv)

                
        self.merged_summary = tf.summary.merge_all()
       

        self.init_done = True


    def save_ckpt(self,modelDir):
        """ saves model checkpoint """
        # save the whole statistical model
        saved_ops = [('nnet',self.y_hat),('input',self.x)] 

        saveMyModel(self.session,
                    self.saver,
                    saved_ops,
                    globalStep=self.ITER,
                    modelName=modelDir+ FLAGS.model + '_' + FLAGS.exp_curriculum + '_' + FLAGS.exp_boundary + '_' + FLAGS.exp_taskorder + '_' + FLAGS.exp_rewards)


    def inference(self,x):
        """ forward pass of x through myModel """
        if x.ndim==1:
            x = np.expand_dims(x,axis=0)            
        y_out = self.session.run(self.y_out,feed_dict={self.x: x,self.keep_prob:1.0})
        return y_out


    def readLayers(self,x):
        """ 
        forward pass of x through model, return layer activations (flattened)
        """
        if x.ndim==1:
            x = np.expand_dims(x,axis=0)            
        conv1 = self.session.run(self.l1_conv,feed_dict={self.x: x,self.keep_prob:1.0})
        conv1 = conv1.reshape(conv1.shape[1]*conv1.shape[2]*conv1.shape[3])
        conv2 = self.session.run(self.l2_conv,feed_dict={self.x: x,self.keep_prob:1.0})
        conv2 = conv2.reshape(conv2.shape[1]*conv2.shape[2]*conv2.shape[3])
        fc = self.session.run(self.l_fc,feed_dict={self.x: x,self.keep_prob:1.0})
        fc2 = self.session.run(self.l_fc2,feed_dict={self.x: x,self.keep_prob:1.0})
        return conv1,conv2,fc,fc2


    def train(self,x,rew):
        """ training step """ 
        _,loss,summary_train = self.session.run([self.train_step,self.loss,self.summaryTraining],
            feed_dict={self.x: x,self.W_Loss: rew,self.keep_prob:FLAGS.dropout})
        
        self.ITER +=1 # count one iteration up
        return loss


    def eval(self,x,rew):
        """ evaluation step """
        y_out,loss,summary_test = self.session.run([self.y_out,self.loss,self.summaryTest],
            feed_dict={self.x: x,self.W_Loss: rew,self.keep_prob:1.0})

        return loss


    def images(self,x):
        if x.ndim==1:
            x = np.expand_dims(x,axis=0)
        imgOrig,imgConv = self.session.run([self.summaryImgOrig,self.summaryImgConv],
            feed_dict={self.x: x,self.keep_prob:1.0})        



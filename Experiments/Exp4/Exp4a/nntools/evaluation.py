import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
import numpy as np 
import tensorflow as tf 
from nntools.visualisation import *

FLAGS = tf.app.flags.FLAGS

def evalModel(sess,nnet,x_train):
    """
    evaluates trained model
    """
    x_sample = x_train[0:50,:]
    # plot a few reconstructions
    plotReconstructions(sess,nnet,x_sample)
    # plot traversal of latent space, if vae:
    if FLAGS.model == 'vae' or FLAGS.model == 'cvae' or FLAGS.model == 'bvae' or FLAGS.model == 'cbvae':
        plotLatentSpace(sess,nnet)
    
 





"""
Example implementations of various autoencoder flavours
and their application to the well-known and exciting MNIST dataset

Timo Flesch, 2017
"""

# external
import tensorflow as tf 
import numpy      as np
from datetime import datetime

# custom
from nntools.data       import    *
from agent.runAgent     import    runAgent 
from nntools.io         import    save_log, load_data



# -- define flags --
FLAGS = tf.app.flags.FLAGS

# directories
tf.app.flags.DEFINE_string('data_dir',  '../data/simu_images/',  
                           """ (string) data directory           """)

tf.app.flags.DEFINE_string('ckpt_dir', '../checkpoints/', 
                            """ (string) checkpoint directory    """)

tf.app.flags.DEFINE_string('log_dir',          '../log/', 
                           """ (string) log/summary directory    """)


# dataset
tf.app.flags.DEFINE_integer('n_samples_train', 50000, 
                           """ (int) number of training samples """)

tf.app.flags.DEFINE_integer('n_samples_test',  10000,  
                           """ (int) number of test samples     """)


# model
tf.app.flags.DEFINE_string('model',                'cvae', 
                            """ (string)  chosen model          """)

tf.app.flags.DEFINE_bool('do_training',               1, 
                            """ (boolean) train or not          """)

tf.app.flags.DEFINE_float('weight_init_mu',         0.0, 
                            """ (float)   initial weight mean   """)

tf.app.flags.DEFINE_float('weight_init_std',        .01, 
                            """ (float)   initial weight std    """)

tf.app.flags.DEFINE_string('nonlinearity',       'relu', 
                            """ (string)  activation function   """)

tf.app.flags.DEFINE_integer('n_hidden',             200,
                            """ dimensionality of hidden layers """)

tf.app.flags.DEFINE_integer('n_latent',             2,
                            """ dimensionality of latent layer """)

tf.app.flags.DEFINE_integer('beta',                 1,
                            """ beta parameter for KLD scaling """)

# training
tf.app.flags.DEFINE_float('learning_rate',     0.001, 
                            """ (float)   learning rate               """)

tf.app.flags.DEFINE_integer('n_training_episodes',   10, 
                            """ (int)    number of training episodes  """)


tf.app.flags.DEFINE_integer('display_step',         1, 
                            """(int) episodes until training log      """)

tf.app.flags.DEFINE_integer('batch_size',         100, 
                            """ (int)     training batch size         """)

tf.app.flags.DEFINE_string('optimizer',       'Adam', 
                            """ (string)   optimisation procedure     """)

tf.app.flags.DEFINE_integer('n_training_batches',   
                            int(FLAGS.n_samples_train/FLAGS.batch_size), 
                            """    number of training batches per ep  """)

tf.app.flags.DEFINE_integer('n_test_batches',   
                            int(FLAGS.n_samples_test/FLAGS.batch_size), 
                            """    number of test batches per ep  """)





def main(argv=None): 
    """ here starts the magic """
    # 1. import trees data 
    data_train = load_data('imgSet_north_training',FLAGS.data_dir)
    data_test  = load_data(    'imgSet_north_test',FLAGS.data_dir)

    #x_train,_ = shuffleData(x_train)    
    data_train,data_test = normalizeData(data_train,data_test)

    # 2. Train CAE       
    results = runAgent(data_train,data_test)

    if FLAGS.do_training:
        logName = '/log_trainingsess_mod_normalisedIMG' + FLAGS.model + '_beta_' + str(FLAGS.beta) + datetime.now().strftime('%Y-%m-%d_%H%M%S')
    else:
        logName = '/log_evaluationsess_mod_normalisedIMG' + FLAGS.model + '_beta_' + str(FLAGS.beta) + datetime.now().strftime('%Y-%m-%d_%H%M%S')

    save_log(results,logName,FLAGS.log_dir)


if __name__ == '__main__':
    """ take care of flags on load """
    tf.app.run()

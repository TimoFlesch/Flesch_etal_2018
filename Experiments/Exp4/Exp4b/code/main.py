"""
Implementation of the Trees Task Simulation with CNN

Timo Flesch, 2017
"""

# external
import tensorflow as tf 
import numpy      as np
from datetime import datetime

# custom
from nntools.experiment import    *
from nntools.data       import    *
from agent.runAgent     import    runAgent 
from nntools.io         import    save_log



# -- define flags --
FLAGS = tf.app.flags.FLAGS

# directories
# tf.app.flags.DEFINE_string('data_dir', '../../../../../data/simu_data/',  
#                            """ (string) data directory           """)

tf.app.flags.DEFINE_string('data_dir', '../../../data/simu_data/',  
                           """ (string) data directory           """)

tf.app.flags.DEFINE_string('import_dir', '../trained_cvaes/model_cvae_normalisedIMG_beta_50/', 
                            """ (string) cvae import directory    """)

tf.app.flags.DEFINE_string('ckpt_dir', '../checkpoints/', 
                            """ (string) checkpoint directory    """)

tf.app.flags.DEFINE_string('log_dir',          '../log/', 
                           """ (string) log/summary directory    """)


# experiment
tf.app.flags.DEFINE_integer('exp_runID', 1,
                            """  (integer) run id, to distinguish logfiles""")

tf.app.flags.DEFINE_string('exp_curriculum',   'blocked',
                            """ (string) blocked or interleaved           """)

tf.app.flags.DEFINE_string('exp_boundary',   'cardinal',
                            """ (string) cardinal or diagonal             """)

tf.app.flags.DEFINE_string('exp_rewards',     'pp',
                            """ (string) pp,mm,pm,mp -> sign of rewards   """)

tf.app.flags.DEFINE_string('exp_taskorder',     'ns',
                            """ (string) ns or sn, order of tasks         """)

tf.app.flags.DEFINE_integer('exp_exemplars_train',  400,
                            """ (int) number of training exemplars        """)

tf.app.flags.DEFINE_integer('exp_exemplars_test',   200,
                            """ (int) number of test exemplars            """)

tf.app.flags.DEFINE_integer('exp_num_trainsets',      1,
                            """ (int) number of north-south training sets """)

# model
tf.app.flags.DEFINE_string('model',       'CNN_CVAE_BETA50', 
                            """ (string)  model name            """)

tf.app.flags.DEFINE_bool('do_training',               1, 
                            """ (boolean) train or not          """)

tf.app.flags.DEFINE_float('weight_init_mu',         0.0, 
                            """ (float)   initial weight mean   """)

tf.app.flags.DEFINE_float('weight_init_std',        .01, 
                            """ (float)   initial weight std    """)

tf.app.flags.DEFINE_string('nonlinearity',       'relu', 
                            """ (string)  activation function   """)


# training
tf.app.flags.DEFINE_float('learning_rate',     5e-5, 
                            """ (float)   learning rate               """)

tf.app.flags.DEFINE_string('optimizer',       'Adam', 
                            """ (string)   optimisation procedure     """)

tf.app.flags.DEFINE_float('dropout', 0.5,
                            """ (float) keep probability              """)



def main(argv=None): 
    """ here starts the magic """    
    
    # 1. construct experiment    
    data_train =  makeExp(FLAGS.exp_exemplars_train,FLAGS.exp_curriculum,FLAGS.exp_boundary,FLAGS.exp_rewards,FLAGS.exp_taskorder,repExp=FLAGS.exp_num_trainsets,doSuperimpose=1)
    data_test  =  makeExp(FLAGS.exp_exemplars_test,'blocked',FLAGS.exp_boundary,FLAGS.exp_rewards,FLAGS.exp_taskorder,expPhase='test',doSuperimpose=1,doShuffle=0)
    
    data_train['images'],data_test['images'] = normalizeData(data_train['images'],data_test['images'])
    # data_test = []
    # data_train = []

    # 2. Run Experiment
    results = runAgent(data_train,data_test)

    if FLAGS.do_training:
        logName = '/log_trainingsess_mod_' + FLAGS.model + '_' + FLAGS.exp_curriculum + '_' + FLAGS.exp_boundary + '_' + FLAGS.exp_taskorder + '_' + FLAGS.exp_rewards + '_' + str(FLAGS.exp_runID) #datetime.now().strftime('%Y-%m-%d_%H%M%S')
    else:
        logName = '/log_evaluationsess_mod_' + FLAGS.model + '_' + FLAGS.exp_curriculum + '_' + FLAGS.exp_boundary + '_' + FLAGS.exp_taskorder + '_' + FLAGS.exp_rewards + '_' + str(FLAGS.exp_runID) #datetime.now().strftime('%Y-%m-%d_%H%M%S')

    save_log(results,logName,FLAGS.log_dir)


if __name__ == '__main__':
    """ take care of flags on load """
    tf.app.run()

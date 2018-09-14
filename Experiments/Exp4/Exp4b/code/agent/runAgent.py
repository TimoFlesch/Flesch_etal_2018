"""
runner function for cnn 
Timo Flesch, 2017
"""
# external
import numpy      as np
import tensorflow as tf

# custom
from agent.model        import         myModel
from nntools.trainer    import      trainModel
from nntools.evaluation import       evalModel
from nntools.io         import     loadMyModel,importModelGraph
from datetime           import        datetime

FLAGS = tf.app.flags.FLAGS

def runAgent(data_train,data_test):
    # checkpoint run model folder
    ckpt_dir_run = FLAGS.ckpt_dir 
    log_dir_run  = FLAGS.log_dir  

    if not(tf.gfile.Exists(ckpt_dir_run)):
        tf.gfile.MakeDirs(ckpt_dir_run) 

    if not(tf.gfile.Exists(log_dir_run)):
        tf.gfile.MakeDirs(log_dir_run) 

    with tf.Session() as sess:      

        if FLAGS.do_training:
            
            # import graph from trained model
            # ckpt = tf.train.get_checkpoint_state(FLAGS.import_dir)
            # if ckpt and ckpt.model_checkpoint_path:
            #     saver = tf.train.import_meta_graph(ckpt.model_checkpoint_path + '.meta')
            #     myGraph = tf.get_default_graph()
            myGraph = importModelGraph(FLAGS.import_dir)
            for ii in myGraph.get_operations():
                print(ii.name)
            

            nnet = myModel(lr           = FLAGS.learning_rate,
                           optimizer    =     FLAGS.optimizer,
                           nonlinearity =  FLAGS.nonlinearity,
                           imported_graph = myGraph
                           )
            print("Now training the Trees Agent, " + FLAGS.model + ', ' + FLAGS.exp_curriculum + ', ' + FLAGS.exp_boundary + ', ' + FLAGS.exp_taskorder + ', ' + FLAGS.exp_rewards)
            
            # initialize all variables
            nnet.init_graph_vars(sess,log_dir=log_dir_run)

            # train model
            results = trainModel(sess,nnet,data_train,data_test,
                model_dir   =   ckpt_dir_run)

        else:           
            nnet = myModel(is_trained=True)
            print("Now evaluating Trees Agent")
            ops = loadMyModel(sess,['nnet','input'],ckpt_dir_run)
            print(ops)
            nnet.session = sess
            nnet.y_hat = ops[0]
            nnet.x     = ops[1]

            results = evalModel(sess,nnet)

        return results

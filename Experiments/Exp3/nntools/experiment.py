"""
MAKEDATASETS.py
generates experiment data for cnn simulation
(c) Timo Flesch, 2017
Summerfield Lab,
Experimental Psychology Department,
University of Oxford


"""
import numpy      as np
import tensorflow as tf
import     os
# import    cv2
import pickle

from PIL        import Image,ImageFilter
from sys        import              argv

FLAGS = tf.app.flags.FLAGS
## PATH DEFS ------------------------------------------------------------------




## FUNCTION DEFS --------------------------------------------------------------
def makeBlock(task,boundary,rewSign,exemplar_ids,doSuperimpose,expPhase='training',doShuffle=1):
    """
    generates training curricula via sampling from saved data sets
    - task         (string):    'north' or 'south'    
    - boundary     (string):    'cardinal' or 'diagonal'
    - rewSign      (string):    'p' or 'm'  -> plus or minus
    - exemplar_ids (int array): exemplars to sample (*25==blocklength) 
    - doSuperimpose (int):      1 or 0, to select data with context image or without

    """
    pathData    =  FLAGS.data_dir
    if doSuperimpose:
        pathData += 'withgarden/'
    else:
        pathData += 'withoutgarden/'

    rewID = 0 if boundary=='cardinal' else 2
    rewID = rewID if rewSign=='p' else rewID+1    
    
    # 1. load file with correct task 
    fileName = pathData + expPhase + '_data_' + task 
    if doSuperimpose:
        fileName = fileName + '_withgarden'


    with open(fileName,'rb') as f:
        data = pickle.load(f)

    # 2. sample the exemplars 
    exp_block = {}
    for ii in data.keys():
        exp_block[ii] = np.array([])
        for jj in exemplar_ids:
            exp_block[ii] = np.concatenate((exp_block[ii],data[ii][data['exemplars']==jj]),axis=0) if len(exp_block[ii]) else data[ii][data['exemplars']==jj]
    exp_block['categories'] = exp_block['categories'][:,rewID]
    exp_block['rewards'] = exp_block['rewards'][:,rewID]
    
    # 3. shuffle the block
    if doShuffle:
        ii_shuff = np.random.permutation(exp_block['rewards'].shape[0])
        print('number of shuffle indices')
        print(len(ii_shuff))
        for ii in exp_block.keys():
            exp_block[ii] = exp_block[ii][ii_shuff]

    return exp_block



def makeExp(numExemplars,curriculum,boundary,rewSigns,taskOrder,expPhase='training',repExp=1,doSuperimpose=1,doShuffle=1):
    """
    concatenates training curricula
    Input:
    - numExemplars:  (int) number of exemplars to use (times 25 for trial number)
    - curriculum:    (string) 'blocked','interleaved'
    - boundary:      (string) orientation of category boundary, one of 'cardinal', 'diagonal'
    - rewSigns:      (string) sign of rewards, one of 'pp' 'mm' 'pm' 'mp'
    - taskOrder:     (string) order of tasks (only relevant for blocked, but must be declared) one of 'ns' 'sn'
    - repExp:        (int)    number of north-south sets (1==one, 2==two etc..)
    - doSuperimpose: (int)    1 or 0, to select data with context image or without
    """ 
    # important: i used the same exemplars for both tasks, to ensure that they do not rote-learn 
    # exemplar-task-memberships -> generate sampling vector in this function
    pathData    =  FLAGS.data_dir
    gardenNames = ['north','south'] if taskOrder=='ns' else ['south','north']
    
    exp_data = {}

    exemplarIDs_north = np.random.permutation(np.arange(numExemplars))
    exemplarIDs_north = exemplarIDs_north[0:numExemplars]
    exemplarIDs_south = np.random.permutation(np.arange(numExemplars))
    exemplarIDs_south = exemplarIDs_south[0:numExemplars]
    print('number of exemplar ids, north/south:')
    print(len(exemplarIDs_north))
    print(len(exemplarIDs_south))
    # create two blocks. if desired, repeat this process and concatenate
    for kk in range(0,repExp):
        tmp = {}
        # create two blocks  of shuffled exp data          
        block_first = makeBlock(gardenNames[0],boundary,rewSigns[0],exemplarIDs_north,doSuperimpose,expPhase,doShuffle) 
        block_second = makeBlock(gardenNames[1],boundary,rewSigns[1],exemplarIDs_south,doSuperimpose,expPhase,doShuffle)            
        
        # concatenate the two blocks
        for ii in block_first.keys():
            tmp[ii] = np.concatenate((block_first[ii],block_second[ii]),axis=0)
        
        # add the block-tuple to the set of tasks
        for ii in tmp.keys():
            exp_data[ii] = np.concatenate((exp_data[ii],tmp[ii]),axis=0) if ii in exp_data.keys() else tmp[ii]

    # if curriculum is interleaved, shuffle everything
    if (curriculum=='interleaved'):
        ii_shuff = np.random.permutation(exp_data['rewards'].shape[0])
        for ii in exp_data.keys():
            exp_data[ii] = exp_data[ii][ii_shuff]


    return exp_data

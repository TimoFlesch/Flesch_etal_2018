import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf


def visualizeTraining():
    """
    - time series of training and test loss
    - epoch-wise reconstruction plots   
    """
    pass

def visualizeEvaluation():
    """
    - final reconstruction
    - final latent tsne
    - if convo: filters 
    """
    pass

   

def plotReconstructions(sess,nnet,x_sample,ep_num=1,beta=1):
    """
    plots reconstructions of inputs
    code heavily inspired by https://jmetzen.github.io/2015-11-27/vae.html
    """

    # x_reconstruct,_ = nnet.inference(x_sample)
    x_reconstruct = nnet.inference(x_sample)
    
    fig = plt.figure(figsize=(15, 15))
    for i in range(25):

        plt.subplot(5, 5, i+1)
        img = plt.imshow(x_sample[i].reshape(96, 96, 3), vmin=0, vmax=1, cmap="gray")        
        plt.title("Input Image")
        # plt.colorbar()
        plt.axis('off')
        img.axes.get_xaxis().set_visible(False)
        img.axes.get_yaxis().set_visible(False)
    
    plt.tight_layout()
    # plt.show()
    fig.savefig('originals_' + str(ep_num) + '_beta_' + str(beta) + '.png')


    fig = plt.figure(figsize=(15, 15))
    for i in range(25):
        plt.subplot(5, 5, i+1)        
        img = plt.imshow(x_reconstruct[i].reshape(96, 96, 3), vmin=0, vmax=1, cmap="gray")
        plt.title("Reconstructed Image")
        # plt.colorbar()
        plt.axis('off')
        img.axes.get_xaxis().set_visible(False)
        img.axes.get_yaxis().set_visible(False)    
    plt.tight_layout()

    # plt.show()
    fig.savefig('reconstructions_' + str(ep_num) + '_beta_' + str(beta) + '.png')
        

    

def plotLatentSpace(sess,nnet,ep_num=1,beta=1):
    """
    traverses the latent space and plots generated 
    samples
    code heavily inspired by https://jmetzen.github.io/2015-11-27/vae.html
    """
    
    num_x = num_y = 20
    x_vals = np.linspace(-5, 5, num_x)
    y_vals = np.linspace(-5, 5, num_y)

    # create space for image
    img_space = np.empty((96*num_y, 96*num_x,3))
    for i, yi in enumerate(x_vals):
        for j, xi in enumerate(y_vals):
            # create 100 samples
            z_mu = np.array([[xi, yi]]*100)            
            x_mean = nnet.sample(z_mu)
            # arrange the mean of the samples in image space
            img_space[(num_x-i-1)*96:(num_x-i)*96, j*96:(j+1)*96,:] = x_mean[0].reshape(96, 96,3)

    fig = plt.figure(figsize=(10, 10))        
    # Xi, Yi = np.meshgrid(x_vals, y_vals)
    img = plt.imshow(img_space, origin="upper", cmap="gray")
    plt.axis('off')
    img.axes.get_xaxis().set_visible(False)
    img.axes.get_yaxis().set_visible(False)
    plt.title('Traversing the Latent Space')
    plt.tight_layout()
    # plt.show()
    fig.savefig('latentspace_' + str(ep_num) + '_beta_' + str(beta) + '.png')

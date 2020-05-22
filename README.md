# EDMSPRec 
The Code is created based on the method described in the following paper:        
High-dimensional Embedding Network Derived Prior for Compressive Sensing MRI Reconstruction    
M. Zhang, M. Li, J. Zhou, Y. Zhu, S. Wang, D. Liang, Q. Liu.      
## Motivation
Although recent deep learning methodologies have shown excellent performance in fast imaging, the network needs to be retrained for specific sampling patterns and ratios. Therefore, how to explore the network as a general prior and leverage it into the observation constraint flexibly is urgent. In this work, we present an enhanced Deep Mean-Shift Prior (EDMSP) to address the highly MRI under-sampling reconstruction problem. By extending the naive DMSP via integration of multi-model aggre-gation and multi-channel network learning, a high-dimensional embedding network derived prior is formed. Then, we apply the learned prior to single-channel image reconstruction via variable augmen-tation technique. The resulting model is tackled by proximal gradient descent and alternative iteration. Experimental results under various sampling trajectories and acceleration factors consistently demon-strated the superiority of the proposed prior.
### Figs
![repeat-MEDMSP](https://github.com/yqx7150/MEDMSP/blob/master/Figs/Fig1.png)
Schematic illustration of the multi-channel network scheme at the training stage and the auxiliary variables technique used for single-channel intermediate image at the iterative reconstruction phase.

## Experiments   
<div align=center><img width="390" height="130" src="./SIATdata_Test123/SIAT_testdata.png"/></div>    
Three test images from SIAT.    

![repeat-MEDMSP](https://github.com/yqx7150/MEDMSP/blob/master/Figs/Fig2.png)
![repeat-MEDMSP](https://github.com/yqx7150/MEDMSP/blob/master/Figs/Fig3.png)
Reconstruction results at 90% radial undersampling. From left to right: DLMRI, PANO, FDLCP, NLR-CS, DC-CNN, DMSP-MWCNN and EDMSPRec.
### Table
![repeat-MEDMSP](https://github.com/yqx7150/MEDMSP/blob/master/Figs/Table1.png)
## Requirements and Dependencies
    MATLAB R2016b
    Cuda-9.0
    MatConvNet
    (https://pan.baidu.com/s/1ZsKlquIHqtgJYlq3iKNsdg Password：p130)
    MEDMSPRec_model_v2
    (https://pan.baidu.com/s/1voohJTmBSAF1XrHS7GpiRQ Password：8hnx)
    Pretrained Model
    (https://pan.baidu.com/s/1AdLa9kKiQ2F1_0jc-KS5EA Password：dvhs)
 

## Testing Data
  * Three brain MRI images from SIAT [<font size=5>**[Dataset]**</font>](https://github.com/yqx7150/EDMSPRec/tree/master/SIATdata_Test123)       
  * 50 proton-density weighted knee images from FastMRI [<font size=5>**[Dataset]**</font>](https://github.com/yqx7150/EDMSPRec/tree/master/fastMRIdata_50_testing)   


## Other Related Projects
  * Multi-Channel and Multi-Model-Based Autoencoding Prior for Grayscale Image Restoration  
[<font size=5>**[Paper]**</font>](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8782831)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/MEDAEP)   [<font size=5>**[Slide]**</font>](https://github.com/yqx7150/EDAEPRec/tree/master/Slide)

  * Denoising Auto-encoding Priors in Undecimated Wavelet Domain for MR Image Reconstruction  
 [<font size=5>**[Paper]**</font>](https://arxiv.org/ftp/arxiv/papers/1909/1909.01108.pdf)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/WDAEPRec)

  * Learning Priors in High-frequency Domain for Inverse Imaging Reconstruction  
[<font size=5>**[Paper]**</font>](https://arxiv.org/ftp/arxiv/papers/1910/1910.11148.pdf)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/HFDAEP)

  * Learning Multi-Denoising Autoencoding Priors for Image Super-Resolution  
[<font size=5>**[Paper]**</font>](https://www.sciencedirect.com/science/article/pii/S1047320318302700)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/MDAEP-SR)

  * Complex-valued MRI data from SIAT--test31 [<font size=5>**[Data]**</font>](https://github.com/yqx7150/EDAEPRec/tree/master/test_data_31)

  * Complex-valued MRI data from SIAT--SIAT_MRIdata200 [<font size=5>**[Data]**</font>](https://github.com/yqx7150/SIAT_MRIdata200)

  * REDAEP: Robust and Enhanced Denoising Autoencoding Prior for Sparse-View CT Reconstruction  
[<font size=5>**[Paper]**</font>](https://ieeexplore.ieee.org/document/9076295)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/REDAEP)

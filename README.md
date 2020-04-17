# EDMSPRec 
The Code is created based on the method described in the following paper:        
High-dimensional Embedding Network Derived Prior for Compressive Sensing MRI Reconstruction    
M. Zhang, M. Li, J. Zhou, Y. Zhu, S. Wang, D. Liang, Q. Liu.      
## Motivation
Although recent deep learning methodologies have shown excellent performance in fast imaging, the network needs to be retrained for specific sampling patterns and ratios. Therefore, how to explore the network as a general prior and leverage it into the observation constraint flexibly is urgent. In this work, we present an enhanced Deep Mean-Shift Prior (EDMSP) to address the highly MRI under-sampling reconstruction problem. By extending the naive DMSP via integration of multi-model aggre-gation and multi-channel network learning, a high-dimensional embedding network derived prior is formed. Then, we apply the learned prior to single-channel image reconstruction via variable augmen-tation technique. The resulting model is tackled by proximal gradient descent and alternative iteration. Experimental results under various sampling trajectories and acceleration factors consistently demon-strated the superiority of the proposed prior.
### Figs
![repeat-MEDMSP](https://github.com/yqx7150/MEDMSP/blob/master/Figs/Fig1.png)
Schematic illustration of the multi-channel network scheme at the training stage and the auxiliary variables technique used for single-channel intermediate image at the iterative reconstruction phase.

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
    Pretrained Model
    (https://pan.baidu.com/s/1AdLa9kKiQ2F1_0jc-KS5EA Password：dvhs)
 

## Other Related Projects
  * 50 proton-density weighted knee images from FastMRI   
[<font size=5>**[Dataset]**</font>](https://github.com/yqx7150/EDMSPRec/tree/master/fastMRIdata_50_testing)   


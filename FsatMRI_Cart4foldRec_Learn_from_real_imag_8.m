%% set to 0 if you want to run on CPU (very slow)
gpu = 1;
% if gpu
%     gpuDevice(gpu);
% end

%% #######%%%%% read sampling---start %%%%
load .\test_data_mask_FastMRI50\4_fold_cart_320;
figure(355); imshow(mask,[]);
n = size(mask,2);
fprintf(1, 'n=%d, k=%d, Unsamped=%f\n', n, sum(sum(mask)),1-sum(sum(mask))/n/n); %
%% #######%%%%% read sampling---end %%%%

resulti = [];
for i=1:1  %1:50  %[1,11,18,34,38]
    Tmp= load(['.\test_data_mask_FastMRI50\fastMRIdata_50\knee' num2str(i,'%02d') '.mat']);
    image= Tmp.Img;
    im_ori = double(image);
    im_ori = (im_ori - min(im_ori(:)))/(max(im_ori(:)) - min(im_ori(:)));
    im_orifft = fft2(im_ori);
    Img = ifft2(ifftshift(im_orifft));
    gt = 255*Img./max(abs(Img(:)));
    figure(334);imshow(abs(gt),[]);
    
    sigma_d = 0 * 255;
    noise = randn(size(gt));
    partialdata = mask.*(fft2(gt) + noise * sigma_d + (0+1i)*noise * sigma_d); %
    zero_filled = ifft2(partialdata);
    figure(335);imshow(abs(zero_filled),[]);
    
    %% #######%%%%% load network for solver---start %%%%
    params.gt = gt;   params.num_iter = 230;
    params.sigma_net = 10;   params.sigma_net2 = 10;  %8;
    
    load('.\models\fastMRIdata_2941_MWCNN_GDSigmaReal8\fastMRIdata_2941_MWCNN_GDSigmaReal8-epoch-45');  net1 = net;
    net1 = dagnn.DagNN.loadobj(net1) ;
    net1.removeLayer('objective') ;
    out_idx = net1.getVarIndex('prediction') ;
    net1.vars(net1.getVarIndex('prediction')).precious = 1 ;
    net1.mode = 'test';
    if gpu
        net1.move('gpu');
    end
    
    load('.\models\fastMRIdata_2941_MWCNN_GDSigmaImag8\fastMRIdata_2941_MWCNN_GDSigmaImag8-epoch-45');  net2 = net;
    net2 = dagnn.DagNN.loadobj(net2) ;
    net2.removeLayer('objective') ;
    out_idx = net2.getVarIndex('prediction') ;
    net2.vars(net2.getVarIndex('prediction')).precious = 1 ;
    net2.mode = 'test';
    if gpu
        net2.move('gpu');
    end
    %% #######%%%%% load network for solver---end %%%%
    
    %% #######%%%%% MEDMSPRec Reconstruction---start %%%%
    params.out_idx = out_idx;  params.gpu = gpu;
    [MEDMSPRec,resultimax] = FastMRI_DMSPMRIRec_2sigma(gt, zero_filled, partialdata, mask, params, net1, net2);
    %% #######%%%%% MEDMSPRec Reconstruction---end %%%%
    
    %% #######%%%%% display %%%%
    figure(666);
    subplot(2,3,[4,5,6]);imshow([abs(zero_filled-gt)/255,abs(MEDMSPRec-gt)/255],[]); title('Recon-error');colormap(jet);colorbar;
    subplot(2,3,1);imshow(abs(gt)/255); title('Ground-truth');colormap(gray);
    subplot(2,3,2);imshow(abs(zero_filled)/255); title('Zero-filled');colormap(gray);
    subplot(2,3,3);imshow(abs(MEDMSPRec)/255); title('Net-recon');colormap(gray);
    figure(667);imshow([real(gt)/255,imag(gt)/255,abs(gt)/255],[]);
    figure(668);imshow([abs(zero_filled-gt)/255,abs(MEDMSPRec-gt)/255],[]); colormap(jet);colorbar;
    
    resulti = [resulti;resultimax]
end









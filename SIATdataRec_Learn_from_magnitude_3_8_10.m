%% set to 0 if you want to run on CPU (very slow)
gpu = 2;
% if gpu
%     gpuDevice(gpu);
% end

%% #######%%%%% read sampling---start %%%%
%% 2D random-85%
load .\test_data_mask_SIAT3\mask_random015; mask = mask_random015;
%% radial-85%
% load mask_radial_015; mask = mask_radial_015;
% mask = fftshift(fftshift(mask,1),2);
%% cartesian-85%
% load mask_cart_085.mat;
% mask = mask_cart_085;
% mask = fftshift(fftshift(mask,1),2);
%% radial-90%
% line = 30;
% [mask] = strucrand(256,256,1,line);
% mask = fftshift(fftshift(mask,1),2);
%% radial-80%
% line = 61;
% [mask] = strucrand(256,256,1,line);
% mask = fftshift(fftshift(mask,1),2);
%% #######%%%%% read sampling---end %%%%
figure(355); imshow(mask,[]);   %
figure(356); imshow(fftshift(mask),[]);
n = size(mask,2);
fprintf(1, 'n=%d, k=%d, Unsamped=%f\n', n, sum(sum(mask)),1-sum(sum(mask))/n/n); %


%% #######%%%%% read test data---start %%%%
load .\test_data_mask_SIAT3\lsq68;  Img = imrotate(Img, 90); Img(:,end-6:end) = []; Img(:,1:7) = [];
%load .\test_data_mask_SIAT3\lsq200;  Img = imrotate(Img, 90); Img(:,end-6:end) = []; Img(:,1:7) = [];
%load .\test_data_mask_SIAT3\lsq196; Img = imrotate(Img, 90); Img(:,end-6:end) = []; Img(:,1:7) = [];
gt = 255*Img./max(abs(Img(:)));
figure(334);imshow(abs(gt),[]);
sigma_d = 0 * 255;
noise = randn(size(gt));
partialdata = mask.*(fft2(gt) + noise * sigma_d + (0+1i)*noise * sigma_d); %
zero_filled = ifft2(partialdata);
figure(335);imshow(abs(zero_filled),[]);
%% #######%%%%% read test data---end %%%%


%% #######%%%%% load network for solver---start %%%%
params.gt = gt;params.num_iter = 300;
params.sigma_net = 3;   params.sigma_net2 = 8;  params.sigma_net3 = 10;
load('.\models\MWCNN_GDSigma3_3D_400\MWCNN_GDSigma3_3D_400-epoch-45');  net1 = net;
net1 = dagnn.DagNN.loadobj(net1) ;
net1.removeLayer('objective') ;
out_idx = net1.getVarIndex('prediction') ;
net1.vars(net1.getVarIndex('prediction')).precious = 1 ;
net1.mode = 'test';
if gpu
    net1.move('gpu');
end
load('.\models\MWCNN_GDSigma8_3D_400\MWCNN_GDSigma8_3D_400-epoch-40');   net2 = net;
net2 = dagnn.DagNN.loadobj(net2) ;
net2.removeLayer('objective') ;
out_idx = net2.getVarIndex('prediction') ;
net2.vars(net2.getVarIndex('prediction')).precious = 1 ;
net2.mode = 'test';
if gpu
    net2.move('gpu');
end
load('.\models\MWCNN_GDSigma10_3D_400\MWCNN_GDSigma10_3D_400-epoch-45');   net3 = net;
net3 = dagnn.DagNN.loadobj(net3) ;
net3.removeLayer('objective') ;
out_idx = net3.getVarIndex('prediction') ;
net3.vars(net3.getVarIndex('prediction')).precious = 1 ;
net3.mode = 'test';
if gpu
    net3.move('gpu');
end
%% #######%%%%% load network for solver---end %%%%


%% #######%%%%% MEDMSPRec Reconstruction---start %%%%
params.out_idx = out_idx;  params.gpu = gpu;
MEDMSPRec = Complex_DMSPMRIRec_multi(gt, zero_filled, partialdata, mask, params, net1, net2, net3);
%% #######%%%%% MEDMSPRec Reconstruction---end %%%%


%% #######%%%%% display %%%%
[psnr4, ssim4, fsim4, ergas4, sam4] = MSIQA(abs(gt), abs(MEDMSPRec));
hfen = norm(imfilter(abs(MEDMSPRec/255),fspecial('log',15,1.5)) - imfilter(abs(gt/255),fspecial('log',15,1.5)),'fro');
[psnr4, ssim4, hfen]

figure(666);
subplot(2,3,[4,5,6]);imshow([abs(zero_filled-gt)/255,abs(MEDMSPRec-gt)/255],[]); title('Recon-error');colormap(jet);colorbar;
subplot(2,3,1);imshow(abs(gt)/255); title('Ground-truth');colormap(gray);
subplot(2,3,2);imshow(abs(zero_filled)/255); title('Zero-filled');colormap(gray);
subplot(2,3,3);imshow(abs(MEDMSPRec)/255); title('MEDMSPRec-recon');colormap(gray);
figure(667);imshow([real(gt)/255,imag(gt)/255,abs(gt)/255],[]);
figure(668);imshow([abs(zero_filled-gt)/255,abs(MEDMSPRec-gt)/255],[]); colormap(jet);colorbar;




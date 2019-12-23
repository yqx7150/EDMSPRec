%
% % add MatCaffe path
% addpath ../mnt/data/siavash/caffe/matlab;
% getd = @(p)path(path,p);% Add some directories to the path
% getd('DMSP_MRIRec/Matlabcode_TBMDUdemo_v1\');
% getd('DMSP_MRIRec/骆老师给的真实模拟数据\');
% getd('DMSP_MRIRec/traindata_lsq\');
% getd('DMSP_MRIRec/DMSP_diffSigma\');
% getd('DMSP_MRIRec/quality_assess\');
% getd('./');
%
% % set to 0 if you want to run on CPU (very slow)
gpu = 2;
% if gpu
%     gpuDevice(gpu);
% end

%% Deblurring demo
%#######%%%%% read sampling %%%%
% line = 43
% [mask] = strucrand(256,256,1,line);
for i=[1,11,18,34,38]
    for j = 2:2
        switch j
            case 1
                params.sigma_net = 3;
                load('../data/MWCNN_GDSigma3_3D_400/MWCNN_GDSigma3_3D_400-epoch-45');  net1 = net;
            case 2
                params.sigma_net1 = 8;
                load('../data/MWCNN_GDSigma8_3D_400/MWCNN_GDSigma8_3D_400-epoch-40');  net1 = net;
                params.sigma_net2 = 10;
                load('../data/MWCNN_GDSigma10_3D_400/MWCNN_GDSigma10_3D_400-epoch-45');  net2 = net;
            case 3
                params.sigma_net = 10;
                load('../data/MWCNN_GDSigma10_3D_400/MWCNN_GDSigma10_3D_400-epoch-45');  net1 = net;
        end
        load 4_fold_cart_320; %%mask
        figure(356); imshow(fftshift(mask),[]);
        n = size(mask,2);
        fprintf(1, 'n=%d, k=%d, Unsamped=%f\n', n, sum(sum(mask)),1-sum(sum(mask))/n/n);
        Img=load(['../fastMRIdata_50/knee' num2str(i,'%02d') '.mat']);Img = Img.Img;
        Img = Img/max(abs(Img(:)));
        % gt = Img;
        gt = ifft2(ifftshift(fft2(Img)));
        gt = gt*255;
        figure(334);imshow(abs(gt),[]);
        
        sigma_d = 0 * 255;
        noise = randn(size(gt));
        degraded = mask.*((fft2(gt)) + noise * sigma_d + (0+1i)*noise * sigma_d);%
        Im = ifft2(degraded);
        figure(335);imshow(abs(Im),[]);
        
        % run DAEP
        params.num_iter = 300;
        params.gt = gt;     
        %net1
        net1 = dagnn.DagNN.loadobj(net1) ;
        net1.removeLayer('objective') ;
        out_idx = net1.getVarIndex('prediction') ;
        net1.vars(net1.getVarIndex('prediction')).precious = 1 ;
        net1.mode = 'test';
        if gpu
            net1.move('gpu');
        end
        
        %net2
        net2 = dagnn.DagNN.loadobj(net2) ;
        net2.removeLayer('objective') ;
        out_idx = net2.getVarIndex('prediction') ;
        net2.vars(net2.getVarIndex('prediction')).precious = 1 ;
        net2.mode = 'test';
        if gpu
            net2.move('gpu');
        end
        
        params.out_idx = out_idx;  params.gpu = gpu;
        [map_deblurs,psnrs,ssims,hfens] = Complex_DMSPMRIRec_2sigma_3D(gt,Im, degraded, mask, sigma_d, params, net1, net2);
        [psnr4, ssim4, fsim4, ergas4, sam4] = MSIQA(abs(gt), abs(map_deblur));
        hfen = norm(imfilter(abs(map_deblur/255),fspecial('log',15,1.5)) - imfilter(abs(gt/255),fspecial('log',15,1.5)),'fro');
         
        figure(666);
        subplot(2,3,[4,5,6]);imshow([abs(Im-gt)/255,abs(map_deblur-gt)/255],[]); title('Recon-error');colormap(jet);colorbar;
        subplot(2,3,1);imshow(abs(gt)/255); title('Ground-truth');colormap(gray);
        subplot(2,3,2);imshow(abs(Im)/255); title('Zero-filled');colormap(gray);
        subplot(2,3,3);imshow(abs(map_deblur)/255); title('Net-recon');colormap(gray);
        figure(667);imshow([real(gt)/255,imag(gt)/255,abs(gt)/255],[]);
        figure(668);imshow([abs(Im-gt)/255,abs(map_deblur-gt)/255],[]); colormap(jet);colorbar;
        
        result(i).name = strcat('test_data_',num2str(i,'%02d'));
        result(i).map_deblur = map_deblurs;
        result(i).psnr = psnrs;
        result(i).ssim = ssims;
        result(i).hfen = hfens;
        save(['fold4_new/result','_test_data_',num2str(i,'%02d') ],'result');
    end
%     ii = ii+1;
end

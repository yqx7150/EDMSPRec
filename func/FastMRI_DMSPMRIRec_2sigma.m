function [map,resultimax] = FastMRI_DMSPMRIRec_2sigma(gt,Im, partialdata, mask, params, net1, net2)

if ~any(strcmp('num_iter',fieldnames(params)))
    params.num_iter = 300;
end

if ~any(strcmp('mu',fieldnames(params)))
    params.mu = .9;
end

if ~any(strcmp('alpha',fieldnames(params)))
    params.alpha = .1;
end

disp(params)

pad = [0, 0];
map = padarray(Im, pad, 'replicate', 'both');

step = zeros(size(map));

if any(strcmp('gt',fieldnames(params)))
    psnr = computePSNR(abs(params.gt), abs(map), pad);
    disp(['Initialized with PSNR: ' num2str(psnr)]);
end
resulti = [];
for iter = 1:params.num_iter
    if any(strcmp('gt',fieldnames(params)))
        disp(['Running iteration: ' num2str(iter)]);
        tic();
    end
    
    prior_err_sum = zeros(size(map));
    repeat_num = 3;  %1;
    for iiii = 1:repeat_num
        map_all = repmat(map,[1,1,3]);
        
        % compute prior gradient 1
        input = real(map_all(:,:,[3,2,1])); % Switch channels for caffe
        noise = randn(size(input)) * params.sigma_net;
        rec = Processing_Im_w(single(input+noise)/255, net1, params.gpu, params.out_idx);
        rec = double(rec)*255;
        figure(22);imshow([double(input(:,:,1)),double(rec(:,:,1))],[])
        prior_err = input - rec;
        prior_err1 = mean(prior_err,3);
        
        % compute prior gradient 2
        input = imag(map_all(:,:,[3,2,1])); % Switch channels for caffe
        noise = randn(size(input)) * params.sigma_net;
        rec = Processing_Im_w(single(input+noise)/255, net2, params.gpu, params.out_idx);
        rec = double(rec)*255;
        prior_err = input - rec;
        prior_err2 = mean(prior_err,3);
        
        prior_err_sum = prior_err_sum + prior_err1+sqrt(-1)*prior_err2;
    end
    
    for iiii = 1:repeat_num
        map_all = repmat(map,[1,1,3]);
        
        % compute prior gradient 1
        input = real(map_all(:,:,[3,2,1])); % Switch channels for caffe
        noise = randn(size(input)) * params.sigma_net2;
        rec = Processing_Im_w(single(input+noise)/255, net1, params.gpu, params.out_idx);
        rec = double(rec)*255;
        prior_err = input - rec;
        prior_err1 = mean(prior_err,3);
        
        % compute prior gradient 2
        input = imag(map_all(:,:,[3,2,1])); % Switch channels for caffe
        noise = randn(size(input)) * params.sigma_net2;
        rec = Processing_Im_w(single(input+noise)/255, net2, params.gpu, params.out_idx);
        rec = double(rec)*255;
        prior_err = input - rec;
        prior_err2 = mean(prior_err,3);
        
        prior_err_sum = prior_err_sum + prior_err1+sqrt(-1)*prior_err2;
    end
    
    prior_err = prior_err_sum/repeat_num/2;
    
    % update
    step = params.mu * step - params.alpha * prior_err;
    map = map + step;
    
    temp_FFT = fft2(map);
    temp_FFT(mask==1) = partialdata(mask==1);
    map = ifft2(temp_FFT);
    
    %     map = min(255,max(0,map));
    if mod(iter,30)==0, figure(200+iter);imshow([abs(map)],[]);end
    
    if any(strcmp('gt',fieldnames(params)))
        %psnr = computePSNR(abs(params.gt), abs(map), pad);
        [psnr, ssim, fsim, ergas, sam] = MSIQA(abs(params.gt), abs(map));
        hfen = norm(imfilter(abs(map/255),fspecial('log',15,1.5)) - imfilter(abs(gt/255),fspecial('log',15,1.5)),'fro');
        disp(['PSNR is: ' num2str(psnr) ',','SSIM is: ' num2str(ssim) ',', 'HFEN is: ' num2str(hfen) ',', 'iteration finished in ' num2str(toc()) ' seconds']);
    end
    resulti = [resulti;psnr, ssim, hfen];
end
[~,index] = max(resulti(:,1));
resultimax = resulti(index,:);

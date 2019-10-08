gt = double(imread('image/baboon.tif'))/255;
filt=kernels{8}
pad = floor(size(filt)/2);
gt_extend = padarray(gt, pad, 'replicate', 'both');
degraded = convn(gt_extend, rot90(filt,2), 'valid');

res_center = res(pad(1)+1:end-pad(1),pad(2)+1:end-pad(2),:);

    psnr = computePSNR(params.gt, res_center, pad);
    disp(['Initialized with PSNR: ' num2str(psnr)]);
    
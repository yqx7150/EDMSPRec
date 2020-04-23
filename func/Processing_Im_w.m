% function img_HR = SR_LapSRN(img_LR, net, opts)
function output = Processing_Im_w(input, net, gpu, out_idx)
% -------------------------------------------------------------------------
%   Description:
%       function to apply LapSRN
%
%   Input:
%       - inputb: noisy image
%       - net   : model
%       - gpu  :
%       - out_idx
%   Output:
%       - img_HR: high-resolution image
%
%   Citation: 
%       Deep Laplacian Pyramid Networks for Fast and Accurate Super-Resolution
%       Wei-Sheng Lai, Jia-Bin Huang, Narendra Ahuja, and Ming-Hsuan Yang
%       IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2017
%
%   Contact:
%       Wei-Sheng Lai
%       wlai24@ucmerced.edu
%       University of California, Merced
% -------------------------------------------------------------------------

    %% setup
%     net.mode = 'test' ;
%     output_var = 'level1_output';
%     output_index = net.getVarIndex(output_var);
%     net.vars(output_index).precious = 1;
%     
%     % RGB to YUV
%     if( size(img_LR, 3) > 1 )
%         img_LR = rgb2ycbcr(img_LR);
%     end
%     
%     % extract Y
%     y = single(img_LR(:, :, 1));
%     
     if(gpu)
         input = gpuArray(input);
     end
%     
%     % bicubic upsample UV
%     img_HR = imresize(img_LR, opts.scale);
    

    % forward
    inputs = {'input', input};
    net.eval(inputs);
    output = gather(net.vars(out_idx).value);
        
%     % resize if size does not match the output image
%     if( size(y, 1) ~= size(img_HR, 1) )
%         y = imresize(y, [size(img_HR, 1), size(img_HR, 2)]);
%     end
    
%     img_HR(:, :, 1) = double(y);
        
    % YUV to RGB
%     if( size(img_HR, 3) > 1 )
%         img_HR = ycbcr2rgb(img_HR);
%     end
%         
    
end
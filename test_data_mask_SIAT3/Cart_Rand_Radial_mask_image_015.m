
% getd = @(p)path(path,p);% Add some directories to the path
% getd('../traindata_lsq\');

%% Three sampling patterns
%#######%%%%% radial sampling %%%%
load mask_radial_015; mask = mask_radial_015; 
mask = fftshift(fftshift(mask,1),2);
figure(351); imshow(fftshift(mask),[]);   
imwrite(fftshift(mask), ['mask_radial_015','.png']); 
%#######%%%%% Cart sampling %%%%
load mask_cart_085.mat;
mask = mask_cart_085;
mask = fftshift(fftshift(mask,1),2);
figure(352); imshow(fftshift(mask),[]); 
imwrite(fftshift(mask), ['mask_cart_085','.png']); 
%#######%%%%% random sampling %%%%
load mask_random015; mask = mask_random015;
figure(353); imshow(fftshift(mask),[]);  
imwrite(fftshift(mask), ['mask_random015','.png']); 

n = size(mask,2);
fprintf(1, 'n=%d, k=%d, Unsamped=%f\n', n, sum(sum(mask)),1-sum(sum(mask))/n/n); %

%% Three test images
load lsq28; Img = imrotate(Img, -90); Img(:,end-6:end) = []; Img(:,1:7) = [];
%load lsq68;  Img = imrotate(Img, 90); Img(:,end-6:end) = []; Img(:,1:7) = [];
%load lsq200;  Img = imrotate(Img, 90); Img(:,end-6:end) = []; Img(:,1:7) = [];
gt = 255*Img./max(abs(Img(:)));
figure(334);imshow(abs(gt),[]);
% imwrite(uint8(abs(gt)), ['lsq28','.png']); 


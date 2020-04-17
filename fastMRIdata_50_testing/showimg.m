
load('knee35.mat');
im_ori = double(Img);
im_ori = (im_ori - min(im_ori(:)))/(max(im_ori(:)) - min(im_ori(:)));
figure(222);imshow([real(im_ori),imag(im_ori),abs(im_ori)],[])
im_orifft = fft2(im_ori);
im_ori = ifft2(ifftshift(im_orifft));
figure(232);imshow([real(im_ori),imag(im_ori),abs(im_ori)],[])


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% load('knee11.mat');
% im_ori = double(Img);
% im_ori = (im_ori - min(im_ori(:)))/(max(im_ori(:)) - min(im_ori(:)));
% figure(222);imshow([real(im_ori),imag(im_ori),abs(im_ori)],[])
% im_orifft = fft2(im_ori);
% 
% %im_ori2 = ifft2(ifftshift(im_orifft)));
% im_ori2 = ifft2(ifftshift(im_orifft));
% figure(232);imshow([real(im_ori2),imag(im_ori2),abs(im_ori2)],[])
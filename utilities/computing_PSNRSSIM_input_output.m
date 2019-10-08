load inputs_label.mat;
figure(22);imshow([inputs_label{1}(:,:,1,1), inputs_label{2}(:,:,1,1)],[])
load('inputs.mat')
figure(21);imshow([inputs{1}(:,:,1,1)],[])
[PSNRCur, SSIMCur] = Cal_PSNRSSIM(im2uint8(inputs{1}(:,:,1,1)),im2uint8(inputs_label{2}(:,:,1,1)),0,0)
 [PSNRCur, SSIMCur] = Cal_PSNRSSIM(im2uint8(inputs_label{1}(:,:,1,1)),im2uint8(inputs_label{2}(:,:,1,1)),0,0)
 figure(23);imshow([inputs{1}(:,:,1,1), inputs_label{2}(:,:,1,1),inputs_label{1}(:,:,1,1)],[])

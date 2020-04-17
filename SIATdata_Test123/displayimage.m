load SIAT_Test1.mat; SIAT_Test1 = SIAT_Test1./max(abs(SIAT_Test1(:)));
load SIAT_Test2.mat; SIAT_Test2 = SIAT_Test2./max(abs(SIAT_Test2(:)));
load SIAT_Test3.mat; SIAT_Test3 = SIAT_Test3./max(abs(SIAT_Test3(:)));
figure(334);imshow([abs(SIAT_Test1),abs(SIAT_Test2),abs(SIAT_Test3)],[]);
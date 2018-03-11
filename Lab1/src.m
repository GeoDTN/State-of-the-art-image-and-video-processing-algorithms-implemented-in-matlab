%C:\Users\Michele\Desktop\Scuola\Anno_2012-2013\Primo_semestre\Multimedia
%Communication Services\Multimedia Information coding and description\Lab\Lab1\Lab1
clear all;
close all;

rgbTOYCbCr = [0.299,0.587,0.114,
                -0.169,-0.331,0.5,
                0.5,-0.419,-0.081];
YCbCrTOrgb = [1,0,1.4025,
                1,-0.344,-0.7142,
                1,1.773,0];
            
RGB = imread('.\monarch.tif');
image(RGB);figure(gcf);         %Visualizza immagine

% =========================================
%           R G B     Format
% =========================================

%Red component
R = RGB(:,:,1);
%figure, image(R), colormap([[0:1/255:1]', zeros(256,1), zeros(256,1)]), colorbar;

%Green Component
G = RGB(:,:,2);
%figure, image(G), colormap([zeros(256,1),[0:1/255:1]', zeros(256,1)]), colorbar;

%Blue component
B = RGB(:,:,3);
%figure, image(B), colormap([zeros(256,1), zeros(256,1), [0:1/255:1]']), colorbar;

% =========================================
%           Y Cb Cr     Format
% =========================================

YCBCR = fromRGBtoYCBCR(RGB,rgbTOYCbCr);
Y = YCBCR(:,:,1);
Cb = YCBCR(:,:,2);
Cr = YCBCR(:,:,3);

YCBCR_toVisualize = fromYCBCRtoRGB (YCBCR, YCbCrTOrgb);
figure, image(YCBCR_toVisualize);

%Visualizzo solo Y
only_Y = YCBCR;
only_Y(:,:,1) = Y;
only_Y(:,:,2) = 128;
only_Y(:,:,3) = 128;
%only_Y_toVisualize = ycbcr2rgb (only_Y);
%figure, image(only_Y_toVisualize);

%Visualizzo solo Cb
only_Cb = YCBCR;
only_Cb(:,:,1) = 128;
only_Cb(:,:,2) = Cb;
only_Cb(:,:,3) = 128;
%only_Cb_toVisualize = ycbcr2rgb (only_Cb);
%figure, image(only_Cb_toVisualize);

%Visualizzo solo Cr
only_Cr = YCBCR;
only_Cr(:,:,1) = 128;
only_Cr(:,:,2) = 128;
only_Cr(:,:,3) = Cr;
%only_Cr_toVisualize = ycbcr2rgb (only_Cr);
%figure, image(only_Cr_toVisualize);

% ==================================================
%           Y Cb Cr    subsampling Format
% ==================================================

%Bisogna mediare

% ___________ 4_2_2 ___________ 

Y_4_2_2 (:,:) = Y;
CB_4_2_2 (:,:) = Cb(:,1:2:end);
CR_4_2_2 (:,:) = Cr(:,1:2:end);

%Salvo tutte le componenti
file_Y_4_2_2_save = fopen ('./Y_4_2_2.yuv', 'w');
fwrite(file_Y_4_2_2_save, Y_4_2_2, 'uint8');
file_Cb_4_2_2_save = fopen ('./CB_4_2_2.yuv', 'w');
fwrite(file_Cb_4_2_2_save, CB_4_2_2, 'uint8');
file_Cr_4_2_2_save = fopen ('./CR_4_2_2.yuv', 'w');
fwrite(file_Cr_4_2_2_save, CR_4_2_2, 'uint8');

fclose('all');

%Carico le componenti

file_Y_4_2_2_load = fopen ('./Y_4_2_2.yuv', 'r');
file_Cb_4_2_2_load = fopen ('./CB_4_2_2.yuv', 'r');
file_Cr_4_2_2_load = fopen ('./CR_4_2_2.yuv', 'r');
size_YCBCR = size(YCBCR);
Y_4_2_2_load = fread(file_Y_4_2_2_load, [size_YCBCR(1),size_YCBCR(2)], 'uint8');
CB_4_2_2_load = fread(file_Cb_4_2_2_load, [size_YCBCR(1),size_YCBCR(2)/2], 'uint8');
CR_4_2_2_load = fread(file_Cr_4_2_2_load, [size_YCBCR(1),size_YCBCR(2)/2], 'uint8');

YCBCR_4_2_2 = YCBCR;
YCBCR_4_2_2 (:,:,1) = Y_4_2_2_load;
YCBCR_4_2_2 (:,1:2:end,2) = CB_4_2_2_load;
YCBCR_4_2_2 (:,(1:2:end)+1,2) = CB_4_2_2_load;
YCBCR_4_2_2 (:,1:2:end,3) = CR_4_2_2_load;
YCBCR_4_2_2 (:,(1:2:end)+1,3) = CR_4_2_2_load;

%YCBCR_4_2_2_toVisualize = ycbcr2rgb (YCBCR_4_2_2);
%figure, image(YCBCR_4_2_2_toVisualize);

fclose('all');

% ___________ 4_2_0 ___________ 

Y_4_2_0 (:,:) = Y;
CB_4_2_0 (:,:) = Cb(1:2:end,1:2:end);
CR_4_2_0 (:,:) = Cr(1:2:end,1:2:end);

%Salvo tutte le componenti
file_Y_4_2_0_save = fopen ('./Y_4_2_0.yuv', 'w');
fwrite(file_Y_4_2_0_save, Y_4_2_0, 'uint8');
file_Cb_4_2_0_save = fopen ('./CB_4_2_0.yuv', 'w');
fwrite(file_Cb_4_2_0_save, CB_4_2_0, 'uint8');
file_Cr_4_2_0_save = fopen ('./CR_4_2_0.yuv', 'w');
fwrite(file_Cr_4_2_0_save, CR_4_2_0, 'uint8');

fclose('all');

%Carico le componenti

file_Y_4_2_0_load = fopen ('./Y_4_2_0.yuv', 'r');
file_Cb_4_2_0_load = fopen ('./CB_4_2_0.yuv', 'r');
file_Cr_4_2_0_load = fopen ('./CR_4_2_0.yuv', 'r');

Y_4_2_0_load = fread(file_Y_4_2_0_load, [size_YCBCR(1),size_YCBCR(2)], 'uint8');
CB_4_2_0_load = fread(file_Cb_4_2_0_load, [size_YCBCR(1)/2,size_YCBCR(2)/2], 'uint8');
CR_4_2_0_load = fread(file_Cr_4_2_0_load, [size_YCBCR(1)/2,size_YCBCR(2)/2], 'uint8');

YCBCR_4_2_0 = YCBCR;
YCBCR_4_2_0 (:,:,1) = Y_4_2_0_load;
YCBCR_4_2_0 (1:2:end,1:2:end,2) = CB_4_2_0_load;
YCBCR_4_2_0 ((1:2:end)+1,(1:2:end)+1,2) = CB_4_2_0_load;
YCBCR_4_2_0 (1:2:end,1:2:end,3) = CR_4_2_0_load;
YCBCR_4_2_0 ((1:2:end)+1,(1:2:end)+1,3) = CR_4_2_0_load;

%YCBCR_4_2_0_toVisualize = ycbcr2rgb (YCBCR_4_2_0);
%figure, image(YCBCR_4_2_0_toVisualize);

fclose('all');


G = fspecial('gaussian',[5 5],2);
Ig = imfilter(YCBCR,G,'same');

YCBCR_filter_toVisualize = ycbcr2rgb (Ig);
figure, title('ooop'), image(YCBCR_filter_toVisualize);


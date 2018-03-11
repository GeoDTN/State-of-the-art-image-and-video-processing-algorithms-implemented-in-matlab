% 30/10/2012 - Lab. experience n.5

clear all;close all;


rgbTOYCbCr = [0.299,0.587,0.114,
                -0.169,-0.331,0.5,
                0.5,-0.419,-0.081];
YCbCrTOrgb = [1,0,1.4025,
                1,-0.344,-0.7142,
                1,1.773,0];

% =========================================================
%           Punto 1 - Contrast Sensitivity Function
%              CSF(x,y)=A*y*[sin(2*pi*f_x*x)+1]
% =========================================================

[X,Y]=ndgrid(0:0.01:5);
x = X(:,1)';
y = Y(1,:);

A=logspace(0,1,length(x));             %y = linspace(a,b,n) generates a row vector y of n points linearly spaced between and including a and b.

frequenza=logspace(-1,0.5,length(x));      %logspace(a,b,n) generates n points between decades 10^a and 10^b.

y_new=y.*A;
frequenza_new=frequenza.*x;

I=y_new'*sin(2.*pi.*frequenza_new)+1;
%figure,imshow(I,[]);                              %If you use an empty
%matrix ([]) for [low high], imshow uses [min(I(:)) max(I(:))]; that is, the minimum value in I is displayed as black, and the maximum value is displayed as white.

I_1=((I+50)/norm(I+50))*255;                %norm
figure,imshow(I_1);

%Create similar images to check your contrast sensitivity to red, green and blue components.

[Altezza,Larghezza]=size(I_1);
RGB=zeros(Altezza,Larghezza,3);

%ROSSO
R=I_1; G=R; G(:,:)=0; B=R; B(:,:)=0;
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
figure,imshow(RGB);

%VERDE
G=I_1; R=G; R(:,:)=0; B=R; B(:,:)=0;
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
figure,imshow(RGB);

%BLU
B=I_1; G=B; G(:,:)=0; R=G; R(:,:)=0;
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
figure,imshow(RGB);

% Repear the experiment with the Cb e Cr components.

% RGB(:,:,:)=0;
% YCBCR = fromRGBtoYCBCR(RGB,rgbTOYCbCr);

%Cb
% Cb=I; Y=Cb; Y(:,:)=128; Cr=Cb; Cr(:,:)=128;
% YCBCR(:,:,1)=Y;
% YCBCR(:,:,2)=Cb;
% YCBCR(:,:,3)=Cr;
% YCBCR_toVisualize = fromYCBCRtoRGB (YCBCR, YCbCrTOrgb);
% figure, imshow(YCBCR_toVisualize,[]);
% 
% %Cr
% Y=128; Cb=128; Cr=I_1;
% YCBCR(:,:,1)=Y;
% YCBCR(:,:,2)=Cb;
% YCBCR(:,:,3)=Cr;
% YCBCR_toVisualize = fromYCBCRtoRGB (YCBCR, YCbCrTOrgb);
% figure, imshow(YCBCR_toVisualize,[]);

pause;  close all;

%% =========================================================
%           Punto 2 - Spatio-Temporal sensitivity
% =========================================================

R=I_1;G=I_1;B=I_1;
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
figure,imshow(RGB);

video = im2frame(RGB);
movie(video);



pause;
close all;






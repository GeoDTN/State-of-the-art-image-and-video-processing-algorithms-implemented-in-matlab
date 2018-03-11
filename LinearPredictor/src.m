% 30/10/2012 - Lab. experience n.5

clear all;close all;

I = imread('cameraman.tif');
%figure,imshow(I),title('Input image')

Cor = corr_2D(I);

[alfa,pe] = LinearPredictor(I);

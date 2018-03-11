% 22/10/2013 - Lab. experience n.4

clear all;close all;

% ==============================================
%           point 1 - Image Sampling
% ==============================================
[U,V]=ndgrid(-15:0.05:15);
u = U(:,1)';                      
v = V(1,:);
[X,Y]=ndgrid(-6:0.05:6);
x = X(:,1)';
y = Y(1,:);

syntheticImageOriginal = 255*rect4(X/2).*rect4(Y/6);
syntheticImage = syntheticImageOriginal;
syntheticImage = uint8(syntheticImage);
figure, imshow(syntheticImage);
syntheticImage = double(syntheticImage);
%%
e = waitforbuttonpress ;
fftA=fft2(syntheticImage);
figure, imshow(fftA);
f = waitforbuttonpress ;
figure,imagesc(abs(fftshift(fftA)));
imagesc(log(abs(fftshift(fftA))));
%
for i=0:(size(X/2)-1);j=0:(size(Y/6)-1)
    syntheticImage(X,Y)=syntheticImage(X-4*i,Y-4*j);
end
fftb=fft2(syntheticImage);
figure, imshow(fftb);
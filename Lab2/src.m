% LAB 2
% For length N input vector x, the DFT is a length N vector X, with elements
%                     N
%       X(k) =       sum  x(n)*exp(-j*2*pi*(k-1)*(n-1)/N), 1 <= k <= N.
%                    n=1
% The inverse DFT (computed by IFFT) is given by
%                     N
%       x(n) = (1/N) sum  X(k)*exp( j*2*pi*(k-1)*(n-1)/N), 1 <= n <= N.
%                    k=1
% fourier(f, x, y);

clear all;close all;

% ==============================================
%           Punto 1A - Trasformata 1D
% ==============================================

Fs = 20;                              %Sampling frequency
t = 0:(1/Fs):10;
f = -10:0.1:+10;                      %f Hz

%x_t = square(2*pi*t*5);              %Vari segnali
%x_t = rectpuls(t,10);
x_t = sin(2*pi*t*5);
X_f = MCS_FT(x_t,t,f);

figure,plot(t,x_t);
figure,plot(f,abs(X_f));
pause; close all;

% ==============================================
%           Punto 2 - Trasformata 2D
% ==============================================

[U,V]=ndgrid(-4:0.05:4 , -4:0.05:4);
u = U(:,1)';                      
v = V(1,:);
[X,Y]=ndgrid(-6:0.05:6);
x = X(:,1)';
y = Y(1,:);


% ---- s1(x, y) = rect(x)rect(y) ---- 

s1 = rect(X).*rect(Y);
figure, surf(X,Y,abs(s1)),xlabel('x'),ylabel('y'),title('s1'),shading interp,axis([-6 6 -6 6 0 3]);

spettro_s1 = mcs_ft2(s1, u, v, x, y);
figure, surf(u,v,abs(spettro_s1)),xlabel('u'),ylabel('v'),title('Spettro s1');%shading interp;
pause;
% 
% % ---- s2(x, y) = rect(x/2)rect(y) ---- 
% 
% s2 = rect(X/2).*rect(Y);
% figure, surf(X,Y,abs(s2)),xlabel('x'),ylabel('y'),title('s2'),shading interp,axis([-6 6 -6 6 0 3]);
% 
% spettro_s2 = mcs_ft2(s2, u, v, x, y);
% figure, surf(u,v,abs(spettro_s2)),xlabel('u'),ylabel('v'),title('Spettro s2');%shading interp;
% pause;
% 
% % ---- s3(x, y) = rect(x/2)rect(y - x/4) ---- 
% 
% s3 = rect(X/2).*rect(Y-X/4);
% figure, surf(X,Y,abs(s3)),xlabel('x'),ylabel('y'),title('s3'),shading interp,axis([-6 6 -6 6 0 3]);
% 
% spettro_s3 = mcs_ft2(s3, u, v, x, y);
% figure, surf(u,v,abs(spettro_s3)),xlabel('u'),ylabel('v'),title('Spettro s3');%shading interp;
% pause;
% 
% % ---- s4(x, y) = sin(pi*x) ---- 
% 
% s4 = sin(pi*X);
% figure, surf(X,Y,abs(s4)),xlabel('x'),ylabel('y'),title('s4'),shading interp,axis([-6 6 -6 6 0 3]);
% 
% spettro_s4 = mcs_ft2(s4, u, v, x, y);
% figure, surf(u,v,abs(spettro_s4)),xlabel('u'),ylabel('v'),title('Spettro s4');shading interp;
% pause;
% 
% % ---- s5(x, y) = sin(pi*y) ---- 
% 
% s5 = sin(pi*Y);
% figure, surf(X,Y,abs(s5)),xlabel('x'),ylabel('y'),title('s5'),shading interp,axis([-6 6 -6 6 0 3]);
% 
% spettro_s5 = mcs_ft2(s5, u, v, x, y);
% figure, surf(u,v,abs(spettro_s5)),xlabel('u'),ylabel('v'),title('Spettro s5');shading interp;
% pause;
% 
% % ---- s6(x, y) = sin(pi*x-2*pi*y) ---- 
% 
% s6 = sin(pi*X-2*pi*Y);
% figure, surf(X,Y,abs(s6)),xlabel('x'),ylabel('y'),title('s6'),shading interp,axis([-6 6 -6 6 0 3]);
% 
% spettro_s6 = mcs_ft2(s6, u, v, x, y);
% figure, surf(u,v,abs(spettro_s6)),xlabel('u'),ylabel('v'),title('Spettro s6');shading interp;
% pause; close all;

% ==============================================
%           Punto 3 - Transforms of Image
% ==============================================

image_RGB = imread('.\rete.jpg');  %goldhill2

YCBCR = rgb2ycbcr(image_RGB);
solo_Y = YCBCR(:,:,1);

% image(image_RGB),title('Image'),figure(gcf);         %Visualizza immagine
% only_y = ycbcr;
% only_y(:,:,1) = y;
% only_y(:,:,2) = 128;
% only_y(:,:,3) = 128;
% only_y_tovisualize = ycbcr2rgb (only_y);
% figure, image(only_y_tovisualize);

solo_Y = double (solo_Y);


imageSize = size(solo_Y);

[new_U,new_V]=ndgrid(-6:0.05:6);
new_u = new_U(:,1)';                      
new_v = new_V(1,:);
[new_X,new_Y]=ndgrid(1:1:400 ,1:1:500 ); %[new_X,new_Y]=ndgrid((-imageSize(1)/2):1:(imageSize(1)/2) ,(-imageSize(2)/2):1:(imageSize(2)/2));
new_x = new_X(:,1)';
new_y = new_Y(1,:);



spettro_s8 = mcs_ft2(solo_Y, new_u, new_v, new_x, new_y);











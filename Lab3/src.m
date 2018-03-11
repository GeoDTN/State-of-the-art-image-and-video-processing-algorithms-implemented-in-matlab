% 16/10/2012 - Lab. experience n.3

clear all;close all;

% ==============================================
%           Punto 1 - 2D cylindric signals
% ==============================================

[U,V]=ndgrid(-4:0.05:4 , -4:0.05:4);
u = U(:,1)';                      
v = V(1,:);
[X,Y]=ndgrid(-6:0.05:6);
x = X(:,1)';
y = Y(1,:);

% ---- s1(x,y) = D*rect(x/D) , dove D=delta ---- 
D = 0:0.05:(1-0.1);
D = 1-D;

% for i = 1:length(D)
%     s1 = (1/D(i))*rect(X/D(i));
%     figure, surf(X,Y,abs(s1)),xlabel('x'),ylabel('y'),title('s1'),shading interp,axis([-6 6 -6 6 0 10]);
%     spettro_s1 = mcs_ft2(s1, u, v, x, y);
%     figure, surf(u,v,abs(spettro_s1)),xlabel('u'),ylabel('v'),title('Spettro s1');%shading interp;
%     pause;
%     close all;
% end
    
% ---- s2(x,y) = rect(cos(a)*X+sin(a)*Y) ---- 

a=0:pi/16:1*pi;

% for i = 1:length(a)
%     s2 = rect(cos(a(i))*X+sin(a(i))*Y);
%     figure, surf(X,Y,abs(s2)),xlabel('x'),ylabel('y'),title('s2'),shading interp,axis([-6 6 -6 6 0 1.1]);
%     spettro_s2 = mcs_ft2(s2, u, v, x, y);
%     figure, surf(u,v,abs(spettro_s2)),xlabel('u'),ylabel('v'),title('Spettro s2');%shading interp;
%     pause;
%     close all;
% end

% ---- s3(x,y) = exp(j*2*pi*(vettore_u*X+vettore_v*Y)) ---- 

vettore_u=0:pi/8:1*pi;
vettore_v=1*pi-vettore_u;

% for i = 1:length(vettore_u)
%     s3 = exp(j*2*pi*(vettore_u(i)*X+vettore_v(i)*Y));
%     %figure, surf(X,Y,abs(s3)),xlabel('x'),ylabel('y'),title('s3'),shading interp;%,axis([-6 6 -6 6 0 1]);
%     spettro_s3 = mcs_ft2(s3, u, v, x, y);
%     figure, surf(u,v,abs(spettro_s3)),xlabel('u'),ylabel('v'),title('Spettro s3');%shading interp;
%     pause;
%     close all;
% end

% ---- s4(x,y) = cos(2*pi*(vettore_u*X+vettore_v*Y)) ---- 

vettore_u=0:pi/8:1*pi;
vettore_v=1*pi-vettore_u;

% for i = 1:length(vettore_u)
%     s4 = cos(2*pi*(vettore_u(i)*X+vettore_v(i)*Y));
%     figure, surf(X,Y,abs(s4)),xlabel('x'),ylabel('y'),title('s4'),shading interp,axis([-6 6 -6 6 0 1]);
%     spettro_s4 = mcs_ft2(s4, u, v, x, y);
%     figure, surf(u,v,abs(spettro_s4)),xlabel('u'),ylabel('v'),title('Spettro s4');%shading interp;
%     pause;
%     close all;
% end

% ---- s5(x,y) = cos(2*pi*(vett_u_1*X+vett_v_1*Y))*cos(2*pi*(vett_u_2*X+vett_v_2*Y)) ---- 

vett_u_1=0:pi/16:1*pi;
vett_u_2=0:pi/16:1*pi;
vett_v_1=1*pi-vett_u_1;
vett_v_2=1*pi-vett_u_2;

% for i = 1:length(vett_u_1)
%     s5 = cos(2*pi*(vett_u_1(i)*X+vett_v_1(i)*Y)).*cos(2*pi*(vett_u_2(i)*X+vett_v_2(i)*Y));
%     figure, surf(X,Y,abs(s5)),xlabel('x'),ylabel('y'),title('s5'),shading interp;%,axis([-6 6 -6 6 0 1]);
%     spettro_s5 = mcs_ft2(s5, u, v, x, y);
%     figure, surf(u,v,abs(spettro_s5)),xlabel('u'),ylabel('v'),title('Spettro s5');%shading interp;
%     pause;
%     close all;
% end

% ---- s6(x,y) = exp(-pi*X^2)*cos(2*pi*(vettore_u*X+vettore_v*Y)) ---- 

vettore_u=0:pi/16:1*pi;
vettore_v=1*pi-vettore_u;

% for i = 1:length(vettore_u)
%     s6 = exp(-pi.*X.^2).*cos(2*pi*(vettore_u(i)*X+vettore_v(i)*Y));
%     figure, surf(X,Y,abs(s6)),xlabel('x'),ylabel('y'),title('s6'),shading interp,axis([-6 6 -6 6 0 1]);
%     spettro_s6 = mcs_ft2(s6, u, v, x, y);
%     figure, surf(u,v,abs(spettro_s6)),xlabel('u'),ylabel('v'),title('Spettro s6');%shading interp;
%     pause;
%     close all;
% end

% ==============================================
%           Punto 2 - 3D cylindric signals
% ==============================================

time=1:1:100;
frame = rect(X).*rect(Y);
video=zeros(length(X),length(Y),length(time));

for i = 1:length(time)
    video(:,:,i)=frame(:,:);
end
%figure, surf(X,Y,abs(video(:,:,100))),xlabel('x'),ylabel('y'),title('video - al primo istante'),shading interp,axis([-6 6 -6 6 0 1]);

spettro_video = fftn(video);
%figure, surf(X,Y,abs(spettro_video)),xlabel('u'),ylabel('v'),title('Spettro video');%shading interp;

spettro_video_primo = spettro_video(:,:,1);

figure, surf(X,Y,abs(spettro_video_primo)),xlabel('u'),ylabel('v'),title('Spettro video');%shading interp;















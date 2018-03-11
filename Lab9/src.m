% 11/12/2012 - Lab. experience n.9

clear all;close all;

I = imread('lena_gray.jpg');        %lena_gray    prova
[Height,Width,Depth] = size(I);

if Depth > 1
    I = double(rgb2gray(I));         
else
    I = double(I);
end
%I=I-sum(sum(I));

clear Depth Height Width;


h_L = [2^(1/2)/2,(2^(1/2)/2)];
h_H = [2^(1/2)/2,(-2^(1/2)/2)];
g_L = [2^(1/2)/2,(2^(1/2)/2)];
g_H = [-2^(1/2)/2,(2^(1/2)/2)];

%% Prove di sottocampionamento
% X = [2,1,5,3];
% %X = I(1,:);
% figure; subplot(2,3,1); stem(X), title('X');
% 
% X_L_f = conv(X,h_L);
% X_H_f = conv(X,h_H);
% 
% subplot(2,3,2); stem(X_L_f), title('X_f_L = conv(X,h_L)');
% subplot(2,3,5); stem(X_H_f), title('X_f_H = conv(X,h_H)');
% 
% X_L = X_L_f(2:2:end);
% X_H = X_H_f(2:2:end);
% 
% subplot(2,3,3); stem(X_L), title('X_L - Dec.');
% subplot(2,3,6); stem(X_H), title('X_H - Dec.');

%% Primo livello ANALISI
X = I;
[Height_X,Width_X] = size(X);
figure; subplot(2,3,1); imshow(X,[]), title('X');

% Filtraggio
for i_t=1:Height_X
    X_L_f(i_t,:) = conv(X(i_t,:),h_L);
end
for i_t=1:Height_X
    X_H_f(i_t,:) = conv(X(i_t,:),h_H);
end

subplot(2,3,2); imshow(X_L_f,[]), title('X_f_L - Filt.');
subplot(2,3,5); imshow(X_H_f,[]), title('X_f_H - Filt.');

% Decimazione
X_L = X_L_f(:,2:2:end);
X_H = X_H_f(:,2:2:end);

subplot(2,3,3); imshow(X_L,[]), title('X_L - Dec.');
subplot(2,3,6); imshow(X_H,[]), title('X_H - Dec.');

clear Width_X Height_X;

%% Secondo Livello ANALISI

[Height_X_L,Width_X_L] = size(X_L);

figure; 
subplot(4,3,1); imshow(X_L,[]), title('X_L');
subplot(4,3,7); imshow(X_H,[]), title('X_H');

% Filtraggio
for i_t=1:Width_X_L
    X_L_L_f(:,i_t) = conv(X_L(:,i_t),h_L);
    X_L_H_f(:,i_t) = conv(X_L(:,i_t),h_H);
end
for i_t=1:Width_X_L
    X_H_L_f(:,i_t) = conv(X_H(:,i_t),h_L);
    X_H_H_f(:,i_t) = conv(X_H(:,i_t),h_H);
end

subplot(4,3,2); imshow(X_L_L_f,[]), title('X_f_L_L');
subplot(4,3,5); imshow(X_L_H_f,[]), title('X_f_L_H');
subplot(4,3,8); imshow(X_H_L_f,[]), title('X_f_H_L');
subplot(4,3,11); imshow(X_H_H_f,[]), title('X_f_H_H');

% Decimazione
X_L_L = X_L_L_f(2:2:end,:);
X_L_H = X_L_H_f(2:2:end,:);
X_H_L = X_H_L_f(2:2:end,:);
X_H_H = X_H_H_f(2:2:end,:);

subplot(4,3,3); imshow(X_L_L,[]), title('X_L_L');
subplot(4,3,6); imshow(X_L_H,[]), title('X_L_H');
subplot(4,3,9); imshow(X_H_L,[]), title('X_H_L');
subplot(4,3,12); imshow(X_H_H,[]), title('X_H_H');

clear -regexp _t;
clear Width_X_L Height_X_L;

% %% Primo livello SINTESI
% 
% Y_L_L = X_L_L;
% Y_L_H = X_L_H;
% Y_H_L = X_H_L;
% Y_H_H = X_H_H;
% 
% [Height_Y_L_L,Width_Y_L_L] = size(Y_L_L);
% 
% figure;
% subplot(4,3,1); imshow(Y_L_L,[]), title('Y_L_L');
% subplot(4,3,4); imshow(Y_L_H,[]), title('Y_L_H');
% subplot(4,3,7); imshow(Y_H_L,[]), title('Y_H_L');
% subplot(4,3,10); imshow(Y_H_H,[]), title('Y_H_H');
% 
% % Up-sampling
% Y_L_L_Up = zeros(Height_Y_L_L,Width_Y_L_L*2);
% Y_L_L_Up(:,1:2:end) = Y_L_L;
% Y_L_H_Up = zeros(Height_Y_L_L,Width_Y_L_L*2);
% Y_L_H_Up(:,1:2:end) = Y_L_H;
% 
% Y_H_L_Up = zeros(Height_Y_L_L,Width_Y_L_L*2);
% Y_H_L_Up(:,1:2:end) = Y_H_L;
% Y_H_H_Up = zeros(Height_Y_L_L,Width_Y_L_L*2);
% Y_H_H_Up(:,1:2:end) = Y_H_H;
% 
% subplot(4,3,2); imshow(Y_L_L_Up,[]), title('Y_L_L_Up');
% subplot(4,3,5); imshow(Y_L_H_Up,[]), title('Y_L_H_Up');
% subplot(4,3,8); imshow(Y_H_L_Up,[]), title('Y_H_L_Up');
% subplot(4,3,11); imshow(Y_H_H_Up,[]), title('Y_H_H_Up');
% 
% % Filtraggio
% for i_t=1:Height_Y_L_L
%     Y_L_1(i_t,:) = conv(Y_L_L_Up(i_t,:),g_L);
%     Y_L_2(i_t,:) = conv(Y_L_H_Up(i_t,:),g_H);
% end
% for i_t=1:Height_Y_L_L
%     Y_H_1(i_t,:) = conv(Y_H_L_Up(i_t,:),g_L);
%     Y_H_2(i_t,:) = conv(Y_H_H_Up(i_t,:),g_H);
% end
% 
% subplot(4,3,3); imshow(Y_L_1,[]), title('Y_L_1');
% subplot(4,3,6); imshow(Y_L_2,[]), title('Y_L_2');
% subplot(4,3,9); imshow(Y_H_1,[]), title('Y_H_1');
% subplot(4,3,12); imshow(Y_H_2,[]), title('Y_H_2');
% 
% clear Height_Y_L_L Width_Y_L_L;
% clear -regexp _t;
% 
% %% Secondo livello SINTESI
% 
% % Unione
% Y_L_Up = Y_L_1 + Y_L_2;
% Y_H_Up = Y_H_1 + Y_H_2;
% 
% figure;
% subplot(2,3,1); imshow(Y_L_Up,[]), title('Y_L Up');
% subplot(2,3,4); imshow(Y_H_Up,[]), title('Y_H Up');
% 
% [Height_Y_L_Up,Width_Y_L_Up] = size(Y_L_Up);
% 
% % Up-sampling
% Y_L = zeros(Height_Y_L_Up*2,Width_Y_L_Up);
% Y_L(1:2:end,:) = Y_L_Up;
% Y_H = zeros(Height_Y_L_Up*2,Width_Y_L_Up);
% Y_H(1:2:end,:) = Y_H_Up;
% 
% subplot(2,3,2); imshow(Y_L,[]), title('Y_L - Up-sam');
% subplot(2,3,5); imshow(Y_H,[]), title('Y_H - Up-sam');
% 
% % Filtraggio
% for i_t=1:Width_Y_L_Up
%     Y_L_f(:,i_t) = conv(Y_L(:,i_t),g_L);
% end
% for i_t=1:Width_Y_L_Up
%     Y_H_f(:,i_t) = conv(Y_H(:,i_t),g_H);
% end
% 
% subplot(2,3,3); imshow(Y_L_f,[]), title('Y_L_f - Filtr.');
% subplot(2,3,6); imshow(Y_H_f,[]), title('Y_H_f - Filtr.');
% 
% clear Width_Y_L_Up Height_Y_L_Up;
% clear -regexp _t;
% 
% % Ricostruzione
% Y = Y_L_f + Y_H_f;
% 
% Y_final = uint8(Y(1:end-1,1:end-1));

%pause; close all;

%% Primo livello SINTESI

Y_L_L = X_L_L;
Y_L_H = X_L_H;
Y_H_L = X_H_L;
Y_H_H = X_H_H;
% Y_L_H = zeros(size(X_L_H));
% Y_H_L = zeros(size(X_H_L));
% Y_H_H = zeros(size(X_H_H));
[Height_Y_L_L,Width_Y_L_L] = size(Y_L_L);

figure;
subplot(4,3,1); imshow(Y_L_L,[]), title('Y_L_L');
subplot(4,3,4); imshow(Y_L_H,[]), title('Y_L_H');
subplot(4,3,7); imshow(Y_H_L,[]), title('Y_H_L');
subplot(4,3,10); imshow(Y_H_H,[]), title('Y_H_H');

% Up-sampling
Y_L_L_Up = zeros(Height_Y_L_L*2,Width_Y_L_L);
Y_L_L_Up(1:2:end,:) = Y_L_L;
Y_L_H_Up = zeros(Height_Y_L_L*2,Width_Y_L_L);
Y_L_H_Up(1:2:end,:) = Y_L_H;

Y_H_L_Up = zeros(Height_Y_L_L*2,Width_Y_L_L);
Y_H_L_Up(1:2:end,:) = Y_H_L;
Y_H_H_Up = zeros(Height_Y_L_L*2,Width_Y_L_L);
Y_H_H_Up(1:2:end,:) = Y_H_H;

subplot(4,3,2); imshow(Y_L_L_Up,[]), title('Y_L_L_Up');
subplot(4,3,5); imshow(Y_L_H_Up,[]), title('Y_L_H_Up');
subplot(4,3,8); imshow(Y_H_L_Up,[]), title('Y_H_L_Up');
subplot(4,3,11); imshow(Y_H_H_Up,[]), title('Y_H_H_Up');

% Filtraggio
for i_t=1:Width_Y_L_L
    Y_L_1(:,i_t) = conv(Y_L_L_Up(:,i_t),g_L);
    Y_L_2(:,i_t) = conv(Y_L_H_Up(:,i_t),g_H);
end
for i_t=1:Width_Y_L_L
    Y_H_1(:,i_t) = conv(Y_H_L_Up(:,i_t),g_L);
    Y_H_2(:,i_t) = conv(Y_H_H_Up(:,i_t),g_H);
end

subplot(4,3,3); imshow(Y_L_1,[]), title('Y_L_1');
subplot(4,3,6); imshow(Y_L_2,[]), title('Y_L_2');
subplot(4,3,9); imshow(Y_H_1,[]), title('Y_H_1');
subplot(4,3,12); imshow(Y_H_2,[]), title('Y_H_2');

clear Height_Y_L_L Width_Y_L_L;
clear -regexp _t;

%% Secondo livello SINTESI

% Unione
Y_L_Up = Y_L_1 + Y_L_2;
Y_H_Up = Y_H_1 + Y_H_2;

figure;
subplot(2,3,1); imshow(Y_L_Up,[]), title('Y_L Up');
subplot(2,3,4); imshow(Y_H_Up,[]), title('Y_H Up');

[Height_Y_L_Up,Width_Y_L_Up] = size(Y_L_Up);

% Up-sampling
Y_L = zeros(Height_Y_L_Up,Width_Y_L_Up*2);
Y_L(:,1:2:end) = Y_L_Up;
Y_H = zeros(Height_Y_L_Up,Width_Y_L_Up*2);
Y_H(:,1:2:end) = Y_H_Up;

subplot(2,3,2); imshow(Y_L,[]), title('Y_L - Up-sam');
subplot(2,3,5); imshow(Y_H,[]), title('Y_H - Up-sam');

% Filtraggio
for i_t=1:Height_Y_L_Up
    Y_L_f(i_t,:) = conv(Y_L(i_t,:),g_L);
end
for i_t=1:Height_Y_L_Up
    Y_H_f(i_t,:) = conv(Y_H(i_t,:),g_H);
end

subplot(2,3,3); imshow(Y_L_f,[]), title('Y_L_f - Filtr.');
subplot(2,3,6); imshow(Y_H_f,[]), title('Y_H_f - Filtr.');

clear Width_Y_L_Up Height_Y_L_Up;
clear -regexp _t;

% Ricostruzione
Y = Y_L_f + Y_H_f;

Y_final = uint8(Y(1:end-1,1:end-1));










% 13/11/2012 - Lab. experience n.6

clear all;close all;

I = imread('prova.bmp');              %lena_gray.jpg
[Height,Width,Depth] = size(I);

if Depth > 1
    I = double(rgb2gray(I));         
else
    I = double(I);
end

%% Compute the coecients of the optimal predictor, compute the predicted image value in each pixel and display the so obtained image.

[alfa,pe,xhat] = LinearPredictor2D(I);
%pe(:,1) = I(:,1);                   %Mando la prima colonna intatta
%pe(1,:) = I(1,:);                   %Mando la prima riga intatta

[alfa_1D,pe_1D] = LinearPredictor(I);
%pe(:,1) = I(:,1);                   %Mando la prima colonna intatta

I = uint8(I);
figure;
subplot(1,3,1);imshow(I),title('Image');
subplot(1,3,2);imshow(pe_1D,[]),title('Error 1D');
subplot(1,3,3);imshow(pe,[]),title('Error 2D');
I = double(I);

pe_16bit = int16 (pe);

ErroreCommesso = (pe_16bit + int16 (xhat)) - int16(I);
totalError=sum(sum(abs(ErroreCommesso)));

%% Compute its (prediction error) power and compute and display its autocorrelation.

Cor_error = xcorr2(pe);
figure;surf(Cor_error,'DisplayName','Cor'),title('Autocorrelazione del errore'); %shading interp;

Power_error = Cor_error(Height,Width)/(Height*Width);
Cor_signal = xcorr2(double(I));
Power_signal = Cor_signal(Height,Width)/(Height*Width);

powerFactor = Power_error/Power_signal;

media_1D = sum(sum(abs(pe_1D)))/(Width*Height);
media_2D = sum(sum(abs(pe)))/(Width*Height);


%% Compute the prediction using the sub-optimal coecients a10=1/3; a01=1/3; a11=1/3. Compare the power and the autocorrelation of the prediction error with the ones of the previous point.

alfa_assegnato=[1/3,1/3,1/3];
pe_assegn = LinearPredictor2D_alfa(I,alfa_assegnato);

I = uint8(I);
figure;
subplot(1,2,1);imshow(I),title('Image');
subplot(1,2,2);imshow(pe_assegn,[]),title('Error con alfa assegnato');
I = double(I);

Cor_error_assegn = xcorr2(pe_assegn);
figure;surf(Cor_error_assegn,'DisplayName','Cor'),title('Autocorrelazione del errore con alfa assegnato'); %shading interp;

Power_error_assegn = Cor_error_assegn(Height,Width)/(Height*Width);
powerFactor_assegn = Power_error_assegn/Power_signal;

ratioErrorAssegnAndNormalError = Power_error_assegn/Power_error;



pause; close all;
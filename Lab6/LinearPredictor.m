function [alfa,pe] = LinearPredictor(I)

% [alfa,pe] = LinearPredict(I)
% I = input intensity image
% n = predictor order
% alfa = predictor coefficient vector
% pe = prediction error image of the same size as I
% Uses 1st-order optimal linear prediction to
% create the differential image


[Height,Width,Depth] = size(I);
if Depth > 1
    I1 = double(I(:,:,1));          %nel caso di tutta l'immagine prendo un solo canale
else
    I1 = double(I);
end

Mu = mean2(I1);                     % mean value of the image
I1 = I1 - Mu;                       % mean removed input image
R0 = mean2(I1 .* I1);
R1 = sum(sum(I1(:,2:Width).* I1(:,1:Width-1)))/(Height*(Width-1));
alfa = R1/R0;

% Implement the Linear Predictor
pe = zeros(Height,Width);           % array to store prediction errors
I1 = padarray(I1,[0 1],'symmetric','pre');
for r = 1:Height
    for c = 2:Width
        xhat = alfa*I1(r,c-1);      % predicted pixel
        pe(r,c) = I1(r,c) - xhat;   % differential pixel
    end
end

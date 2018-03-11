function pe = LinearPredictor2D_alfa(I,alfa)
%   X X
%   X O
% [alfa,pe] = LinearPredict 2D(I)
% I = input intensity image
% alfa = predictor coefficient vector -> ASSEGNATI
% pe = prediction error image of the same size as I
% Uses 2D linear prediction to create the differential image
% xhat(m,n) = alfa1(1)*x(m,n-1) + alfa(2)*x(m-1,n) + alfa(3)*x(m-1,n-1)


[Height,Width] = size(I);

pe = zeros(Height,Width);           %prediction errors

for r = 2:Height
    for c = 2:Width
        xhat = alfa(1)*I(r,c-1) + alfa(2)*I(r-1,c) + alfa(3)*I(r-1,c-1); %+ alfa(4)*I1(r-1,c+1);
        pe(r,c) = I(r,c) - xhat;
    end
end


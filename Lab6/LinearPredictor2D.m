function [alfa,pe,xhat] = LinearPredictor2D(I)
%   X X
%   X O
% [alfa,pe] = LinearPredict 2D(I)
% I = input intensity image
% alfa = predictor coefficient vector
% pe = prediction error image of the same size as I
% Uses 2D linear prediction to create the differential image
% xhat(m,n) = alfa1(1)*x(m,n-1) + alfa(2)*x(m-1,n) + alfa(3)*x(m-1,n-1)


[Height,Width] = size(I);

%Calcolo della autocorrelazione normalizzata
Cor = autoCorr2DNormalized(I);

%Calcolo dei coefficienti alfa
R_u = zeros(3,3);
R_u(1,1)=Cor(Height,Width);
R_u(1,2)=Cor(Height-1,Width+1);
R_u(1,3)=Cor(Height-1,Width);
R_u(2,1)=Cor(Height+1,Width-1);
R_u(2,2)=R_u(1,1);
R_u(2,3)=Cor(Height,Width-1);
R_u(3,1)=Cor(Height+1,Width);
R_u(3,2)=Cor(Height,Width+1);
R_u(3,3)=R_u(1,1);

r_u=zeros(3,1);
r_u(1)=Cor(Height,Width+1);
r_u(2)=Cor(Height+1,Width);
r_u(3)=Cor(Height+1,Width+1);

alfa=zeros(3,1);
alfa=R_u\r_u;


pe = zeros(Height,Width);           %prediction errors
xhat = pe;

for r = 2:Height
    for c = 2:Width
        xhat(r,c) = alfa(1)*I(r,c-1) + alfa(2)*I(r-1,c) + alfa(3)*I(r-1,c-1); %+ alfa(4)*I1(r-1,c+1);
        pe(r,c) = I(r,c) - xhat(r,c);
    end
end


function Cor = correlation(I,Row)
% pixel Correlation along a specified row (by svane)
% Correlations of sequences Correlation is an operation used in many
% applications in digital signal processing. It is a measure of the degree to
% which two sequences are similar. Given two real-valued sequences x(n) and
% y(n) of finite energy.
% Plots the image intensity profile and  correlation

[Height,Width,Depth] = size(I);

x = double(I(Row,:));
Col = size(I,2);
%
MaxN = Width;                         % number of correlation points to calculate
Cor = zeros(1,MaxN);                  % array to store correlation values
for k = 1:MaxN
    l = length(k:Col);
    Cor(k) = sum(x(k:Col) .* x(1:Col-k+1))/l;
end

MaxCor = max(Cor);
Cor = Cor/MaxCor;

% figure,subplot(2,1,1),plot(1:Col,x,'k','LineWidth',2)
% xlabel('Pixel number'), ylabel('Amplitude')
% legend(['Row' ' ' num2str(Row)],0)
% subplot(2,1,2),plot(0:MaxN-1,Cor,'k','LineWidth',2)
% xlabel('Pixel displacement'), ylabel('Normalized corr.')
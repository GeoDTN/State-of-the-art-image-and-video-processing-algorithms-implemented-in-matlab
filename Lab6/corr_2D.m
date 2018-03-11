function Cor = corr_2D(I)
% Image Auto-Correlation (by Svanera)

[Height,Width,Depth] = size(I);
if Depth > 1
    I = double(I(:,:,1));      %nel caso di tutta l'immagine prendo un solo canale
else
    I = double(I);
end

Cor(:,:)=zeros(Height,Width);
for i=1:size(I)
    Cor(:,i) = correlation(I,i);
end

%figure, surf(Cor),xlabel('Row'),ylabel('Column'),title('Auto-Correlation of Image - Normalized'),shading interp;


%NOTA: non si può interare la correlazione sulla sola riga. scorretto!
%=====================================================================
%                        Vector Quantization
%=====================================================================

% Carico lena ed estraggo Y
clc
clear all
close all

img = imread('lena.jpg');
img_ycbcr = rgb2ycbcr(img);

img_ycbcr(:,:,2)=128;
img_ycbcr(:,:,3)=128;

%Isolo luminanza
x = ycbcr2rgb(img_ycbcr);
x = double(x(:,:,1));

% figure
% imshow(uint8(img_Y));
% pause;

%=====================================================================
%                   Parametri
%=====================================================================
size_bk = 8;
dim = size(x);
larghezza = dim(2);
altezza = dim(1);

blocchi_hor = larghezza/size_bk;
blocchi_vert = altezza/size_bk;
tot_blocchi = blocchi_hor*blocchi_vert;

tot_passi = 8;   % numero iterazioni
init_seed = 256; % numero di elementi del dizionario desiderati
%=====================================================================
%           Creo il dizionario orrimo per l'immagine caricata
%=====================================================================

test_book = zeros(1,size_bk*size_bk);
for m=1:blocchi_vert
    for n=1:blocchi_hor
        test_book = cat(1,test_book,getBlock(x,m,n,size_bk));
    end
end
full_codebook = zeros(blocchi_hor*blocchi_vert,size_bk*size_bk);
full_codebook = test_book(2:end,:);



init_codebook = rand(init_seed,size_bk*size_bk)*256;
errore_tot = zeros(tot_passi,1);

for n_passo=1:tot_passi
    n_passo
    abbinamenti_regioni = zeros(tot_blocchi,1);

    % Calcolo distanze dei centroidi (che al primo passo sono casuali)
    % dai training vector (t_k)
    for k=1:tot_blocchi
        distanza_quadratica = zeros(init_seed,1);
        for m=1:init_seed
            distanza_quadratica(m,1) = sum((full_codebook(k,:)-init_codebook(m,:)).^2);
        end
        % Cerco il centroide più vicino ad ogni t_k
        abbinamenti_regioni(k,1) = min(find(distanza_quadratica==min(distanza_quadratica)));
    end
    % Riposizioni i centroidi (baricentri di ogni CLUSTER)
    for k=1:init_seed
        index = find(abbinamenti_regioni==k);
        if index ~= 0
            init_codebook(k,:) = sum(full_codebook(index,:))/length(index);
        end
    end

    % Stimo gli indici i_x che meglio approssimano le codeword
    % e stimo l'errore associato
    centroide_vicino = zeros(tot_blocchi,1);
    errore_blocco = zeros(tot_blocchi,1);
    for k=1:tot_blocchi
        distanza_quadratica = zeros(init_seed,1);
        for m=1:init_seed
            distanza_quadratica(m,1) = sum((full_codebook(k,:)-init_codebook(m,:)).^2);
        end
        % Cerco il centroide più vicino ad ogni t_k
        centroide_vicino(k,1) = min(find(distanza_quadratica==min(distanza_quadratica)));

        errore_blocco(k,1) = distanza_quadratica(centroide_vicino(k,1),1);
    end
    errore_tot(n_passo,1) = sum(errore_blocco);
end

% Plotto l'andamento dell'errore quadratico in funzione del numero
% delle iterazioni (tot_passi)
figure
x_axis = linspace(1,tot_passi,tot_passi);
plot(x_axis,errore_tot);
title('errore_tot')
xlabel('n iterazioni')
ylabel('errore tot(n)')


%=====================================================================
%                   Ricostruzione e confronto
%=====================================================================
x_ricostruita = zeros(altezza,larghezza);
k=1;
for m=1:blocchi_vert
    for n=1:blocchi_hor
        blocco_m_n = (reshape(init_codebook(centroide_vicino(k,1),:),size_bk,size_bk))';
        x_ricostruita(size_bk*(m-1)+1:size_bk*m, size_bk*(n-1)+1:size_bk*n)=blocco_m_n;
        k = k+1;
    end
end
figure
subplot(1,2,1)
imshow(uint8(x))
title('Originale')
subplot(1,2,2)
imshow(uint8(x_ricostruita))
title('Ricostruita')
pause




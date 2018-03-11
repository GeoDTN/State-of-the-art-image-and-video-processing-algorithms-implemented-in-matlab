% 04/12/2012 - Lab. experience n.8

clear all;close all;

I = imread('lena_gray.jpg');        %lena_gray    prova
[Height,Width,Depth] = size(I);

if Depth > 1
    I = double(rgb2gray(I));         
else
    I = double(I);
end
I=I-sum(sum(I));

clear Depth;

%% Estimate the correlation matrix of 8x8 blocks (expanded as vectors in 64 dimensions) and compute the Karhunen-Loeve transformation matrix

blockWidth = 8;
blockHeight = 8;

blocchi = zeros(blockHeight*blockWidth,(Width/blockWidth),(Height/blockHeight));
autoCorrel_t = 0;

for i_t=1:(Width/blockWidth)
    for j_t=1:(Height/blockHeight)
        temp_t=I((j_t-1)*blockHeight+1:(j_t)*blockHeight,(i_t-1)*blockWidth+1:(i_t)*blockWidth);        
        blocchi(:,i_t,j_t)=temp_t(:);      
        
        autoCorrel_t = autoCorrel_t + blocchi(:,i_t,j_t)*blocchi(:,i_t,j_t)';
        %figure, imshow(uint8(blocchi(:,i_t,j_t)));  pause;
    end
end

R_blocchi = (autoCorrel_t)/((Width/blockWidth)*(Height/blockHeight));

clear -regexp _t;

[V,D]=eig(R_blocchi);     %[V,D] = eig(A) produces matrices of eigenvalues (D) and eigenvectors (V) of matrix A, so that A*V = V*D.
T = flipud(V');              %Flip matrix up to down

%provauno = sum(sum(abs(T-R_blocchi)));
%prova = diag(D);

blocchi_Y = zeros(blockHeight,blockWidth,(Width/blockWidth),(Height/blockHeight));

for i_t=1:(Width/blockWidth)
    for j_t=1:(Height/blockHeight)
        temp_t = blocchi(:,i_t,j_t); 
        Y_t = T*(temp_t(:));        
        blocchi_Y(:,:,i_t,j_t) = (reshape(Y_t,blockHeight,blockWidth))';
    end
end

clear -regexp _t;

%% Invert the transforms by only using the most significant coefficients of each block.
   
blocchi_Y_ridotta = blocchi_Y;
%blocchi_Y_ridotta(5:8,5:8,:,:) = 0;

for i_t=1:(Width/blockWidth)
    for j_t=1:(Height/blockHeight)
        temp_t = blocchi_Y(:,:,i_t,j_t); 
        Y_t = (temp_t(:));
        Y_t(33:64) = 0;
        
%        blocchi_Y(:,:,i_t,j_t) = (reshape(Y_t,blockHeight,blockWidth))';
    end
end












%% Load the first 3 frames of a QCIF yuv 4:2:0 video

% 
% %% Compute the motion field on the second frame with the first one as a reference frame using a block matching with 16  16 blocks.
% 
% firstFrame(:,:) = imagesY(:,:,1);
% secondFrame(:,:) = imagesY(:,:,2);
% thirdFrame(:,:) = imagesY(:,:,3);
% 
% blockWidth = 16;
% blockHeight = 16;
% 
% blocchi = zeros(blockHeight,blockWidth,(width/blockWidth),(height/blockHeight));
% 
% for i_t=1:(width/blockWidth)
%     for j_t=1:(height/blockHeight)
%         temp_t=secondFrame((j_t-1)*blockHeight+1:(j_t)*blockHeight,(i_t-1)*blockWidth+1:(i_t)*blockWidth);
%         
%         %temp_t=firstFrame((j_t-1)*blockHeight+1:(j_t)*blockHeight,(i_t-1)*blockWidth+1:(i_t)*blockWidth);
%         
%         
%         blocchi(:,:,i_t,j_t)=temp_t;
% 
%         %figure;imshow(uint8(temp));
%         %pause;
%     end
% end
% 
% regioneRicerca = 48;
% firstFramePad=zeros(size(firstFrame)+regioneRicerca-blockHeight);
% firstFramePad(blockHeight+1:blockHeight+height,blockWidth+1:blockWidth+width)=firstFrame;
% 
% vettoriDiMoto = zeros((height/blockHeight),(width/blockWidth),2);
% %figure();
% for i_block=1:(width/blockWidth)
%     for j_block=1:(height/blockHeight)
%         bloccoCF = blocchi(:,:,i_block,j_block);
%         erroreMin = 0;
%         vettore = [0,0];
%        
%         for i_t=1:1:regioneRicerca-blockWidth+1
%             for j_t=1:1:regioneRicerca-blockHeight+1
%                 
%                 idx_height = j_t:j_t+blockHeight-1;
%                 idx_height = idx_height + (j_block-1)*blockHeight;
%                 idx_width = i_t:i_t+blockWidth-1;
%                 idx_width = idx_width + (i_block-1)*blockWidth;
%                 
%                 temp=firstFramePad(idx_height,idx_width);
%                 
%                 errore = sum(sum(abs(bloccoCF-temp)));
% 
%                 if(i_t==1&&j_t==1)
%                     erroreMin = errore;
%                 else
%                     if(errore<erroreMin)        %Controllo
%                         erroreMin = errore;
%                         vettore = [j_t - blockHeight-1,i_t - blockWidth-1];
%         
% %         subplot(1,2,1);imshow(uint8(bloccoCF)),title('Primo');
% %         subplot(1,2,2);imshow(uint8(temp)),title('temp');
% %         
% %                         
%                     end
%                 end
%             end
%         end
% %pause; 
%         vettoriDiMoto(j_block,i_block,:)=vettore;
% 
% %         subplot(1,2,1);imshow(uint8(bloccoCF)),title('Primo');
% %         indice_x = (regioneRicerca-blockHeight)/2+1+vettore(1);
% %         indice_x = indice_x + (j_block-1)*blockHeight;
% %         
% %         indice_y = (regioneRicerca-blockWidth)/2+1+vettore(2);
% %         indice_y = indice_y + (i_block-1)*blockWidth;
% %         
% %         temp=firstFramePad(indice_x:indice_x+blockHeight-1,indice_y:indice_y+blockWidth-1);
% %         subplot(1,2,2);imshow(uint8(temp)),title('tempFinito');
% %         pause;
%     end 
% end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %pause; close all;
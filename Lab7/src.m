% 27/11/2012 - Lab. experience n.7

clear all;close all;

%% Load the first 3 frames of a QCIF yuv 4:2:0 video

width = 176;
height = 144;

fileId_t = fopen('foreman.yuv', 'r');

idxFrame_t = [1,2,3];
nrFrame_t = length(idxFrame_t);

imagesY = zeros(height,width,nrFrame_t);

for f_t = 1:nrFrame_t
    
    % search fileId position
    sizeFrame_t = 1.5 * width * height;       % 4:2:0
    fseek(fileId_t, (idxFrame_t(f_t) - 1) * sizeFrame_t, 'bof'); %Beginning of file
    
    % read Y component
    buf_t = fread(fileId_t, width * height, 'uchar');
    imgY_t = reshape(buf_t, width, height).'; % reshape
    imagesY(:,:,f_t) = imgY_t(:,:);
    
end

fclose(fileId_t);

% Visualizza
for f_t = 1:nrFrame_t
    figure;imshow(uint8(imagesY(:,:,f_t)));
end
pause;
close all;

clear -regexp _t;

%% Compute the motion field on the second frame with the first one as a reference frame using a block matching with 16  16 blocks.

firstFrame(:,:) = imagesY(:,:,1);
secondFrame(:,:) = imagesY(:,:,2);
thirdFrame(:,:) = imagesY(:,:,3);

blockWidth = 16;
blockHeight = 16;

blocchi = zeros(blockHeight,blockWidth,(width/blockWidth),(height/blockHeight));

for i_t=1:(width/blockWidth)
    for j_t=1:(height/blockHeight)
        temp_t=secondFrame((j_t-1)*blockHeight+1:(j_t)*blockHeight,(i_t-1)*blockWidth+1:(i_t)*blockWidth);
        
        %temp_t=firstFrame((j_t-1)*blockHeight+1:(j_t)*blockHeight,(i_t-1)*blockWidth+1:(i_t)*blockWidth);
        
        
        blocchi(:,:,i_t,j_t)=temp_t;

        %figure;imshow(uint8(temp));
        %pause;
    end
end

regioneRicerca = 48;
firstFramePad=zeros(size(firstFrame)+regioneRicerca-blockHeight);
firstFramePad(blockHeight+1:blockHeight+height,blockWidth+1:blockWidth+width)=firstFrame;

vettoriDiMoto = zeros((height/blockHeight),(width/blockWidth),2);
%figure();
for i_block=1:(width/blockWidth)
    for j_block=1:(height/blockHeight)
        bloccoCF = blocchi(:,:,i_block,j_block);
        erroreMin = 0;
        vettore = [0,0];
       
        for i_t=1:1:regioneRicerca-blockWidth+1
            for j_t=1:1:regioneRicerca-blockHeight+1
                
                idx_height = j_t:j_t+blockHeight-1;
                idx_height = idx_height + (j_block-1)*blockHeight;
                idx_width = i_t:i_t+blockWidth-1;
                idx_width = idx_width + (i_block-1)*blockWidth;
                
                temp=firstFramePad(idx_height,idx_width);
                
                errore = sum(sum(abs(bloccoCF-temp)));

                if(i_t==1&&j_t==1)
                    erroreMin = errore;
                else
                    if(errore<erroreMin)        %Controllo
                        erroreMin = errore;
                        vettore = [j_t - blockHeight-1,i_t - blockWidth-1];
        
%         subplot(1,2,1);imshow(uint8(bloccoCF)),title('Primo');
%         subplot(1,2,2);imshow(uint8(temp)),title('temp');
%         
%                         
                    end
                end
            end
        end
%pause; 
        vettoriDiMoto(j_block,i_block,:)=vettore;

%         subplot(1,2,1);imshow(uint8(bloccoCF)),title('Primo');
%         indice_x = (regioneRicerca-blockHeight)/2+1+vettore(1);
%         indice_x = indice_x + (j_block-1)*blockHeight;
%         
%         indice_y = (regioneRicerca-blockWidth)/2+1+vettore(2);
%         indice_y = indice_y + (i_block-1)*blockWidth;
%         
%         temp=firstFramePad(indice_x:indice_x+blockHeight-1,indice_y:indice_y+blockWidth-1);
%         subplot(1,2,2);imshow(uint8(temp)),title('tempFinito');
%         pause;
    end 
end










%pause; close all;
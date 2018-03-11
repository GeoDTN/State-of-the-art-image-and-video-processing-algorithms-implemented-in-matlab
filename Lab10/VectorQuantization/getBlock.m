function [ blocco_in_linea ] = getBlock(img,m,n,size_block)

    blocco = zeros(size_block,size_block);
    blocco(:,:) = img(size_block*(m-1)+1:size_block*m, size_block*(n-1)+1:size_block*n);
    
    blocco_in_linea = zeros(1,size_block);
    blocco_in_linea = blocco(1,:);
    
    for k=2:size_block
        blocco_in_linea = cat(2,blocco_in_linea,blocco(k,:));
    end
    
end

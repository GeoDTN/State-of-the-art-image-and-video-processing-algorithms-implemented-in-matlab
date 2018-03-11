% LAB 2
% Trasformo prima le righe A*x
% trasformo poi il risultati le colonne (A*x)*B


function [S] = MCS_FT2 (s, u, v, x, y)

S1 = MCS_FT (s,x,u);

B = zeros(length(y),length(v));

for n=1:length(y)
    for k=1:length(v)
        B(n,k)=exp(-i*2*pi*y(n)*v(k));
    end
end

%S = zeros(1,length(v));
S = S1 * B;

return;


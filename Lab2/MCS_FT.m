% LAB 2
% For length N input vector x, the DFT is a length N vector X, with elements
%                     N
%       X(k) =       sum  x(n)*exp(-j*2*pi*(k-1)*(n-1)/N), 1 <= k <= N.
%                    n=1
% The inverse DFT (computed by IFFT) is given by
%                     N
%       x(n) = (1/N) sum  X(k)*exp( j*2*pi*(k-1)*(n-1)/N), 1 <= n <= N.
%                    k=1
% fourier(f, x, y);


function [X] = MCS_FT (x,t,f)

A = zeros(length(f),length(t));
for h=1:length(f)
    for k=1:length(t)
        A(h,k)=exp(-j*2*pi*f(h)*t(k));
    end
end

X = zeros(1,length(f));
X = A * x';

return;


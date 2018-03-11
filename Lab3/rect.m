function y = rettangolo(t)

y = zeros(size(t));
y(find(abs(t)< 1/2))= 1;

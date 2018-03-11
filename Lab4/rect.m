function y = rect(t)
% Rect by svane
y = zeros(size(t));
y(find(abs(t)< 1/2))= 1;

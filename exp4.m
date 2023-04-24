% Generate random numbers using randn in a 1xN vector
N = 10000000;
mean = 38;
sd = 1;
X = mean + randn(1, N)*sd;

a = min(X);
b = max(X);

% define approximate value of d
d = (b-a)/1000;

% generate vector h = [a, a+d, a+2d, ..., b]
h = a:d:b;

% count the values which lie in values of h vector, and find PDF
fX = hist(X, h)/(N*d);

% plot the PDF obtained above 
figure(1);
plot(h, fX);
title('Normal Distribution');
xlabel('X');
ylabel('PDF');
%axis([a-1, b+1, 0.1, 0.25]);
grid;

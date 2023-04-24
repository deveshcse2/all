% Generate random numbers using rand in a 1xN vector between 'a' and 'b'
N = 10000000;
a = 3;
b = 8;
X = a + rand(1, N)*(b-a);

% define approximate value of d
d = (b-a)/1000;

% generate vector h = [a, a+d, a+2d, ..., b]
h = a:d:b;

% count the values which lie in values of h vector, and find PDF
fX = hist(X, h)/(N*d);

% plot the PDF obtained above 
figure(1);
plot(h, fX);
title('Uniform Distribution');
xlabel('X');
ylabel('PDF');
axis([a-1, b+1, 0.1, 0.25]);
grid;
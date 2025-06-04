function coeffs = spline2a(x,y)
% Demonstration of quadratic spline interpolation using Scheme 1
% Example 8.2-8.3

k = length(x); % number of data points
n = 3*(k-1);    % number of equations/unknowns

A = zeros(n);
b = zeros(n,1);

% Create the RHS vector {b}
for i = 1:2*(k-1)
    if mod(i,2)==1
        b(i) = y((i+1)/2);    % if i is odd
    else
        b(i) = y(i/2+1);    % if i is even
    end
end

% Create the matrix of coefficients [A]
for i=1:k-1
    A(2*i-1,3*(i-1)+1) = 1;         % ai
    A(2*i-1,3*(i-1)+2) = x(i);      % bi
    A(2*i-1,3*(i-1)+3) = x(i)^2;    % ci

    A(2*i, 3*(i-1)+1) = 1;          % ai
    A(2*i,3*(i-1)+2) = x(i+1);      % bi
    A(2*i,3*(i-1)+3) = x(i+1)^2;    % ci    
end
for i=1:k-2
    A(2*(k-1)+i,3*(i-1)+1+1) = 1;           % bi
    A(2*(k-1)+i,3*(i-1)+1+4) = -1;          % ci
    A(2*(k-1)+i,3*(i-1)+1+2) = 2*x(i+1);    % b(i+1)
    A(2*(k-1)+i,3*(i-1)+1+5) = -2*x(i+1);   % c(i+1)
end
A(n,3)=2;

coeffs = A\b;

xplot = linspace(min(x),max(x));
yplot = zeros(1,length(xplot));
for i=1:length(xplot)
    for j = 2:k
        if xplot(i)<=x(j)
            yplot(i)=coeffs(3*(j-2)+1)+coeffs(3*(j-2)+2)*xplot(i)+coeffs(3*(j-2)+3)*xplot(i)^2;
            break
        end
    end
    
end
    
figure(1)
hold on
plot(xplot,yplot,'LineWidth',2)
plot(x,y,'ok','MarkerSize',7,'MarkerFaceColor','k')
xlabel('x')
ylabel('y')
title('Quadratic Spline Interpolation: Scheme 1')

fprintf('\n    Coeffs\n');
fprintf('%10.3f\n',coeffs);
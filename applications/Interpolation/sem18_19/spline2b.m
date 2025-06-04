function coeffs = spline2b(x,y)
% Demonstration of quadratic spline interpolation using Scheme 1
% Example 8.2-8.3

k = length(x); % number of data points
n = 3*(k-2);    % number of equations/unknowns

A = zeros(n);
b = zeros(n,1);

% Create a vector of the new interval end points
newx = zeros(k-1,1);
newx(1) = x(1);
newx(k-1) = x(k);
for i = 2:k-2
    newx(i) = (x(i)+x(i+1))/2;
end

% Create the RHS vector {b}
b(1:k)=y(1:k);

% Create the matrix of coefficients [A]
A(1,1:3)=[1 x(1) x(1)^2];
for i=2:k-1
    A(i,3*(i-2)+1) = 1;         % ai
    A(i,3*(i-2)+2) = x(i);      % bi
    A(i,3*(i-2)+3) = x(i)^2;    % ci
end
A(k,(3*k-8):(3*k-6))=[1 x(k) x(k)^2];

for i=1:k-3
    A(k+i,3*(i-1)+1) = 1;
    A(k+i,3*(i-1)+4) = -1;
    A(k+i,3*(i-1)+2) = newx(i+1);
    A(k+i,3*(i-1)+5) = -newx(i+1);
    A(k+i,3*(i-1)+3) = newx(i+1)^2;
    A(k+i,3*(i-1)+6) = -1*newx(i+1)^2;
    A(k+i+k-3,3*(i-1)+2) = 1;
    A(k+i+k-3,3*(i-1)+5) = -1;
    A(k+i+k-3,3*(i-1)+3) = 2*newx(i+1);
    A(k+i+k-3,3*(i-1)+6) = -2*newx(i+1);
end

coeffs = A\b;

xplot = linspace(min(x),max(x));
yplot = zeros(1,length(xplot));
for i=1:length(xplot)
    for j = 2:k
        if xplot(i)<=newx(j)
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
title('Quadratic Spline Interpolation: Scheme 2')

fprintf('\n    Coeffs\n');
fprintf('%10.3f\n',coeffs);
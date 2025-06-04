clear all
close all
clc

x = [-1 -0.8 -0.6 -0.4 -0.2 0 0.2 0.4 0.6 0.8 1];
y = [0.038 0.058 0.1 0.2 0.5 1 0.5 0.2 0.1 0.058 0.038];

coeffs = spline2b(x,y);

xplot = linspace(min(x),max(x));
yplot = 1./(1+25.*xplot.^2);

hold on
plot(xplot,yplot,'LineWidth',2)
grid on
legend('Quadratic Spline (Scheme 1)','Data Points','1/(1+25x^2)','Location','southoutside')

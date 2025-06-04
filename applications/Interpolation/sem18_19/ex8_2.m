clear all
close all
clc

x = [-1 -0.8 -0.6 -0.4];
y = [0.038 0.058 0.1 0.2];

coeffs = spline2a(x,y);
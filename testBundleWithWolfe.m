% Test Bundle with Wolfe


%Rules for parameters:
% 0 < threshold
% 0 < m1 < m2 < 1
% 0 < m3 < 1
% 0 < T
% 0 < gammI <= 0.5
% 0 < tauLow
% 0 < tauHigh
% 3 < maxBundlesize

clc
clear


m1 = 0.1;
m2 = 0.2;
m3 = 0.1;
epsilonLow = 1e-8;
eta = 1e-4;
maxBundleSize = 4;
maxSteps = 100;
debug = true;

parameters = [m1 m2 m3 epsilonLow eta maxBundleSize maxSteps debug];

x0 = [4 5]';

[xStar, Xs, asCounter, nsCounter ] = Bundle(@wolfe, x0, parameters);

PointX = Xs(1,:);
PointY = Xs(2,:);

[x,y] = meshgrid(-2:0.3:6,-5:0.3:5);
z = wolfe(x,y);

plot(PointX, PointY);
hold on;
contour(x,y,z,40);
hold off;
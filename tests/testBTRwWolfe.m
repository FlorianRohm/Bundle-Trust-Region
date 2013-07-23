% Test Bundle Trust Region with Wolfe
clc
clear

%Rules for parameters:
% 0 < threshold
% 0 < m1 < m2 < 1
% 0 < m3 < 1
% 0 < T
% 0 < gammI <= 0.5
% 0 < tauLow
% 0 < thresholdT
% 3 < maxBundlesize

m1 = 0.1;
m2 = 0.2;
m3 = 0.01;
eta = 1e-6;
T = 2;
gammaI = 0.5;
thresholdT = 0.3;
maxBundleSize = 10;

parameters = [m1 m2 m3 eta T gammaI thresholdT maxBundleSize];

x0 = [4 5]';

[xStar, Xs, advanceSteps, nullSteps] = BundleTrustRegion(@wolfe, x0, parameters);
disp (xStar - [-1;0]);

PointX = Xs(1,:);
PointY = Xs(2,:);

[x,y] = meshgrid(-2:0.3:6,-5:0.3:5);
z = wolfe(x,y);

plot(PointX, PointY);
hold on;
contour(x,y,z,40);
hold off;
clc
clear

global functionCalls;
global sgradCalls;

functionCalls =0;
sgradCalls = 0;


tr_m1 = 0.1;
tr_m2 = 0.2;
tr_m3 = 0.99;
tr_eta = 1e-4;
tr_T = 1; %max{ 0.1(fx1-fopt),1}
tr_gammaI = 0.5;
tr_thresholdT = 0.1;
tr_maxBundleSize = 10;

tr_parameters = [tr_m1 tr_m2 tr_m3 tr_eta tr_T tr_gammaI tr_thresholdT tr_maxBundleSize];

bundle_m1 = 0.1;
bundle_m2 = 0.2;
bundle_m3 = 0.1;
bundle_epsilonLow = 1e-8;
bundle_eta = 1e-4;
bundle_maxBundleSize = 4;
bundle_maxSteps = 100;
bundle_debug = true;

bundle_parameters = [bundle_m1 bundle_m2 bundle_m3 bundle_epsilonLow bundle_eta bundle_maxBundleSize bundle_maxSteps bundle_debug];

x0 = [4 5]';
%tr_tic = tic;
[tr_xStar, tr_Xs, tr_advanceSteps, tr_nullSteps] = BundleTrustRegion(@wolfe, x0, tr_parameters);
%toc(tr_tic);
TrustRegionFunctionCalls = functionCalls
TrustRegionSubgradientCalls = sgradCalls


functionCalls = 0;
sgradCalls = 0;


%bundle_tic = tic;
%[bundle_xStar, bundle_Xs, bundle_asCounter, bundle_nsCounter ] = Bundle(@wolfe, x0, bundle_parameters);
%toc(bundle_tic);


%BundleFunctionCalls = functionCalls
%BundleSubgradientCalls = sgradCalls

%Analysis
ErrorOfTrustRegion = tr_xStar - [-1;0]
%ErrorOfBundle = bundle_xStar - [-1;0]



%Plotting

tr_PointX = tr_Xs(1,:);
tr_PointY = tr_Xs(2,:);

%bundle_PointX = bundle_Xs(1,:);
%bundle_PointY = bundle_Xs(2,:);


[x,y] = meshgrid(-1.5:0.1:6,-5:0.1:5);
z = wolfe(x,y);

contour(x,y,z,30);
hold on;
plot(tr_PointX, tr_PointY, 'Color', 'green');
%plot(bundle_PointX, bundle_PointY, 'Color', 'red');
hold off;
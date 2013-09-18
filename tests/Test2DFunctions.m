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
tr_T = 3; %max{ 0.1(fx1-fopt),1}
tr_gammaI = 0.1;
tr_thresholdT = 0.1;
tr_maxBundleSize = 10;

tr_parameters = [tr_m1 tr_m2 tr_m3 tr_eta tr_T tr_gammaI tr_thresholdT tr_maxBundleSize];


Tester2D( @CB2, [1; -.1], [1.139; 0.8996], tr_parameters );
Tester2D( @wolfe, [4; 5], [-1; 0], tr_parameters );
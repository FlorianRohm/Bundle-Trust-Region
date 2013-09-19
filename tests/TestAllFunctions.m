clc
clear
close all;

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
tr_manualTk = 0.2; %0 for linesearch 

tr_parameters = [tr_m1 tr_m2 tr_m3 tr_eta tr_T tr_gammaI tr_thresholdT tr_maxBundleSize tr_manualTk];

%Ausgabe der Parameter
fprintf('Startparameter:\n');
fprintf('m1: %.2f\n', tr_m1);
fprintf('m2: %.2f\n', tr_m2);
fprintf('m3: %.2f\n', tr_m3);
fprintf('Abbruchschranke: %.1e\n', tr_eta);
fprintf('Maximale Bundlegröße: %d\n', tr_maxBundleSize)
fprintf('gamma_I: %.2f\n', tr_gammaI);
fprintf('Schwelle für T: %.2f\n', tr_thresholdT);
if tr_manualTk ==0
    fprintf('Bestimmung von erstem Trust Region Parameter über Linesearch\n\n');
else
    fprintf('Erster Trust Region Parameter: %.2f\n\n', tr_manualTk);
end


%---------------2D Section----------------
[meshX,meshY] = meshgrid(0:0.1:2.5,-1.5:0.2:2);
Tester2D( @CB2, [1; -.1], [1.139; 0.8996], tr_parameters, meshX, meshY );

[meshX,meshY] = meshgrid(-1.8:0.3:6,-5:0.3:5);
Tester2D( @wolfe, [4; 5], [-1; 0], tr_parameters, meshX, meshY  );

%------------Higher Dimensions------------
Tester( @RosenSuzuki, [0;0;0;0], [0;1;2;-1], tr_parameters);
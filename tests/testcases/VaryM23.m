clc
clear
close all;

baseParameters = Parameters;
baseParameters.eta = 1e-4;
baseParameters.bundleUpdate = 'largest error';
%set Up Bundle sizes
baseParameters.maxBundleSize = 15;

baseParameters.m1 = 0.1;
rangeOfM2 = linspace(0.001, 0.999 , 20);
rangeOfM3 = linspace(0.001,0.999,20);
% or: rangeOfM2(rangeOfM2 < baseParameters.m1) = [];

outputProperties = OutputProperties;
outputProperties.allFalse;

%Ausgabe der Parameter
fprintf('Startparameter:\n');

fprintf('m1: %.2f\n', baseParameters.m1);
fprintf('Werte für m2: %s\n', Vector2String(rangeOfM2, '%.3f'));
fprintf('Werte für m3: %s\n', Vector2String(rangeOfM3, '%.3f'));

fprintf('Abbruchschranke: %.1e\n', baseParameters.eta);
fprintf('Maximale Bundlegröße: %d\n', baseParameters.maxBundleSize);
fprintf('gamma_I: %.2f\n', baseParameters.gammaI);
fprintf('Schwelle für T: %.2f\n', baseParameters.thresholdT);
if baseParameters.manualTk ==0
    fprintf('Bestimmung von erstem Trust Region Parameter über Linesearch\n\n');
else
    fprintf('Erster Trust Region Parameter: %.2f\n\n', baseParameters.manualTk);
end

% set which function to test
% CB2, Wolfe, RosenSuzuki, Maxq20, Maxl20, Hilbert50, Goffin50
TestFunction = RosenSuzuki;


m1 = baseParameters.m1;
rangeOfM2 = rangeOfM2(rangeOfM2>=m1);
funcCalls = zeros(length(rangeOfM2),length(rangeOfM3));
subgradCalls = zeros(length(rangeOfM2),length(rangeOfM3));
nulls = zeros(length(rangeOfM2),length(rangeOfM3));
advancers = zeros(length(rangeOfM2),length(rangeOfM3));

%Iterate the Parameters
%needs a default profile with >7 possible workers
c = parcluster;
matlabpool(c, 8);
for i = 1:length(rangeOfM2)
    m2 = rangeOfM2(i);
    parfor j = 1:length(rangeOfM3)
        m3 = rangeOfM3(j);
        if(m2>=m1)
            fprintf('Starte: m2 =  %.3f, m3 = %.3f \n', m2,m3);

            currentParameter = baseParameters;
            currentParameter.m2 = m2;
            currentParameter.m3 = m3;

            [Xs, FXs, xStar, advanceSteps, nullSteps, error, errorValue, errorHistoryFiber, errorHistoryValue, funcCall, subgradCall] = ...
                Tester ( TestFunction, currentParameter, outputProperties);

            funcCalls(i,j) = funcCall;
            subgradCalls(i,j) = subgradCall;
            nulls(i,j) = nullSteps;
            advancers(i,j) = advanceSteps;
        end
    end
end
matlabpool close;

%plotting Section
ratio = advancers ./ nulls;
ratio(isnan(ratio)) = 0;

figure('Name', 'Funktionsaufrufe', 'NumberTitle','off');
bar3c(funcCalls');
xlabel('m2');
ylabel('m3');
set(gca,'Xtick',1:length(rangeOfM2),'XTickLabel',rangeOfM2)
set(gca,'Ytick',1:length(rangeOfM3),'YTickLabel',rangeOfM3)

figure('Name', 'Nullschritte', 'NumberTitle','off');
bar3c(nulls');
xlabel('m2');
ylabel('m3');
set(gca,'Xtick',1:length(rangeOfM2),'XTickLabel',rangeOfM2)
set(gca,'Ytick',1:length(rangeOfM3),'YTickLabel',rangeOfM3)


figure('Name', 'Abstiegsschritte', 'NumberTitle','off');
bar3c(advancers');
xlabel('m2');
ylabel('m3');
set(gca,'Xtick',1:length(rangeOfM2),'XTickLabel',rangeOfM2)
set(gca,'Ytick',1:length(rangeOfM3),'YTickLabel',rangeOfM3)


figure('Name', 'Abstiegsschritte pro Nullschritt', 'NumberTitle','off');
bar3c(ratio');
xlabel('m2');
ylabel('m3');
set(gca,'Xtick',1:length(rangeOfM2),'XTickLabel',rangeOfM2)
set(gca,'Ytick',1:length(rangeOfM3),'YTickLabel',rangeOfM3)





%---------------Available Functions----------------
% [meshX,meshY] = meshgrid(0:0.01:2.5,-0.5:0.01:1.5);
% cb2 = CB2;
% Tester2D( cb2, parameterObj1, meshX, meshY, outputProperties );
% 
% [meshX,meshY] = meshgrid(-1.6:0.1:6,-5:0.1:5);
% wolfe = Wolfe;
% Tester2D( wolfe, parameterObj1, meshX, meshY, outputProperties );

% [meshX,meshY] = meshgrid(-1:0.01:2,-1:0.01:3);
% rosenSuzuki2 = RosenSuzuki2;
% Tester2D( rosenSuzuki2, parameterObj1, meshX, meshY, outputProperties);
% 
% %------------Higher Dimensions------------
% rosenSuzuki = RosenSuzuki;
% Tester( rosenSuzuki, parameterObj1, outputProperties);
% 
% maxq20 = Maxq20;
% Tester(maxq20, parameterObj1, outputProperties);
% 
% maxl20 = Maxl20;
% Tester(maxl20, parameterObj1, outputProperties);
% 
% hilbert50 = Hilbert50;
% Tester(hilbert50, parameterObj1, outputProperties);
% 
% goffin50 = Goffin50;
% Tester(goffin50, parameterObj1, outputProperties);
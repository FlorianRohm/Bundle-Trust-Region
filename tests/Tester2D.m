function Tester2D( funct, start, minimum, params )
%Tester Tests the given function with Bundle Trust Region
%functions should increment functionCalls Variable

global functionCalls;
global sgradCalls;

functionCalls =0;
sgradCalls = 0;

fprintf('Measurement for %s\n\n',func2str(funct));

[xStar, Xs, advanceSteps, nullSteps] = BundleTrustRegion(funct, start, params);

fprintf('\nStartpunkt: [%f %f]\n',start(1), start(2));
fprintf('Endpunkt: [%.4f %.4f]\n\n',xStar(1), xStar(2));

error = xStar - minimum;
fprintf('Fehler: [%.4e %.4e]\n',error(1), error(2));

subgradientAtxStar = Subgradient(funct,xStar);
fprintf('Ein Subgradient im approx. Optimum: [%f %f]\n\n',subgradientAtxStar(1), subgradientAtxStar(2));

fprintf('Funktionsaufrufe: %d\n', functionCalls);
fprintf('Subgradientenauswertungen: %d\n\n', sgradCalls);

fprintf('Abstiegsschritte gesamt: %d\n', advanceSteps);
fprintf('Nullschritte gesamt: %d\n\n', nullSteps);

functionCalls = 0;
sgradCalls = 0;

figure
[x,y] = meshgrid(-2:0.3:6,-5:0.3:5);
z = funct(x,y);
contour(x,y,z,15);

PointX = Xs(1,:);
PointY = Xs(2,:);

hold on;
plot(PointX, PointY, 'Color', 'green');
hold off;
disp('-------------------------------------------------------------------');
end


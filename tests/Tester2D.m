function [Xs, FXs, xStar, advanceSteps, nullSteps, error, errorValue, errorHistoryFiber, errorHistoryValue, funcCalls, subgradCalls] = ...
    Tester2D( functionObject, parameterObject, meshX, meshY, outputPropertiesObj )
%Tester Tests the given function with Bundle Trust Region
%functions should increment functionCalls Variable

[Xs, FXs, xStar, advanceSteps, nullSteps, error, errorValue, errorHistoryFiber, errorHistoryValue, funcCalls, subgradCalls] = ...
   Tester ( functionObject, parameterObject, outputPropertiesObj);

figure('Name',['Plot für ', functionObject.name ' Funktion'],'NumberTitle','off')
z = functionObject.getValueForPlot(meshX,meshY);
contour(meshX,meshY,z,30);

PointX = Xs(1,:);
PointY = Xs(2,:);

hold on;
plot(PointX, PointY, 'Color', 'green');
hold off;
end


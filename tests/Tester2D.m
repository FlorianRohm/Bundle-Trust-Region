function Tester2D( funct, start, minimum, params, meshX, meshY )
%Tester Tests the given function with Bundle Trust Region
%functions should increment functionCalls Variable
Xs = Tester ( funct, start, minimum, params );

figure
z = funct(meshX,meshY);
contour(meshX,meshY,z,30);

PointX = Xs(1,:);
PointY = Xs(2,:);

hold on;
plot(PointX, PointY, 'Color', 'green');
hold off;
end


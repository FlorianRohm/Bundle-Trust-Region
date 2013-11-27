function PlotErrors3( functionName, fifo, le, ru )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

figure('Name',['Fehlerverlauf im Urbild bei ', functionName],'NumberTitle','off')
semilogy(fifo,'-g*');
hold on;
semilogy(le,'-bo');
semilogy(ru,'-r+');
legend('FiFo','Largest Error','Random','Location','NorthEast')
hold off;

end
function PlotErrors( functionName, fifo,r_fifo, le, r_le, ru, r_ru )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

figure('Name',['Fehlerverlauf im Urbild bei ', functionName],'NumberTitle','off')
semilogy(fifo,'-g+');
hold on;
semilogy(r_fifo,'-go');
semilogy(le,'-b+');
semilogy(r_le,'-bo');
semilogy(ru,'-r+');
semilogy(r_ru,'-ro');
legend('FiFo', 'Fifo mit Rundung','Largest Error','Largest Error mit Rundung','Random','Random mit Rundung','Location','NorthEast')
hold off;

end


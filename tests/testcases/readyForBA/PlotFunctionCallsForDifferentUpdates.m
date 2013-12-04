
%break condition test v

Fifo_v =[67, 106, 90, 159, 208, 148];
FifoRundung_v = [59, 69, 139, 173, 208, 189];
le_v = [62, 69, 102, 173, 144, 139];
leRundung_v = [89, 63, 75, 170, 139, 173];
random_v = [84, 82, 121, 175, 148, 224];
randomRundung_v = [62, 84, 135, 170, 162, 212];

figure('Name','Funktionsaufrufe','NumberTitle','off');
plot(Fifo_v,'-g+');
hold on;
plot(FifoRundung_v,'-go');
plot(le_v,'-b+');
plot(leRundung_v,'-bo');
plot(random_v,'-r+');
plot(randomRundung_v,'-ro');
legend('FiFo', 'FiFo mit Rundung','Größter Fehler','Größter Fehler mit Rundung','Random','Random mit Rundung','Location','NorthEast')
hold off;

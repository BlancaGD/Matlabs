

%% Todos los ensayos

figure;plot([PT22]','-*');
grid on;
title('P remanso antes de la tobera respecto a P regulada');
ylabel('Presi�n');
xlabel('Tiempo(s)');

hold on;
plot([PT04],'-*');
legend('PT22','PT04');
hold off;

%% Mach-tiempo antes de la tobera

figure;plot([M6p]','-*');
grid on;
title('Mach antes de la tobera');
ylabel('Mach');
xlabel('Tiempo(s)');

%% Di�metro cr�tico

figure;plot([d_star_]','-*');
grid on;
title('Di�metro cr�tico');
ylabel('Di�metro');
xlabel('Tiempo(s)');
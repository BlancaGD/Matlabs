

%% Todos los ensayos

figure;plot([PT22]','-*');
grid on;
title('P remanso antes de la tobera respecto a P regulada');
ylabel('Presión');
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

%% Diámetro crítico

figure;plot([d_star_]','-*');
grid on;
title('Diámetro crítico');
ylabel('Diámetro');
xlabel('Tiempo(s)');
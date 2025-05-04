clc; 
clear; 

% Load data
data1 = load('top_p_TM2Cav1.xy');
data2 = load('top_p_TM2Cav2.xy'); 
data3 = load('top_p_TM2Cav3.xy');


% Extract pressure (4th column)
pressure1 = data1(:, 4);
pressure2 = data2(:, 4);
pressure3 = data3(:, 4);
% Extract x positions
x1 = data1(:, 1);
x2 = data2(:, 1);
x3 = data3(:, 1);

% Plot with darker line colors
figure;
plot(x1, pressure1, 'Color', [0 0.447 0.741], 'LineWidth', 1.5); hold on;   % Dark Blue
plot(x2, pressure2, 'r', 'LineWidth', 1.5); hold on;   % Dark Blue
plot(x3, pressure3, 'g', 'LineWidth', 1.5); hold on;   % Dark Blue
xlabel('x distance (m)');
ylabel('Pressure (Pa)');
title('Pressure vs. x (Top) Mach 2');
legend('Cavity 1', 'Cavity 2', 'Cavity 3', Location='best')
grid on;


saveas(gcf, 'topM2.eps', 'epsc2')

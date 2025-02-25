% Load first dataset (20x20)
data1 = load('20x20_Re=10.txt'); % Ensure '20x20_Re=10.txt' is in the working directory
y1 = data1(:,2);  % y values
y1 = (y1 - min(y1)) / (max(y1) - min(y1)); % Normalize to [0,1]
u1 = data1(:,4);  % u values
v1 = data1(:,5);  % v values

% Load second dataset (80x80)
data2 = load('vert_center_U (80x80).xy'); % Ensure the file is in the working directory
y2 = data2(:,2);  % y values
y2 = (y2 - min(y2)) / (max(y2) - min(y2)); % Normalize to [0,1]
u2 = data2(:,4);  % u values
v2 = data2(:,5);  % v values

% Load third dataset (40x40)
data3 = load('40x40_RE=10.txt'); % Ensure the file '40x40_RE=10.txt' is in the working directory
y3 = data3(:,2);  % y values
y3 = (y3 - min(y3)) / (max(y3) - min(y3)); % Normalize to [0,1]
u3 = data3(:,4);  % u values
v3 = data3(:,5);  % v values

% Load fourth dataset (160x160)
data4 = load('center_U(160x160).xy'); % Ensure the file '160x160_RE=10.txt' is in the working directory
y4 = data4(:,2);  % y values
y4 = (y4 - min(y4)) / (max(y4) - min(y4)); % Normalize to [0,1]
u4 = data4(:,4);  % u values
v4 = data4(:,5);  % v values

% Create a large figure for u-velocity
figure('Name', 'ũ Velocity Comparison', 'Position', [100, 100, 1000, 600]);
plot(y1, u1, '-o', 'LineWidth', 1.5, 'DisplayName', 'ũ (20x20)');
hold on;
plot(y2, u2, '-s', 'LineWidth', 1.5, 'DisplayName', 'ũ (80x80)');
plot(y3, u3, '-^', 'LineWidth', 1.5, 'DisplayName', 'ũ (40x40)');
plot(y4, u4, '-d', 'LineWidth', 1.5, 'DisplayName', 'ũ (160x160)');
hold off;
xlabel('ỹ');
ylabel('ũ');
title('Comparison of ũ');
legend('Location', 'Best');
grid on;

% Create a large figure for v-velocity
figure('Name', 'ṽ Velocity Comparison', 'Position', [150, 150, 1000, 600]);
plot(y1, v1, '-o', 'LineWidth', 1.5, 'DisplayName', 'ṽ (20x20)');
hold on;
plot(y2, v2, '-s', 'LineWidth', 1.5, 'DisplayName', 'ṽ (80x80)');
plot(y3, v3, '-^', 'LineWidth', 1.5, 'DisplayName', 'ṽ (40x40)');
plot(y4, v4, '-d', 'LineWidth', 1.5, 'DisplayName', 'ṽ (160x160)');
hold off;
xlabel('ỹ');
ylabel('ṽ');
title('Comparison of ṽ');
legend('Location', 'Best');
grid on;

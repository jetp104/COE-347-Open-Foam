% Load and parse the data
filename = 'URe110.txt'; % Replace with your actual filename
fileID = fopen(filename, 'r');
data = textscan(fileID, '%f (%f %f %f) (%f %f %f)', 'HeaderLines', 4);
fclose(fileID);

% Extract time and velocity components
time = data{1};  % Time values
u1 = data{2};    % u at Probe 0 (5.5, -0.5, 0)
v1 = data{3};    % v at Probe 0
u2 = data{5};    % u at Probe 1 (5.5, 0.5, 0)
v2 = data{6};    % v at Probe 1

% Given parameters
D = 1; % Characteristic length
U = 1; % Flow velocity (assumed, replace with actual value if known)

% Normalized quantities
t_norm = time / (D / U); 
u1_norm = u1 ./ U;
v1_norm = v1 ./ U;
u2_norm = u2 ./ U;
v2_norm = v2 ./ U;

% Plot results
fig1 = figure;
plot(t_norm, u1_norm, 'b', 'DisplayName', 'u/U at (5.5,-0.5)')
hold on;
plot(t_norm, u2_norm, 'r', 'DisplayName', 'u/U at (5.5,0.5)')
xlabel('Normalized Time t/(D/U)')
ylabel('u/U')
title('Time History of u/U')
legend;
grid on;
saveas(fig1, 'u_vs_time.eps', 'epsc'); % Save as EPS

fig2 = figure;
plot(t_norm, v1_norm, 'b', 'DisplayName', 'v/U at (5.5,-0.5)')
hold on;
plot(t_norm, v2_norm, 'r', 'DisplayName', 'v/U at (5.5,0.5)')
xlabel('Normalized Time t/(D/U)')
ylabel('v/U')
title('Time History of v/U')
legend;
grid on;
saveas(fig2, 'v_vs_time.eps', 'epsc'); % Save as EPS
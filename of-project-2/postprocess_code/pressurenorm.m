% Define known parameters
D = 1;          % Characteristic length
rho = 1;        % Density
U = 1;          % Velocity (assuming U = 1)

% Load pressure coefficient data
filename_pressure = 'pRe110.txt'; % Replace with actual filename
fileID = fopen(filename_pressure, 'r');
pressure_data = textscan(fileID, '%f %f %f', 'HeaderLines', 4);
fclose(fileID);

% Extract time and pressure values
time = pressure_data{1};  % Time values
p1 = pressure_data{2};    % Pressure at Probe 0 (5.5, -0.5, 0)
p2 = pressure_data{3};    % Pressure at Probe 1 (5.5, 0.5, 0)

% Normalize time
t_norm = time / (D / U);  % Time normalized by characteristic length and velocity

% Compute pressure coefficient Cp = p / (rho * U^2)
Cp1 = p1 / (rho * U^2);
Cp2 = p2 / (rho * U^2);

% Find peaks in Cp1 and Cp2
[peaks1, locs1] = findpeaks(Cp1);
[peaks2, locs2] = findpeaks(Cp2);

% Calculate period by finding the difference between peak locations (in normalized time)
period1 = mean(diff(time(locs1)));  % Period from Probe 0 (5.5, -0.5, 0)
period2 = mean(diff(time(locs2)));  % Period from Probe 1 (5.5, 0.5, 0)

% Calculate frequency (f = 1/P)
f1 = 1 / period1;
f2 = 1 / period2;

% Calculate Strouhal number (St = f * D / U)
St1 = f1 * D / U;
St2 = f2 * D / U;

% Display Strouhal numbers
fprintf('Strouhal number at Probe 0: %.4f\n', St1);
fprintf('Strouhal number at Probe 1: %.4f\n', St2);

% Plot results
fig3 = figure;
plot(t_norm, Cp1, 'b', 'DisplayName', 'p/(\rho U^2) at (5.5,-0.5)')
hold on;
plot(t_norm, Cp2, 'r', 'DisplayName', 'p/(\rho U^2) at (5.5,0.5)')
xlabel('Normalized Time t/(D/U)')
ylabel('p / (\rho U^2)')
title('Time History of p/(\rho*U^2)')
legend;
grid on;
saveas(fig3, 'p_vs_time.eps', 'epsc'); % Save as EPS

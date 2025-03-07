clc;
clear;

% Define cylinder radius
R = 0.5;

% List of data files
data_files = {'piover2_U.txt', 'piover2_UM.txt', 'piover2_UC.txt'};
titles = {'Original', 'Modified', 'Corrected'};

% Initialize arrays to store computed strain tensors and deltas
all_e_rr = [];
all_e_rtheta = [];
all_deltas = [];

for i = 1:length(data_files)
    % Load the data
    data = readmatrix(data_files{i});
    
    % Extract relevant columns
    x = data(:,1);   % x-coordinate
    y = data(:,2);   % y-coordinate
    u_x = data(:,4); % x-component of velocity
    u_y = data(:,5); % y-component of velocity
    
    % Compute the radial distance from the center
    t = sqrt(x.^2 + y.^2);
    s = t - R;
    
    % Ensure only values where s > 0 are considered (outside the cylinder)
    validIndices = s >= 0;
    s_valid = s(validIndices);
    
    % Compute velocity components in polar coordinates
    u_r = u_x(validIndices) .* cos(pi/2) + u_y(validIndices) .* sin(pi/2);
    u_theta = u_x(validIndices) .* sin(pi/2) + u_y(validIndices) .* cos(pi/2);
    
    % Compute rate of strain tensor
    s_step = s_valid(2) - s_valid(1); % Grid spacing
    
    % Compute e_rr (∂u_r / ∂r)
    e_rr = (-11 * u_r(1) + 18 * u_r(2) - 9 * u_r(3) + 2 * u_r(4)) / (6 * s_step);

    % Compute radial positions for the first four grid points
    r = 0.5 + s_valid(1:4);

    % Compute e_rtheta (r/2 * ∂/∂r (u_θ / r))
    e_rtheta = (r(1) / 2) * ( (-11 * (u_theta(1) / r(1)) + ...
                               18 * (u_theta(2) / r(2)) - ...
                                9 * (u_theta(3) / r(3)) + ...
                                2 * (u_theta(4) / r(4))) / (6 * s_step) );

    % Compute delta
    delta = 1 ./ sqrt(s_valid(2) * s_valid(3));
    
    % Store values for plotting
    all_e_rr = [all_e_rr; e_rr];
    all_e_rtheta = [all_e_rtheta; e_rtheta];
    all_deltas = [all_deltas; delta];
    
    % Display results
    disp(['File: ', data_files{i}]);
    disp(['e_rr = ', num2str(e_rr)]);
    disp(['e_rtheta = ', num2str(e_rtheta)]);
end

% Plot strain tensor components against deltas
gcf = figure;
hold on;
plot(all_deltas, all_e_rr, 'ro-', 'LineWidth', 1.5);
plot(all_deltas, all_e_rtheta, 'bs--', 'LineWidth', 1.5);
xlabel('1/\delta');
ylabel('Strain Tensor Components');
legend('e_{rr}', 'e_{r\theta}');
title('Strain Tensor Components vs Delta (\pi/)');
grid on;
hold off;
saveas(gcf, 'Piover4strain.eps', 'epsc');

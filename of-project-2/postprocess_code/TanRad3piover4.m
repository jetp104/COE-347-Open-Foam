clc;
clear;

% Define cylinder radius and diameter
R = 0.5;
D = 2 * R;  % Diameter of the cylinder

% Load the data
data_fine = readmatrix('threepiover4_U.txt');   % Fine mesh
data_medium = readmatrix('threepiover4_UM.txt'); % Medium mesh
data_coarse = readmatrix('threepiover4_UC.txt'); % Coarse mesh

% Function to compute velocity profiles in polar coordinates
function [s_valid, u_r, u_theta] = computeVelocity(data, theta, R)
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
    
    % Compute velocity components in polar coordinates
    s_valid = s(validIndices);
    u_r = u_x(validIndices) .* cos(theta) + u_y(validIndices) .* sin(theta);
    u_theta = u_x(validIndices) .* sin(theta) + u_y(validIndices) .* cos(theta);
end

% Compute velocity profiles for each dataset
theta = 3*pi/4;
[s_fine, u_r_fine, u_theta_fine] = computeVelocity(data_fine, theta, R);
[s_medium, u_r_medium, u_theta_medium] = computeVelocity(data_medium, theta, R);
[s_coarse, u_r_coarse, u_theta_coarse] = computeVelocity(data_coarse, theta, R);

% Plot all profiles on the same figure
figure;
hold on;

% Plot medium and coarse lines first
plot(s_medium, u_r_medium, 'g', 'LineWidth', 1.5);
plot(s_coarse, u_r_coarse, 'b', 'LineWidth', 1.5);
plot(s_medium, u_theta_medium, 'g--', 'LineWidth', 1.5);
plot(s_coarse, u_theta_coarse, 'b--', 'LineWidth', 1.5);

% Plot fine lines last to make them dominant
plot(s_fine, u_r_fine, 'r', 'LineWidth', 1.5);  % Increased LineWidth
plot(s_fine, u_theta_fine, 'r--', 'LineWidth', 1.5);  % Increased LineWidth

xlabel('s (Radial Distance from Surface)');
ylabel('Velocity Components');
legend('u_r Medium', 'u_r Coarse', 'u_\theta Medium', 'u_\theta Coarse', 'u_r Fine', 'u_\theta Fine', 'Location', 'east');
title('Velocity Profiles at \theta = 3\pi/4 for Different Mesh Resolutions');
grid on;
hold off;

% Save the figure
saveas(gcf, 'velocity_comparison_3pi4.eps', 'epsc');
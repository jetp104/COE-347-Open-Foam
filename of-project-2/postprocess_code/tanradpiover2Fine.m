clc;
clear;

% Load the data
data_pi_over_2 = readmatrix('piover2_U.txt'); 

% Define cylinder radius
R = 0.5;

% Function to compute and plot velocity profiles on the same graph
function computeVelocityAndStrain(data, theta, R, titleStr)
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
    u_r = u_x(validIndices) .* cos(theta) + u_y(validIndices) .* sin(theta);
    u_theta = u_x(validIndices) .* sin(theta) + u_y(validIndices) .* cos(theta);
    s_valid = s(validIndices);
    
    % Scale u_theta for better visualization
    
    
    % Plot both velocities on the same graph
    gcf = figure;
    plot(s_valid, u_r, 'r', 'LineWidth', 1.5); hold on;
    plot(s_valid, u_theta, 'b', 'LineWidth', 1.5);
    xlabel('s (distance from cylinder surface)');
    ylabel('Velocity');
    legend('Radial Velocity (u_r)', 'Tangential Velocity (u_\theta)');
    title([titleStr, ' - Velocity Profiles (Fine)']);
    grid on;
    hold off;
    saveas(gcf, 'Piover2F.eps', 'epsc');

end

% Compute velocity and strain for each angle
computeVelocityAndStrain(data_pi_over_2, pi/2, R, 'Velocity and Strain at \theta = \pi/2');

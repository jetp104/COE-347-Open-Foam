% Define collected values of N and C from simulations
N_values = [400, 1600, 6400, 25600];  % Example grid sizes
C_values = [0.0006, 0.00145, 0.0074, 0.057337];  % Example wallclock times per step

% Log transformation
logN = log(N_values);
logC = log(C_values);

% Fit a linear model: logC = α * logN + logβ
p = polyfit(logN, logC, 1);
alpha = p(1);  % The slope corresponds to α

% Plot Log-Log Graph
figure;
loglog(N_values, C_values, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Number of Grid Points (N)');
ylabel('Wallclock Time per Step (C)');
title('Log-Log Plot of C vs. N');
grid on;

% Display estimated exponent
fprintf('Estimated exponent α: %.3f\n', alpha);

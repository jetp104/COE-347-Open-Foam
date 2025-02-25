% Load data from the provided files
files = {'top_UTallRe10.xy', 'second-row_UTallRe10.xy'; 
         'top_UTallRe100.xy', 'second-row_UTallRe100.xy';
         'top_UTallRe250.xy', 'second-row_UTallRe250.xy';
         'top_UTallRe400.xy', 'second-row_UTallRe400.xy'};

Re_values = [10, 100, 250, 400]; % Corresponding Reynolds numbers
Fe_values = zeros(size(Re_values)); % Store computed Fe for each Re

% Constants (ensure these are consistent with your data's units)
mu = 1; % Dynamic viscosity (in correct units)
U = 1; % Characteristic velocity (in correct units)
L = 0.1; % Characteristic length (in correct units)

% Set up the plot for τ_e vs. x̃
figure; hold on; grid on;
colors = lines(length(Re_values)); % Use distinct colors for different Re

for i = 1:length(Re_values)
    % Load data
    top_data = load(files{i,1}); % U velocity at the lid
    second_row_data = load(files{i,2}); % U velocity slightly below the lid

    % Extract x, y, and U values
    x_top = top_data(:,1); % x-coordinates
    U_top = top_data(:,4); % U velocity at the lid

    x_second = second_row_data(:,1); % x-coordinates
    U_second = second_row_data(:,4); % U velocity slightly below the lid
    
    y_top = top_data(:,2); % y-coordinate at the lid
    y_second = second_row_data(:,2); % y-coordinate slightly below the lid

    % Ensure x-coordinates match between top and second row data
    if ~isequal(x_top, x_second)
        error('Mismatch in x-coordinates between top and second row data.');
    end

    % Compute finite difference approximation of ∂U/∂y
    dy = y_top(1) - y_second(1); % Assuming uniform y-spacing
    if abs(dy) < 1e-6
        error('dy is too small or zero. Check your data.');
    end

    dU_dy = (U_top - U_second) / dy;

    % Nondimensionalize the velocity gradient
    dU_dy_nondim = dU_dy / (mu * U / L);  % Normalize by µU/L

    % Compute nondimensional stress τ_e
    tau_e = dU_dy_nondim;
    
    % Normalize x-coordinates to range from 0 to 1
    x_scaled = (x_top - min(x_top)) / (max(x_top) - min(x_top));

    % Compute nondimensional force Fe as integral of τ_e over x
    Fe_values(i) = trapz(x_scaled, tau_e); % Using trapezoidal numerical integration

    % Debugging outputs to check intermediate values
    fprintf('Re = %d\n', Re_values(i));
    fprintf('dy = %.6f\n', dy);
    fprintf('Range of tau_e: [%.6f, %.6f]\n', min(tau_e), max(tau_e));
    fprintf('Fe = %.6f\n', Fe_values(i));
    disp('------------------------------------');

    % Plot nondimensional stress τ_e vs. scaled x̃ along the lid
    plot(x_scaled, tau_e, 'Color', colors(i, :), 'LineWidth', 2, ...
         'DisplayName', sprintf('Re = %d', Re_values(i)));
end

% Finalize τ_e vs. x̃ plot
xlabel('x̃');
ylabel('τ_e');
title('Nondimensional Stress τ_e vs. x̃ along the Lid');
legend show;
hold off;

% Plot Fe vs. Re in a separate figure
figure;
plot(Re_values, Fe_values, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Reynolds Number (Re)');
ylabel('Nondimensional Force (Fe)');
title('Nondimensional Force Fe vs. Reynolds Number');
grid on;

% Load data from all file groups
file_groups = {
    {'top_UTallRe10.xy', 'second-row_UTallRe10.xy'; 
     'top_UTallRe100.xy', 'second-row_UTallRe100.xy';
     'top_UTallRe250.xy', 'second-row_UTallRe250.xy';
     'top_UTallRe400.xy', 'second-row_UTallRe400.xy'}, 'Tall';
     
    {'top_UShortRe10.xy', 'second-row_UShortRe10.xy'; 
     'top_UShortRe100.xy', 'second-row_UShortRe100.xy';
     'top_UShortRe250.xy', 'second-row_UShortRe250.xy';
     'top_UShortRe400.xy', 'second-row_UShortRe400.xy'}, 'Short';
     
    {'top_URe10.xy', 'second-row_URe10.xy'; 
     'top_URe100.xy', 'second-row_URe100.xy';
     'top_URe250.xy', 'second-row_URe250.xy';
     'top_URe400.xy', 'second-row_URe400.xy'}, 'Standard'
};

Re_values = [10, 100, 250, 400]; % Reynolds numbers
mu = 1; U = 1; L = 0.1; % Constants

% Set up a figure for τ_e vs. x̃
figure; hold on; grid on;
colors = lines(length(Re_values)); % Distinct colors for each Re
line_styles = {'-', '--', ':'}; % Different line styles for each dataset

Fe_all = zeros(length(file_groups), length(Re_values)); % Store Fe for all cases

for g = 1:length(file_groups)
    files = file_groups{g,1}; % Extract file set
    group_label = file_groups{g,2}; % Extract label
    linestyle = line_styles{g}; % Get line style

    for i = 1:length(Re_values)
        % Load data
        top_data = load(files{i,1});
        second_row_data = load(files{i,2});

        % Extract x, y, and U values
        x_top = top_data(:,1);
        U_top = top_data(:,4);
        x_second = second_row_data(:,1);
        U_second = second_row_data(:,4);
        y_top = top_data(:,2);
        y_second = second_row_data(:,2);

        % Ensure x-coordinates match
        if ~isequal(x_top, x_second)
            error('Mismatch in x-coordinates between top and second row data.');
        end

        % Compute finite difference approximation of ∂U/∂y
        dy = y_top(1) - y_second(1);
        if abs(dy) < 1e-6
            error('dy is too small or zero. Check your data.');
        end
        dU_dy = (U_top - U_second) / dy;

        % Nondimensionalize the velocity gradient
        dU_dy_nondim = dU_dy / (mu * U / L);

        % Compute nondimensional stress τ_e
        tau_e = dU_dy_nondim;

        % Normalize x-coordinates
        x_scaled = (x_top - min(x_top)) / (max(x_top) - min(x_top));

        % Compute nondimensional force Fe
        Fe_all(g, i) = trapz(x_scaled, tau_e);

        % Plot nondimensional stress τ_e vs. x̃
        plot(x_scaled, tau_e, 'Color', colors(i,:), 'LineWidth', 2, ...
             'LineStyle', linestyle, ...
             'DisplayName', sprintf('%s, Re = %d', group_label, Re_values(i)));
    end
end

% Finalize τ_e vs. x̃ plot
xlabel('x̃'); ylabel('τ_e');
title('Nondimensional Stress τ_e vs. x̃ along the Lid');
legend show; hold off;

% Plot Fe vs. Re in a separate figure
figure; hold on; grid on;
markers = {'o', 's', '^'}; % Different markers for each dataset

for g = 1:length(file_groups)
    plot(Re_values, Fe_all(g,:), ['-' markers{g}], 'LineWidth', 2, ...
         'MarkerSize', 8, 'DisplayName', file_groups{g,2});
end

xlabel('Reynolds Number (Re)');
ylabel('Nondimensional Force (Fe)');
title('Nondimensional Force Fe vs. Reynolds Number');
legend show; hold off;

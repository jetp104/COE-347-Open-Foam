clear;
data = readmatrix('line_U.txt'); 
x = data(:,1);   % x-coordinate
u_x = data(:,4); % x-component of velocity

% Find indices where ux changes sign
sign_change_indices = find(u_x(1:end-1) .* u_x(2:end) < 0);

% Interpolate to find more precise x values where ux crosses zero
x_crossings = x(sign_change_indices) - (u_x(sign_change_indices) ./ ...
               (u_x(sign_change_indices + 1) - u_x(sign_change_indices))) ...
               .* (x(sign_change_indices + 1) - x(sign_change_indices));

disp('X values where ux changes sign:');
disp(x_crossings);

L = (x_crossings(2) - 0.5) / 1

% Open the file for reading
fid = fopen('Re=10_20x20_contour.txt', 'r');

% Read data, ignoring parentheses
data = textscan(fid, '(%f %f %f)', 'Delimiter', ' ', 'MultipleDelimsAsOne', true);

% Close the file
fclose(fid);

% Extract velocity components
u = data{1}; % u values
v = data{2}; % v values
w = data{3}; % w values (not used for contour plot)

disp('u values:');
disp(data{1})  % Display u values

disp('v values:');
disp(data{2})  % Display v values

disp('w values:');
disp(data{3})  % Display w values


% Define grid dimensions (modify based on actual simulation grid)
n = sqrt(length(u)); % Assuming a square grid, adjust if needed

if mod(length(u), n) ~= 0
    error('Grid is not square, reshape manually!');
end

% Generate meshgrid for plotting
[X, Y] = meshgrid(linspace(0, 1, n), linspace(0, 1, n)); % Modify based on actual x, y range

% Reshape velocity data into 2D arrays for contour plotting
U = reshape(u, [n, n]);
V = reshape(v, [n, n]);

% Create contour plots
figure;
contourf(X, Y, U, 20); % Contour for u
colorbar;
title('Contour Plot of u');
xlabel('x');
ylabel('y');

figure;
contourf(X, Y, V, 20); % Contour for v
colorbar;
title('Contour Plot of v');
xlabel('x');
ylabel('y');

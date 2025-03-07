clc;
clear;

% Load the data directly without using 'run' variable
bp = readmatrix('back_p.txt');
fp = readmatrix('front_p.txt');
bu = readmatrix('back_U.txt');
fu = readmatrix('front_U.txt');

% Function to compute dy
function dy = compute_dy(da)
    xs = da(:, 2); % Assuming the second column represents x-coordinates
    dy = -diff(xs); % Compute differences
    dy = [dy; dy(end)]; % Append last element
end

% Function to compute integral
function result = integral(dx, v)
    result = dot(dx, v);
end

% Function to extract pressure
function p_vals = extract_p(da)
    p_vals = da(:, 4); % Assuming pressure is in the fourth column
end

% Function to compute UXT
function uxt = compute_UXT(da)
    ux = da(:, 4);
    uy = da(:, 5);
    uz = da(:, 6);
    u = sqrt(ux.^2 + uy.^2 + uz.^2);
    uxt = u .* ux;
end

% Compute forces
dfp = integral(compute_dy(fp), extract_p(fp)) - integral(compute_dy(bp), extract_p(bp));
dfu = integral(compute_dy(fu), compute_UXT(fu)) - integral(compute_dy(bu), compute_UXT(bu));
force = dfp + dfu;

% Display results
fprintf("Non-dimensionalized Force: %.6f\n", force);
fprintf("Cd: %.6f\n", 2 * force);

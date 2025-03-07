clear;
clc;
filename = 'UT0.05.txt'; % Replace with your actual filename
fileID = fopen(filename, 'r');
data = textscan(fileID, '%f (%f %f %f) (%f %f %f)', 'HeaderLines', 4);
fclose(fileID);


% Extract time and velocity components
time = data{1};  % Time values
u1 = data{2};    % u at Probe 0 (5.5, -0.5, 0)
v1 = data{3};    % v at Probe 0
u2 = data{5};    % u at Probe 1 (5.5, 0.5, 0)
v2 = data{6};    % v at Probe 1

% Given parameters
D = 1; % Characteristic length
U = 1; % Flow velocity (assumed, replace with actual value if known)

% Normalized quantities
t_norm = time / (D / U); 
u1_norm = u1 ./ U;
v1_norm = v1 ./ U;
u2_norm = u2 ./ U;
v2_norm = v2 ./ U;

% Function to calculate frequency and Strouhal number using peak detection
function [f, St] = calculateStrouhalPeak(time, data, D, U)
    % Find peaks in the data
    [pks, locs] = findpeaks(data, time, 'MinPeakProminence', 0.1); % Adjust prominence as needed
    
    % Calculate the period as the average time difference between peaks
    if length(locs) >= 2
        P = mean(diff(locs)); % Average period
        f = 1 / P;            % Frequency
        St = f * D / U;       % Strouhal number
    else
        error('Not enough peaks detected to calculate frequency.');
    end
end

% Calculate Strouhal number for u and v components using peak detection
[f_u1, St_u1] = calculateStrouhalPeak(time, u1_norm, D, U);
[f_u2, St_u2] = calculateStrouhalPeak(time, u2_norm, D, U);
[f_v1, St_v1] = calculateStrouhalPeak(time, v1_norm, D, U);
[f_v2, St_v2] = calculateStrouhalPeak(time, v2_norm, D, U);

% Display results
fprintf('Strouhal number for u1: %.4f (Frequency: %.4f Hz)\n', St_u1, f_u1);
fprintf('Strouhal number for u2: %.4f (Frequency: %.4f Hz)\n', St_u2, f_u2);
fprintf('Strouhal number for v1: %.4f (Frequency: %.4f Hz)\n', St_v1, f_v1);
fprintf('Strouhal number for v2: %.4f (Frequency: %.4f Hz)\n', St_v2, f_v2);
filename = 'My20x20.icoFoam';  % Adjust path if needed
fid = fopen(filename, 'r');

if fid == -1
    error('Error opening file. Check the file path or permissions.');
end

total_steps = 0;
total_time = 0;

while ~feof(fid)
    tline = fgetl(fid);
    
    % Look for lines that indicate time steps
    if contains(tline, 'Time =')
        total_steps = total_steps + 1;
    end
    
    % Look for wallclock time entries
    if contains(tline, 'ExecutionTime =')
        tokens = regexp(tline, 'ExecutionTime = ([\d.]+)', 'tokens');
        if ~isempty(tokens)
            total_time = str2double(tokens{1}{1});
        end
    end
end

fclose(fid);

% Compute wallclock time per step
C = total_time / total_steps;

% Display results
fprintf('Total Time Steps: %d\n', total_steps);
fprintf('Total Wallclock Time: %.4f s\n', total_time);
fprintf('Wallclock Time per Step (C): %.6f s\n', C);

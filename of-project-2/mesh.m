%% This is a meshmaker file


destinationname = 'blockMeshDict'; % Open source and destination files
sourcename = 'blockMeshDict.example';
destinationid = fopen(destinationname, 'w');
sourceid = fopen(sourcename, 'r');
linecount = 1;
%% Define mesh dimensions
Lf = 4;
Lw = 6;
R = 1;
H = 4;
dims = {'Lf', 'Lw', 'R', 'H'};
%% Print Description section
for k = 1:4
value = eval(dims{k});
fprintf(destinationid, '// %s = %d \n', dims{k}, value);
end

%% Print Preamble section
preamblestart = 12;
preambleend = 21;
for f = linecount:preamblestart-1
fgets(sourceid);
linecount = linecount + 1;
end

for g = linecount:preambleend
line = fgets(sourceid);
fprintf(destinationid, '%s', line);
linecount = linecount + 1;
end

%% Print Vertices section
fprintf(destinationid, 'vertices \n');
fprintf(destinationid, '( \n' );

Rad = R + 0.5;
for m = 0:63
if m >= 32
z = 0.05;
else
z = -0.05;
end
if 0 <= m && m <= 7 || 32 <= m && m <= 39
x = 0.5*cos(m*pi/4);
y = 0.5*sin(m*pi/4);
fprintf(destinationid, '   (%f  %f  %f) // %d \n', x, y, z, m);
continue;
elseif 8 <= m && m<= 15 || 40 <= m && m <= 47
x = Rad*cos(m*pi/4);
y = Rad*sin(m*pi/4);
fprintf(destinationid, '   (%f  %f  %f) // %d \n', x, y, z, m);
continue;
else
if ismember(m, [30, 31, 16, 17, 18, 62, 63, 48, 49, 50])
x = Lw;
end
if ismember(m, [22, 21, 20, 19, 18, 54, 53, 52, 51, 50])
y = H;
end
if ismember(m, [26, 25, 24, 23, 22, 58, 57, 56, 55, 54])
x = -Lf;
end
if ismember(m, [26, 27, 28, 29, 30, 58, 59, 60, 61, 62])
y = -H;
end
if ismember(m, [17, 49])
y = Rad*sin(pi/4);
end
if ismember(m, [19, 51])
x = Rad*cos(pi/4);
end
if ismember(m, [21, 53])
x = Rad*cos(3*pi/4);
end
if ismember(m, [23, 55])
y = Rad*sin(3*pi/4);
end
if ismember(m, [25, 57])
y = Rad*sin(5*pi/4);
end
if ismember(m, [27, 59])
x = Rad*cos(5*pi/4);
end
if ismember(m, [29, 61])
x = Rad*cos(7*pi/4);
end
if ismember(m, [31, 63])
y = Rad*sin(7*pi/4);
end
if ismember(m, [16, 48, 24, 56])
y = 0;
end
if ismember(m, [20, 52, 28, 60])
x = 0;
end
fprintf(destinationid, '   (%f  %f  %f) // %d \n', x, y, z, m);
end
end

fprintf(destinationid, '); \n');
fprintf(destinationid, '\n');

%% Print blocks section
blocks = {'(0 8 9 1 32 40 41 33)', '(1 9 10 2 33 41 42 34)', '(2 10 11 3 34 42 43 35)', '(3 11 12 4 35 43 44 36)', '(4 12 13 5 36 44 45 37)', '(5 13 14 6 37 45 46 38)', '(6 14 15 7 38 46 47 39)', '(7 15 8 0 39 47 40 32)', '(8 16 17 9 40 48 49 41)', '(9 17 18 19 41 49 50 51)', '(10 9 19 20 42 41 51 52)', '(11 10 20 21 43 42 52 53)', '(23 11 21 22 55 43 53 54)', '(24 12 11 23 56 44 43 55)', '(25 13 12 24 57 45 44 56)', '(26 27 13 25 58 59 45 57)', '(27 28 14 13 59 60 46 45)', '(28 29 15 14 60 61 47 46)', '(29 30 31 15 61 62 63 47)', '(15 31 16 8 47 63 48 40)'};
fprintf(destinationid, 'blocks \n');
fprintf(destinationid, '( \n');
fprintf(destinationid, '\n');
meshdims = zeros(12, 3);
w8 = 30;
w10 = 20;
w11 = 20;
w12 = 15;
w16 = 20;
w17 = 20;
h8 = 20;
h9 = 30;
h13 = 20;
h14 = 20;
h15 = 30;
h19 = 20;
meshdims(1,:) = [w8, h8, 1];
meshdims(2,:) = [w8, h9, 1];
meshdims(3,:) = [w10, h9, 1];
meshdims(4,:) = [w11, h9, 1];
meshdims(5,:) = [w12, h9, 1];
meshdims(6,:) = [w12, h13, 1];
meshdims(7,:) = [w12, h14, 1];
meshdims(8,:) = [w12, h15, 1];
meshdims(9,:) = [w16, h15, 1];
meshdims(10,:) = [w17, h15, 1];
meshdims(11,:) = [w8, h15, 1];
meshdims(12,:) = [w8, h19, 1];
grid = cell(12,1);
for ii = 1:12
grid{ii} = ['(' num2str(meshdims(ii,1)) ' ' num2str(meshdims(ii,2)) ' ' num2str(meshdims(ii,3)) ')'];
end
r = 10;
theta = 20;
circlemesh = ['(' num2str(r) ' ' num2str(theta) ' 1)'];
for n = 0:19
fprintf(destinationid, '   // block %d \n', n);
if n > 7
fprintf(destinationid, '   hex %s %s simpleGrading %s \n', blocks{n + 1}, grid{n - 7}, '(1 1 1)');
fprintf(destinationid, '\n');
else
fprintf(destinationid, '   hex %s %s simpleGrading %s \n', blocks{n + 1}, circlemesh, '(1 1 1)');
fprintf(destinationid, '\n');
end
end

fprintf(destinationid, '); \n \n');

%% Print edges section

fprintf(destinationid, 'edges \n');
fprintf(destinationid, '( \n \n');
arccell = cell(32,1);
nodelist = [0:1:15, 32:1:47];
phi = pi/8;

for jj = 1:32
if nodelist(jj) < 32
z = -0.05;
else
z = 0.05;
end

if 0 <= nodelist(jj) && nodelist(jj) <=7 || 32 <= nodelist(jj) && nodelist(jj) <= 39
x = 0.5*cos(phi);
y = 0.5*sin(phi);
else
x = Rad*cos(phi);
y = Rad*sin(phi);
end

if ismember(nodelist(jj), [7, 39, 15, 47])
if nodelist(jj) == 7
place = 0;
elseif nodelist(jj) == 39
place = 32;
elseif nodelist(jj) == 15
place = 8;
else 
place = 40;
end
string = ['( ' num2str(x) ' ' num2str(y) ' ' num2str(z) ')'];
arccell{jj} = [num2str(nodelist(jj)) ' ' num2str(place)];
fprintf(destinationid, 'arc %s %s \n', arccell{jj}, string);

phi = phi + pi/4;
continue;
end
string = ['( ' num2str(x) ' ' num2str(y) ' ' num2str(z) ')'];
arccell{jj} = [num2str(nodelist(jj)) ' ' num2str(nodelist(jj + 1))];
fprintf(destinationid, 'arc %s %s \n', arccell{jj}, string);
phi = phi + pi/4;
end

fprintf(destinationid, '\n ); \n \n');

%% Print boundary section
boundarystartline = 193;
boundaryendline = 260;

for i = linecount:boundarystartline-1 % Eliminate lines before boundary section from source
fgets(sourceid);
end

for j = boundarystartline:boundaryendline % Print lines into destination 
line = fgets(sourceid);
fprintf(destinationid, '%s', line);
end

fclose(sourceid); % Close destination and source documents
fclose(destinationid);

m = 1;
Point(1) = {0, 0, 0, 0.1*m}; Point(2) = {10, 0, 0, 0.1*m};
Point(3) = {10, 10, 0, 4*m}; Point(4) = {0, 10, 0, 4*m};

Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};

Curve Loop(1) = {1,2,3,4};
Plane Surface(1) = {1};
Mesh 2;

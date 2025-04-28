// New method with parameterized geometry
D = -1; C = -D; theta = Pi/64;
Point(1) = {5*D, 0, 0, 1};
Point(2) = {D, 0, 0, 1};
Point(3) = {0, 0, 0, 1};
Point(4) = {D*Sqrt(176)/15, C*7/15*Cos(theta/2), -C*7/15*Sin(theta/2), 1};
Point(5) = {15*D/16*Sqrt(176)/15,(C/2 - C/16)*Cos(theta/2), -(C/2 - C/16)*Sin(theta/2), 1};
Point(6) = {15*D/16*Sqrt(176)/15, C/2*Cos(theta/2), -C/2*Sin(theta/2), 1};
Point(7) = {0, C/2*Cos(theta/2), -C/2*Sin(theta/2), 1};
Point(8) = {0, 2.5*C*Cos(theta/2), -2.5*C*Sin(theta/2), 1};
Point(9) = {5*D, 2.5*C*Cos(theta/2), -2.5*C*Sin(theta/2), 1};

Line(1) = {1, 2};
Circle(2) = {2, 3, 4};
Circle(3) = {4, 5, 6};
Line(4) = {6, 7};
Line(5) = {7, 8};
Line(6) = {8, 9};
Line(7) = {9, 1};

Curve Loop(1) = {1, 2, 3, 4, 5, 6, 7};
Plane Surface(1) = {1};

Mesh.CharacteristicLengthMin = 0.01;
Mesh.CharacteristicLengthMax = 0.05;
Mesh.MshFileVersion = 2.2;

//Mesh 2;

Extrude { {1,0,0} , {0,0,0} , theta } {
    Surface{1}; Layers{1}; Recombine;
};


// Volume
Physical Volume("fluid") = {1};
// Surfaces
Physical Surface("IsoQ_walls") = {19,23,27};
Physical Surface("inlet") = {38};
Physical Surface("top") = {35};
Physical Surface("outlet") = {31};
Physical Surface("right") = {1};
Physical Surface("left") = {39};






Mesh 3;






//Mesh 3;
// old method
// // Import CAD
// Merge "IsoQ.step";
// 
// // Mesh sizing
// Mesh.CharacteristicLengthMin = 1;
// Mesh.CharacteristicLengthMax = 5;
// 
// // Mesh format
// Mesh.MshFileVersion = 2.0;
// // Volume
// Physical Volume("fluid") = {1};
// // Surfaces
// Physical Surface("IsoQ_walls") = {1,5,6};
// Physical Surface("inlet") = {2};
// Physical Surface("top") = {3};
// Physical Surface("outlet") = {4};
// Physical Surface("right") = {7};
// Physical Surface("left") = {8};
// 
// // Mesh
// Mesh 3;// change to 2 to mesh only the surfaces
//+
Show "*";

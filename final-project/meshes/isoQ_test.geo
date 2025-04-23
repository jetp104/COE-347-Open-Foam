// Import CAD
Merge "IsoQ.step";

// Mesh sizing
Mesh.CharacteristicLengthMin = 1;
Mesh.CharacteristicLengthMax = 5;

// Volume
Physical Volume("fluid") = {1};
// Surfaces
Physical Surface("IsoQ_walls") = {1,5,6};
Physical Surface("inlet") = {2};
Physical Surface("top") = {3};
Physical Surface("outlet") = {4};
Physical Surface("right") = {7};
Physical Surface("left") = {8};

// Mesh
Mesh 3;

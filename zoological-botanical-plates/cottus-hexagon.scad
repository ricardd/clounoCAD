include <BOSL2/std.scad>
$fn=100;

union(){
intersection(){
linear_extrude(1.4)
hexagon(ir=95, rounding=10);


import("../../../Documents/HueForge/WIP/Humboldt/Cottus-positive-standard_Front_200x95.stl");
}


difference(){
linear_extrude(1.4)
hexagon(ir=95, rounding=10);
cuboid([200,95,3]);
}
}


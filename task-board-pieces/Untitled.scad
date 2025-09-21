include<BOSL2/std.scad>
$fn=100;

cyl(l=4,r=20,chamfer1=2); 

translate([0,0,6])
cyl(l=4,r=20,chamfer=1); 

translate([0,0,12])
cyl(l=4,r=20,rounding=2); 

translate([0,0,18])
cyl(l=4,r=20,rounding=1); 


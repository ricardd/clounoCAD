include <BOSL2/std.scad>

$height=110;
$width=57;
$depth=57;

$hole_diameter=38;// to fit 3/4 inch tee

path_1 = [for(theta=[-90:1:90]) [$hole_diameter*cos(theta),$hole_diameter*sin(theta)]];
path_2 = [];

path = path_1;

cross_section = square(6);

path_sweep(cross_section, path);
